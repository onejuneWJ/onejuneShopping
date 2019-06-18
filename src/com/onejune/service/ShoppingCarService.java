package com.onejune.service;

import com.onejune.pojo.Shoppingcar;

import java.util.List;

public interface ShoppingCarService {
    String addShoppingCar(Shoppingcar shoppingcar);

    List<Shoppingcar> findByMemberId(Integer memberId);

    String delete(Integer id);
}
