package com.onejune.service;

import com.onejune.pojo.Gorder;

import java.util.List;

public interface OrderService {
    String addOrder(Gorder gorder);

    List<Gorder> findByCondition(String condition);

    List<Gorder> findByMemberId(Integer memberid);

    String delete(String[] ids);

    String deliver(String number);

    List<Gorder> findByConditions(String condition, Integer bigType, Integer smallType);
}
