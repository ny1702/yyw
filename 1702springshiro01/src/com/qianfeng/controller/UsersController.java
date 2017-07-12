package com.qianfeng.controller;

import com.qianfeng.bean.Users;
import com.qianfeng.dao.UsersDao;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class UsersController {
    @Resource
    private UsersDao udao;

    @RequestMapping("selectByUsers.do")
    @ResponseBody
    public List<Users> showUsers(int page) {
        int start=(page-1)*2;
        return udao.selectByUsers(start);
    }
    @RequestMapping("deleteById.do")
    @ResponseBody
    public int deleteById(int id) {
        int x=1;
        System.out.print(udao.deleteById(id));
        try{
            udao.deleteById(id);
        }catch(Exception e){
            e.printStackTrace();
            x=-1;
        }
        return x;
    }

    //多条数据删除
    @RequestMapping("removeUser.do")
    @ResponseBody
    public int removeUser(@RequestBody ArrayList<Integer> data) {
        int x=-1;
        try {
            System.out.print("前台传的数组"+data);
            udao.removeUser(data);
            x=1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return x;
    }
    @RequestMapping("search.do")
    @ResponseBody
    public List<Users> search(String type,String key) {
        Map<String,String> map=new HashMap<String, String>();
        map.put("type", type);
        map.put("key", "%"+key+"%");
        //System.out.println("key"+key+":"+type);
        return udao.search(map);

    }
    @RequestMapping("insertUsers.do")
    @ResponseBody
    public int insertUsers(Users users){
        int x=-1;
        try {
            udao.insertUsers(users);
            x=0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return x;
    }
}
