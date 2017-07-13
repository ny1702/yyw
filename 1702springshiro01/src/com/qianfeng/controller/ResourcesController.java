package com.qianfeng.controller;

import com.qianfeng.Service.ResourcesService;
import com.qianfeng.bean.Resources;
import com.qianfeng.bean.Users;
import com.qianfeng.dao.ResourcesDao;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
public class ResourcesController {
    @Resource
    private ResourcesDao rd;
    @Resource
    private ResourcesService rs;
    //查询所有资源
    @RequestMapping("seleteAllResource.do")
    @ResponseBody
    public List<Resources> seleteAllResource(){

        return rd.selectAllResources();
    }
    //根据用户查询资源
    @RequestMapping("selectQxByUser.do")
    @ResponseBody
    public List<Resources> selectQxByUser(HttpSession session){
        Users users =(Users)session.getAttribute("users");
       System.out.print("账户："+ users.getUid());
        return rd.selectQxByUser(users.getUid());
    }
    @RequestMapping("selectQxByUser1.do")
    @ResponseBody
    public List<Resources> selectQxByUser(@RequestParam(value="id") int id){
        System.out.println("我是前台传的ID："+ id);

        return rd.selectQxByUser(id);
    }
    @RequestMapping("assignPermissions.do")
    @ResponseBody
    public String assignPermissions(@RequestBody ArrayList<Integer> idarr){
        //从集合中取出userid
        rs.fenp(idarr);

        return "1";
    }
}
