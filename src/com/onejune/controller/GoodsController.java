package com.onejune.controller;

import com.onejune.pojo.Bigtype;
import com.onejune.pojo.Comment;
import com.onejune.pojo.Goods;
import com.onejune.pojo.Smalltype;
import com.onejune.service.BigTypeService;
import com.onejune.service.CommentService;
import com.onejune.service.GoodsService;
import com.onejune.service.SmallTypeService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("/goods")
public class GoodsController {

    private GoodsService goodsService;
    private CommentService commentService;
    private BigTypeService bigTypeService;
    private SmallTypeService smallTypeService;

    @Autowired
    public void setGoodsService(GoodsService goodsService) {
        this.goodsService = goodsService;
    }

    @Autowired
    public void setCommentService(CommentService commentService) {
        this.commentService = commentService;
    }

    @Autowired
    public void setBigTypeService(BigTypeService bigTypeService) {
        this.bigTypeService = bigTypeService;
    }

    @Autowired
    public void setSmallTypeService(SmallTypeService smallTypeService) {
        this.smallTypeService = smallTypeService;
    }

    @RequestMapping("/findGoodsBySmallId/{smallId}")
    @ResponseBody
    public List<Goods> findGoodsBySmallId(@PathVariable Integer smallId) {
        return goodsService.findBySmallId(smallId);
    }

    /**
     * 查询所有小类别
     *
     * @param bigid 小类别所属大类别id
     * @return 小类别列表
     */
    @RequestMapping(value = "/findAllSmallType/{bigid}", method = RequestMethod.GET)
    @ResponseBody
    public List<Smalltype> findAllSmallType(@PathVariable Integer bigid) {
        return smallTypeService.findByBigid(bigid);

    }

    /**
     * 查询所有大类别
     *
     * @return 大类别列表
     */
    @RequestMapping(value = "/findAllBigType", method = RequestMethod.GET)
    @ResponseBody
    public List<Bigtype> findAllBigType() {
        return bigTypeService.findAll();
    }

    /**
     * 查看商品详细
     *
     * @param id    商品id
     * @param model model
     * @return 商品信息
     */
    @RequestMapping("/toGoodsDetails")
    public String toGoodsDetails(Integer id, Model model) {
        Goods goods = goodsService.findById(id);
        if (goods != null) {//查询到了商品
            model.addAttribute("goods", goods);
            List<Comment> commentList = commentService.findByGoodsId(id);//查询该商品评论
            if (commentList.size() > 0) {
                model.addAttribute("comments", commentList);
            }
        }
        return "goods";
    }

    /**
     * 管理员查询商品列表
     *
     * @param model     model
     * @param name      商品名称，如果需要按照商品名称查询
     * @param bigType   大类别，如果需要按照大类别查询
     * @param smallType 小类别，如果需要按照小类别查询
     * @param sortOrder 排序
     * @return 查询结果
     */
    @RequestMapping(value = "/findByConditions", method = RequestMethod.GET)
    public String findByConditions(Model model, String name, Integer bigType, Integer smallType, Integer sortOrder) {

        List<Goods> goodsList = goodsService.findByConditions(name, bigType, smallType, sortOrder);//条件查询商品列表

        List<Bigtype> bigtypeList = bigTypeService.findAll();//所有大类别，显示在大类别select里

        if (bigType == null) {
            bigType = 0;
        }
        List<Smalltype> smalltypeList = smallTypeService.findByBigid(bigType);

        model.addAttribute("goodsName", name);
        model.addAttribute("bigtypeid", bigType);
        model.addAttribute("smalltypeid", smallType);
        model.addAttribute("sortOrder", sortOrder);
        model.addAttribute("goodsList", goodsList);
        model.addAttribute("bigtypeList", bigtypeList);
        model.addAttribute("smalltypeList", smalltypeList);
        return "admin/goods";
    }

    /**
     * 查询商品列表
     *
     * @param name      商品名称，如果需要按照商品名称查询
     * @param bigType   大类别，如果需要按照大类别查询
     * @param smallType 小类别，如果需要按照小类别查询
     * @param sortOrder 排序
     * @return 查询结果
     */
    @RequestMapping(value = "/findByConditionsIndex", method = RequestMethod.GET)
    @ResponseBody
    public List<Goods> findByConditionsIndex(String name, Integer bigType, Integer smallType, Integer sortOrder) {

        return goodsService.findByConditions(name, bigType, smallType, sortOrder);//条件查询商品列表

    }

    /**
     * 新建商品
     *
     * @param multipartFile 商品图片
     * @param goods         商品
     * @param newSmallBigid 如果有新建小类别，这是小类别所属的大类别id
     * @param newSmallType  如果有新建小类别，这是新建的小类别名
     * @return 新建结果
     */
    @RequestMapping(value = "/newGoods", method = RequestMethod.POST)
    @ResponseBody
    public String newGoods(@RequestParam("file") CommonsMultipartFile multipartFile, Goods goods,
                           Integer newSmallBigid, String newSmallType, HttpServletRequest httpServletRequest) {
        System.out.println(goods);//商品
        System.out.println("大类id:" + newSmallBigid); //如果有新建小类别，这是小类别所属的大类别id
        System.out.println("小类名：" + newSmallType);//如果有新建小类别，这是新建的小类别名

        String result = "";

        //如果新建小类别，则执行新建小类别的方法
        if (newSmallBigid != null && !newSmallType.equals("")) {
            Smalltype smalltype = (Smalltype) smallTypeService.newSmallType(newSmallBigid, newSmallType);//查询当前新建的小类别
            goods.setSmalltype(smalltype.getId());//给商品的小类别赋值当前新建的小类别id
        }

        //判断上传的图片是否为空
        if (multipartFile.getSize() != 0) {
            String path = httpServletRequest.getServletContext().getRealPath("/img/");
            result = goodsService.newGoods(goods, multipartFile, path);//图片文件不为空时，把图片参数传进service层方法
        } else {
            result = goodsService.newGoods(goods);
        }
        System.out.println(result);
        return result;
    }

    @RequestMapping("/deleteGoods")
    @ResponseBody
    public String deleteGoods(Integer[] ids){
        return goodsService.deleteGoods(ids);
    }
}
