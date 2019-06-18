package com.onejune.interceptor;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GlobalInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {

        String path = httpServletRequest.getRequestURI();

        //如果没有管理员或者会员登录，增删改操作将户被拦截
        if (httpServletRequest.getSession().getAttribute("CurrentMember") != null||
                httpServletRequest.getSession().getAttribute("CurrentManager")!=null) {
            return true;
        }else {
            if (path.indexOf("delete") > 0 || path.indexOf("update") > 0 ||
                    path.indexOf("add") > 0 || path.indexOf("new") > 0
                    || path.indexOf("deliver") > 0) {

                System.out.println("增删改操作被拦截");
                return false;
            }
        }
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
