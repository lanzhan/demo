package com.example.demo.service;

import com.example.demo.bean.User;
import com.github.pagehelper.PageInfo;

public interface UserService {

    PageInfo<User> findList(User user);

    void insert(User user);

    void update(User user);

    void delete(Integer id);

    void deleteIds(String ids);
}
