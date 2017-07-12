package com.qianfeng.controller;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.session.HttpServletSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@Controller
public class LoginController {
    @RequestMapping("dologin.do")
    public String doLogin(String account, String pwd, HttpSession session){

        try {
            Subject subject = SecurityUtils.getSubject();
            UsernamePasswordToken token = new UsernamePasswordToken(account,pwd);
            subject.login(token);
            session.setAttribute("account",account);
            return "success";
        } catch (AuthenticationException e) {
            e.printStackTrace();
            return "index";
        }
    }
    @RequiresRoles("经理")
    @RequestMapping("toRole.do")
    @ResponseBody
    public String toRole(){

        return "toRole";
    }
    @RequestMapping("toLogin.do")
    public String toLogin()
    {
        return "index";
    }
    @RequestMapping("toNoqx.do")
    public  String toNoqx(){

        return  "noqx";
    }
}
