package com.example.demo.mapper;

import com.example.demo.bean.User;
import java.util.List;

public interface UserMapper {

     List<User> findList(User user);

    void insert(User user);

    void update(User user);

    void delete(Integer id);
}
