package com.qianfeng.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.qianfeng.dao.ResourcesDao;

@Repository
public class ResourcesService {
    @Resource
    private ResourcesDao rd;
    public void fenp(ArrayList<Integer> idarr){
        int userid= idarr.get(0);
        //从集合中取出userid后，在删除该userid剩余的则是res.id
        idarr.remove(0);
        //把userid和res.id的值都存入map集合
        Map<String, Object> map=new HashMap<String, Object>();
        map.put("userid", userid);
        map.put("resid", idarr);
        int rows=-1;
        try {
            //在分配新的权限前。先删除该用户原来的所有权限
            rd.delteAllPermissions(userid);
            rows=1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        if(rows==1){
            rd.assignPermissions(map);
        }

    }
}
