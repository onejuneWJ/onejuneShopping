package com.onejune.service.impl;

import com.onejune.dao.GoodsDao;
import com.onejune.dao.ShoppingcarDao;
import com.onejune.pojo.Goods;
import com.onejune.pojo.Shoppingcar;
import com.onejune.pojo.ShoppingcarExample;
import com.onejune.service.ShoppingCarService;
import com.onejune.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("shoppingCarService")
public class ShoppingCarServiceImpl implements ShoppingCarService {

    private ShoppingcarDao shoppingcarDao;
    private GoodsDao goodsDao;
    private StringUtil stringUtil = new StringUtil();
    private ShoppingcarExample shoppingcarExample = new ShoppingcarExample();

    @Autowired
    public void setShoppingcarDao(ShoppingcarDao shoppingcarDao) {
        this.shoppingcarDao = shoppingcarDao;
    }

    @Autowired
    public void setGoodsDao(GoodsDao goodsDao) {
        this.goodsDao = goodsDao;
    }

    @Override
    public String addShoppingCar(Shoppingcar shoppingcar) {
        System.out.println(shoppingcar);
        shoppingcar.setId(stringUtil.getUUIDInt());
        if (shoppingcarDao.insertSelective(shoppingcar) > 0) {
            return "success";
        } else {
            return "failed";
        }
    }

    @Override
    public String delete(Integer id) {
        if (shoppingcarDao.deleteByPrimaryKey(id) > 0) {
            return "success";
        } else {
            return "failed";
        }
    }

    @Override
    public List<Shoppingcar> findByMemberId(Integer memberId) {
        shoppingcarExample.createCriteria().andMemberidEqualTo(memberId);
        List<Shoppingcar> shoppingCarList = shoppingcarDao.selectByExample(shoppingcarExample);
        shoppingcarExample.clear();
        for (Shoppingcar shoppingcar : shoppingCarList) {
            Goods goods = goodsDao.selectByPrimaryKey(shoppingcar.getGoodsid());
            shoppingcar.setGoods(goods);
        }
        return shoppingCarList;
    }
}
