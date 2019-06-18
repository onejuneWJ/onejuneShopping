package com.onejune.service.impl;

import com.onejune.dao.GoodsDao;
import com.onejune.dao.GorderDao;
import com.onejune.dao.MemberDao;
import com.onejune.pojo.*;
import com.onejune.service.OrderService;
import com.onejune.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service("orderService")
@Transactional
public class OrderServiceImpl implements OrderService {

    private GorderDao gorderDao;
    private MemberDao memberDao;
    private GoodsDao goodsDao;
    private StringUtil stringUtil = new StringUtil();
    private GorderExample gorderExample = new GorderExample();
    private MemberExample memberExample = new MemberExample();
    private GoodsExample goodsExample = new GoodsExample();

    @Autowired
    public void setOrderDao(GorderDao gorderDao) {
        this.gorderDao = gorderDao;
    }

    @Autowired
    public void setMemberDao(MemberDao memberDao) {
        this.memberDao = memberDao;
    }

    @Autowired
    public void setGoodsDao(GoodsDao goodsDao) {
        this.goodsDao = goodsDao;
    }

    @Override
    public String addOrder(Gorder gorder) {
        gorder.setNumber(stringUtil.getNumber());
        gorder.setCreatetime(stringUtil.getTime());
        gorder.setDelivered(false);//未发货
        System.out.println(gorder);

        if (gorderDao.insertSelective(gorder) > 0) {
            return "success";
        } else {
            return "failed";
        }
    }

    @Override
    public List<Gorder> findByCondition(String condition) {
        //如果条件不为空
        if (condition != null && !condition.equals("")) {
            gorderExample.or().andAddressLike(condition);//地址

            //收货人
            memberExample.or().andNameLike("%" + condition + "%");
            List<Member> memberList = memberDao.selectByExample(memberExample);
            memberExample.clear();
            if (memberList.size() > 0) {
                for (Member member : memberList) {
                    gorderExample.or().andMemberidEqualTo(member.getId());
                }
            }

            //商品
            goodsExample.or().andNameLike("%" + condition + "%");
            List<Goods> goodsList = goodsDao.selectByExample(goodsExample);
            goodsExample.clear();
            if (goodsList.size() > 0) {
                for (Goods goods : goodsList) {
                    gorderExample.or().andGoodsidEqualTo(goods.getId());
                }
            }
        }
        List<Gorder> orderList = gorderDao.selectByExample(gorderExample);
        for (Gorder gorder : orderList) {
            Member member = memberDao.selectByPrimaryKey(gorder.getMemberid());
            Goods goods = goodsDao.selectByPrimaryKey(gorder.getGoodsid());
            gorder.setMember(member);
            gorder.setGoods(goods);
        }
        gorderExample.clear();
        return orderList;
    }

    @Override
    public String delete(String[] ids) {
        int m = 0;//定义一个变量记录删除的公告数
        for (String id : ids) {
            //删除一条记录 m+1
            if (gorderDao.deleteByPrimaryKey(id) > 0) {
                m++;
            }
        }
        if (m == ids.length) { //如果删除数和传过来的id数量长度相等，删除成功
            return "success";
        } else {
            return "failed";
        }
    }

    @Override
    public String deliver(String number) {
        Gorder gorder = new Gorder();
        gorder.setNumber(number);
        gorder.setDelivered(true);
        if (gorderDao.updateByPrimaryKeySelective(gorder) > 0) {
            return "success";
        } else {
            return "failed";
        }
    }

    /**
     * 查询某个会员的订单信息
     *
     * @param memberid 会员id
     * @return 订单列表
     */
    @Override
    public List<Gorder> findByMemberId(Integer memberid) {
        gorderExample.setOrderByClause("delivered asc");
        gorderExample.createCriteria().andMemberidEqualTo(memberid);
        List<Gorder> orderList = gorderDao.selectByExample(gorderExample);
        gorderExample.clear();
        for (Gorder gorder : orderList) {
            Goods goods = goodsDao.selectByPrimaryKey(gorder.getGoodsid());
            Member member = memberDao.selectByPrimaryKey(gorder.getMemberid());
            gorder.setMember(member);
            gorder.setGoods(goods);
        }
        return orderList;
    }

    @Override
    public List<Gorder> findByPage(int page, int offset) {
        gorderExample.setOrderByClause("delivered asc");
        if (page == 0) {
            gorderExample.setLimit(0);
        } else {
            gorderExample.setLimit(page * offset - 1);
        }
        gorderExample.setOffset((long) (offset));
        List<Gorder> gorderList = gorderDao.selectByExample(gorderExample);
        gorderExample.clear();
        return gorderList;
    }

    @Override
    public List<Gorder> findByConditions(String condition, Integer bigType, Integer smallType) {
        //select gorder.* from gorder,goods where gorder.goodsid=goods.id and goods.bigType=1;
        if (bigType != null) {
            List<Gorder> orderList = gorderDao.selectByBigType(bigType);
            for (Gorder gorder : orderList) {
                Goods goods = goodsDao.selectByPrimaryKey(gorder.getGoodsid());
                gorder.setGoods(goods);
            }
            return orderList;
        }
        //select gorder.* from gorder,goods where gorder.goodsid=goods.id and goods.bigType=1;
        if (smallType != null) {
            List<Gorder> gorderList=gorderDao.selectBySmallType(smallType);
            for (Gorder gorder : gorderList) {
                Goods goods = goodsDao.selectByPrimaryKey(gorder.getGoodsid());
                gorder.setGoods(goods);
            }
            return gorderList;
        }

        return null;
    }
}

