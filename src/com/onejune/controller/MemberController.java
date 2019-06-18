package com.onejune.controller;

import com.onejune.pojo.Comment;
import com.onejune.pojo.Gorder;
import com.onejune.pojo.Member;
import com.onejune.service.CommentService;
import com.onejune.service.MemberService;
import com.onejune.service.OrderService;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("/member")
public class MemberController {

    private MemberService memberService;
    private OrderService orderService;
    private CommentService commentService;

    @Autowired
    public void setMemberService(MemberService memberService) {
        this.memberService = memberService;
    }

    @Autowired
    public void setOrderService(OrderService orderService) {
        this.orderService = orderService;
    }

    @Autowired
    public void setCommentService(CommentService commentService) {
        this.commentService = commentService;
    }

    /**
     * 向登录页面跳转
     */
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String toLogin() {
        return "login";
    }

    /**
     * 会员登录
     */
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    @ResponseBody
    public String login(String loginName, String password, HttpSession session) {
        HashMap<String, Object> hashMap = memberService.login(loginName, password);
        if (!hashMap.isEmpty()) {
            String result = (String) hashMap.get("result");
            Member member = (Member) hashMap.get("member");
            if (member != null) {
                member.setPassword(" ");
                session.setAttribute("CurrentMember", member);
            }
            return result;
        } else {
            return "网络异常";
        }
    }

    /**
     * 判断用户名是否重复
     *
     * @return 判断结果
     */
    @RequestMapping("/checkName/{name}")
    @ResponseBody
    public String checkName(@PathVariable String name) {
        return memberService.checkName(name);
    }

    /**
     * 判断手机号是否重复
     *
     * @return 判断结果
     */
    @RequestMapping("/checkPhone/{phone}")
    @ResponseBody
    public String checkPhone(@PathVariable String phone) {
        return memberService.checkPhone(phone);

    }

    @RequestMapping("/register")
    @ResponseBody
    public String register(Member member) {
        return memberService.register(member);
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        //清空Session
        session.invalidate();
        //重定向到向登录页面跳转方法
        return "redirect:login";
    }

    @RequestMapping(value = "/findByCondition", method = RequestMethod.GET)
    public String findByCondition(String condition, Model model) {
        List<Member> memberList = memberService.findByCondition(condition);
        model.addAttribute("condition", condition);
        model.addAttribute("memberList", memberList);
        return "admin/member";
    }

    @RequestMapping("/deleteMember/{id}")
    @ResponseBody
    public String deleteMember(@PathVariable Integer id) {
        return memberService.deleteById(id);
    }

    @RequestMapping("/toMain")
    public String toOrder(Integer memberid, Model model) {
        return "member/main";
    }

    @RequestMapping("/toInfo")
    public String toInfo() {
        return "member/info";
    }

    @RequestMapping("/toOrder")
    public String toOrder(Model model, HttpSession session) {
        Member member = (Member) session.getAttribute("CurrentMember");
        List<Gorder> orderList = orderService.findByMemberId(member.getId());
        model.addAttribute("orderList", orderList);
        return "member/order";
    }

    @RequestMapping("/toShoppingCar")
    public String toShoppingCar() {
        return "redirect:/shoppingCar/findByMemberId";
    }

    @RequestMapping("/uploadAvatar")
    @ResponseBody
    public String uploadAvatar(@RequestParam("avatar") CommonsMultipartFile commonsMultipartFile,
                               @RequestParam("memberId") Integer memberId,
                               HttpServletRequest request, HttpSession session) {
        if (commonsMultipartFile.getSize() > 0) {
            String path = request.getServletContext().getRealPath("/img/");
            HashMap<String, Object> map = memberService.uploadAvatar(commonsMultipartFile, memberId, path);
            String result = (String) map.get("result");
            if (result.equals("success")) {
                Member member = (Member) session.getAttribute("CurrentMember");
                Member _member = (Member) map.get("member");
                member.setAvatar(_member.getAvatar());
                session.setAttribute("CurrentMember", member);
            }
            return result;
        } else {
            return "failed";
        }

    }

    /**
     * 修改用户信息
     *
     * @param member  用户
     * @param session session
     * @return 修改结果
     */
    @RequestMapping("/updateInfo")
    @ResponseBody
    public String updateInfo(Member member, HttpSession session) {
        System.out.println(member);
        HashMap map = memberService.update(member);
        String result = (String) map.get("result");
        if (result.equals("success")) {
            //更新session的数据
            Member _member = (Member) map.get("member");//service传过来的member
            session.setAttribute("CurrentMember", _member);
        }
        return result;
    }

    /**
     * 修改密码时判断原始密码是否正确
     *
     * @param password 原始密码
     * @return 判断结果
     */
    @RequestMapping(value = "/checkPassword", method = RequestMethod.POST)
    @ResponseBody
    public String checkPassword(String password, Integer id) {
        return memberService.checkPassword(password, id);
    }

    @RequestMapping(value = "/addComment", method = RequestMethod.POST)
    @ResponseBody
    public String addComment(Comment comment) {
        System.out.println(comment);
        return commentService.addComment(comment);
    }
}
