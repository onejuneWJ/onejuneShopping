package com.onejune.service;

import com.onejune.pojo.Goods;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import java.util.HashMap;
import java.util.List;

public interface GoodsService {

    List<Goods> findBySmallId(Integer smallId);

    Goods findById(Integer id);

    String update(Goods goods);

    String deleteGoods(Integer[] ids);

    List<Goods> findByConditions(String name, Integer bigType, Integer smallType, Integer sortOrder);

    String newGoods(Goods goods, Object... objects);
}
