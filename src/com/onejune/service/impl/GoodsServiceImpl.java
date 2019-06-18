package com.onejune.service.impl;

import com.onejune.dao.GoodsDao;
import com.onejune.pojo.Goods;
import com.onejune.pojo.GoodsExample;
import com.onejune.service.GoodsService;
import com.onejune.utils.StringUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

@Service("goodsService")
@Transactional
public class GoodsServiceImpl implements GoodsService {

    private GoodsDao goodsDao;
    private GoodsExample goodsExample = new GoodsExample();
    private StringUtil stringUtil = new StringUtil();

    @Autowired
    public void setGoodsDao(GoodsDao goodsDao) {
        this.goodsDao = goodsDao;
    }


    @Override
    public List<Goods> findBySmallId(Integer smallId) {
        goodsExample.createCriteria().andSmalltypeEqualTo(smallId);
        List<Goods> goodsList = goodsDao.selectByExample(goodsExample);
        goodsExample.clear();
        return goodsList;
    }

    @Override
    public Goods findById(Integer id) {
        goodsExample.createCriteria().andIdEqualTo(id);
        List<Goods> goodsList = goodsDao.selectByExample(goodsExample);
        goodsExample.clear();
        return goodsList.isEmpty() ? null : goodsList.get(0);
    }

    @Override
    public String update(Goods goods) {
        goods.setBuytimes(goods.getBuytimes() + 1);
        return goodsDao.updateByPrimaryKeySelective(goods) > 0 ? "success" : "failed";
    }

    @Override
    public List<Goods> findByConditions(String name, Integer bigType, Integer smallType, Integer sortOrder) {
        GoodsExample.Criteria criteria = goodsExample.createCriteria();

        if (StringUtils.isNotBlank(name)) {
            name = "%" + name + "%";
        }
        if (StringUtils.isNotBlank(name)) {
            criteria.andNameLike(name);
        }
        if (bigType != null) {
            criteria.andBigtypeEqualTo(bigType);
        }
        if (smallType != null) {
            criteria.andSmalltypeEqualTo(smallType);
        }
        if (sortOrder != null) {
            switch (sortOrder) {
                case 1:
                    goodsExample.setOrderByClause("createTime desc");
                    break;
                case 2:
                    goodsExample.setOrderByClause("price asc");
                    break;
                case -2:
                    goodsExample.setOrderByClause("price desc");
                    break;
                case 3:
                    goodsExample.setOrderByClause("buyTimes desc");
            }
        }
        List<Goods> goodsList = goodsDao.selectByExample(goodsExample);
        goodsExample.clear();
        return goodsList;
    }

    /**
     * @param goods   商品
     * @param objects 可变参数，objects[0]为上传的图片，objects[1]为路径，两者同时存在同时不存在
     * @return 结果
     */
    @Override
    public String newGoods(Goods goods, Object... objects) {
        if (objects.length > 0) {//文件参数不为空
            CommonsMultipartFile multipartFile = (CommonsMultipartFile) objects[0];//获取文件
            String path = (String) objects[1];//路径
            System.out.println("路径:" + path);
            String filename = multipartFile.getOriginalFilename();//获取文件名
            filename = stringUtil.getUUIDStr() + stringUtil.getFileSuffix(filename);//以uuid的形式重命名该文件
            path += "goods/" + filename;//文件储存路径
            File newFile = new File(path);
            //如果文件路径不存在，就创建目录
            if (!newFile.exists()) {
                newFile.mkdirs();
            }

            try {
                multipartFile.transferTo(newFile);
                goods.setId(stringUtil.getUUIDInt());
                goods.setImg("/onejuneShopping/img/goods/" + filename);//如果文件上传成功，给goods设置图片路径储存到数据库
                goods.setCreatetime(stringUtil.getTime());//设置创建时间
                if (goodsDao.insertSelective(goods) > 0) {
                    return "success";
                } else {
                    return "failed";
                }
            } catch (IOException e) {
                e.printStackTrace();
                return "文件上传失败";
            }
        } else {
            goods.setId(stringUtil.getUUIDInt());
            goods.setCreatetime(stringUtil.getTime());
            if (goodsDao.insertSelective(goods) > 0) {
                return "success";
            } else {
                return "failed";
            }
        }
    }

    @Override
    public String deleteGoods(Integer[] ids) {
        int m = 0;//定义一个变量记录删除的商品数
        for (Integer id : ids) {
            //删除一条记录 m+1
            if (goodsDao.deleteByPrimaryKey(id) > 0) {
                m++;
            }
        }
        //如果删除数和传过来的id数量长度相等，删除成功
        return m == ids.length ? "success" : "failed";

    }
}
