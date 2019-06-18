package com.onejune.controller;

import com.onejune.pojo.Manager;
import com.onejune.service.ManagerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;


@Controller
@RequestMapping("/admin")
public class ManagerController {
    private ManagerService managerService;

    @Autowired
    public void setManagerService(ManagerService managerService) {
        this.managerService = managerService;
    }

    /**
     * 去登录页面
     *
     * @return 登录页面
     */
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String toLogin() {
        return "admin/login";
    }

    /**
     * 登录方法
     *
     * @param session   session
     * @param loginName 账号
     * @param password  密码
     * @return 返回结果
     */
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    @ResponseBody
    public String login(HttpSession session, String loginName, String password) {
        session.removeAttribute("CurrentMember");//登录之前先清空session
        HashMap<String, Object> hashMap = managerService.login(loginName, password);
        if (!hashMap.isEmpty()) {
            String result = (String) hashMap.get("result");
            Manager manager = (Manager) hashMap.get("manager");
            if (manager != null) {
                session.setAttribute("CurrentManager", manager);
            }
            return result;
        } else {
            return "网络异常";
        }
    }

    /**
     * 退出登录
     *
     * @param session session
     * @return 重定向到登录页面
     */
    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:login";
    }

    /**
     * 转到主页面
     *
     * @return 转到主页面
     */
    @RequestMapping("/toMain")
    public String toMain() {
        return "admin/main";
    }

    /**
     * 查询notice
     *
     * @return 跳转到notice页面查询notice
     */
    @RequestMapping("/toNotice")
    public String toNotice() {
        return "redirect:../notice/allNotice";//跳转到查询所有notice的方法
    }

    @RequestMapping("/toGoods")
    public String toGoods() {
        return "redirect:../goods/findByConditions";//跳转到查询goods的方法
    }

    @RequestMapping("/toMember")
    public String toMember() {
        return "redirect:../member/findByCondition";//跳转到查询member的方法
    }

    @RequestMapping("/toOrder")
    public String toOrder() {
        return "redirect:../order/findByCondition";//跳转到查询order的方法
    }
}
