package com.qianfeng.dao;


import com.qianfeng.bean.Users;
import org.apache.ibatis.annotations.Param;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public interface UsersDao {
    Users selectUersByAccount(String account);
    public List<Users> selectByUsers(@Param(value ="start") int start,@Param(value ="size") int size);
    public int deleteById(int id);
    public void insertUsers(Users user);

    public void removeUser(ArrayList<Integer> list);
    List<Users> search(Map<String, String> map);
    int usersCount();
}
