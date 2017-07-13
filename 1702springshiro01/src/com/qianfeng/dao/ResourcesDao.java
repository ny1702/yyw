package com.qianfeng.dao;

import com.qianfeng.bean.Resources;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface ResourcesDao {
    List<Resources> selectAllResources();
    List<Resources> selectQxByUser(int uid);
    void assignPermissions(Map<String, Object> map);
    void delteAllPermissions(int id);
}
