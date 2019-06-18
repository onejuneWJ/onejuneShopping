package com.onejune.controller;

import com.onejune.pojo.Bigtype;
import com.onejune.pojo.Goods;
import com.onejune.pojo.Gorder;
import com.onejune.pojo.Smalltype;
import com.onejune.service.BigTypeService;
import com.onejune.service.GoodsService;
import com.onejune.service.OrderService;
import com.onejune.service.SmallTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/order")
public class OrderController {

    private OrderService orderService;
    private GoodsService goodsService;

    private BigTypeService bigTypeService;
    private SmallTypeService smallTypeService;

    @Autowired
    public void setOrderService(OrderService orderService) {
        this.orderService = orderService;
    }

    @Autowired
    public void setGoodsService(GoodsService goodsService) {
        this.goodsService = goodsService;
    }

    @Autowired
    public void setBigTypeService(BigTypeService bigTypeService) {
        this.bigTypeService = bigTypeService;
    }

    @Autowired
    public void setSmallTypeService(SmallTypeService smallTypeService) {
        this.smallTypeService = smallTypeService;
    }

    /**
     * 添加订单
     *
     * @param gorder 订单
     * @return 结果
     */
    @RequestMapping(value = "/addOrder", method = RequestMethod.GET)
    @ResponseBody
    public String addOrder(Gorder gorder) {
        String result = orderService.addOrder(gorder);
        if (result.equals("success")) {
            Goods goods = goodsService.findById(gorder.getGoodsid());
            //更新商品购买次数
            if (goodsService.update(goods).equals("failed")) {
                result = "failed";
            }
        }
        return result;
    }


    @RequestMapping(value = "/findByCondition", method = RequestMethod.GET)
    public String findByConditions(String condition, Model model, Integer bigType, Integer smallType) {
        List<Bigtype> bigtypeList = bigTypeService.findAll();//所有大类别，显示在大类别select里

        if (bigType == null) {
            bigType = 0;
        }
        List<Smalltype> smalltypeList = smallTypeService.findByBigid(bigType);

        List<Gorder> orderList = orderService.findByConditions(condition, bigType, smallType);

        model.addAttribute("orderList", orderList);
        model.addAttribute("condition", condition);
        model.addAttribute("bigtypeid", bigType);
        model.addAttribute("smalltypeid", smallType);
        model.addAttribute("bigtypeList", bigtypeList);
        model.addAttribute("smalltypeList", smalltypeList);
        return "admin/order";
    }

    @RequestMapping("/deleteOrder")
    @ResponseBody
    public String deleteOrder(String[] ids) {
        return orderService.delete(ids);
    }

    @RequestMapping(value = "/deliver/{number}", method = RequestMethod.GET)
    @ResponseBody
    public String deliver(@PathVariable String number) {
        return orderService.deliver(number);
    }

    /**
     * 分页
     *
     * @param page   第几页
     * @param offset 每页查询多少条
     * @return
     */
    @RequestMapping("/findByPage")
    public String findByPage(int page, int offset, Model model) {

        List<Gorder> orderList = orderService.findByPage(page, offset);
        model.addAttribute("orderList", orderList);
        model.addAttribute("currentPage", page);
        return "admin/order";

    }
}
