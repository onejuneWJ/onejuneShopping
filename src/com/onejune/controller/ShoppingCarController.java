package com.onejune.controller;

import com.onejune.pojo.Gorder;
import com.onejune.pojo.Member;
import com.onejune.pojo.Shoppingcar;
import com.onejune.service.OrderService;
import com.onejune.service.ShoppingCarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/shoppingCar")
public class ShoppingCarController {

    private ShoppingCarService shoppingCarService;
    private OrderService orderService;

    @Autowired
    public void setShoppingCarService(ShoppingCarService shoppingCarService) {
        this.shoppingCarService = shoppingCarService;
    }

    @Autowired
    public void setOrderService(OrderService orderService) {
        this.orderService = orderService;
    }

    @RequestMapping("/addShoppingCar")
    @ResponseBody
    public String addShoppingCar(Shoppingcar shoppingcar) {
        System.out.println(shoppingcar);
        return shoppingCarService.addShoppingCar(shoppingcar);
    }

    @RequestMapping("/findByMemberId")
    public String findByMemberId(Model model, HttpSession session) {
        Member member = (Member) session.getAttribute("CurrentMember");
        List<Shoppingcar> shoppingCarList = shoppingCarService.findByMemberId(member.getId());
        model.addAttribute("shoppingCarList", shoppingCarList);
        return "member/shoppingCar";
    }

    @RequestMapping("/delete")
    @ResponseBody
    public String delete(Integer id) {
        return shoppingCarService.delete(id);
    }

    @RequestMapping(value = "/buy", method = RequestMethod.POST)
    @ResponseBody
    @SuppressWarnings("unchecked")
    public String buy(@RequestBody Map<String, Object> map, HttpSession session) {
        ArrayList<Integer> ids = (ArrayList<Integer>) map.get("ids");//购物车id
        List<Float> amounts = (List<Float>) map.get("amounts");//订单金额
        ArrayList<Integer> quantities = (ArrayList<Integer>) map.get("quantities");//订单商品数量
        ArrayList<Integer> goodsIds = (ArrayList<Integer>) map.get("goodsIds");//商品id
        String address = (String) map.get("address");//地址

        Member member = (Member) session.getAttribute("CurrentMember");

        String result = "";
        //创建订单
        for (int i = 0; i < amounts.size(); i++) {

            Number num = amounts.get(i);
            int in = (int)num;
            float amount = (float) in;

            Integer quantity = quantities.get(i);
            Integer goodsId = goodsIds.get(i);
            Gorder order = new Gorder();
            order.setAmount(amount);
            order.setQuantity(quantity);
            order.setGoodsid(goodsId);
            order.setAddress(address);
            order.setMemberid(member.getId());
            order.setTel(member.getTel());
            result = orderService.addOrder(order);
        }

        //购买成功创建订单后删除购物车
        for (Integer id : ids) {
            result = shoppingCarService.delete(id);
        }

        return result;
    }
}
