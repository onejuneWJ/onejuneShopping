package com.onejune.interceptor;

import com.onejune.pojo.Member;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MemberInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        String path = httpServletRequest.getRequestURI();
        if (httpServletRequest.getSession().getAttribute("CurrentMember") != null) {
            return true;
        }

        if (httpServletRequest.getSession().getAttribute("CurrentManager") != null) {
            return true;
        }
        if (path.indexOf("login") > 0) {
            return true;
        }

        if (path.indexOf("register") > 0) {
            return true;
        }
        if (path.indexOf("check") > 0) {
            return true;
        }
        httpServletRequest.getRequestDispatcher("/WEB-INF/jsp/login.jsp")
                .forward(httpServletRequest, httpServletResponse);
        return false;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
