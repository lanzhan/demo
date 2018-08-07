package com.example.demo.service.impl;


import com.example.demo.bean.User;
import com.example.demo.mapper.UserMapper;
import com.example.demo.service.UserService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Resource
    private UserMapper userMapper;

    @Override
    public PageInfo<User> findList(User user) {
        PageHelper.startPage(user.getPage(),user.getPageSize());
        List<User> list = userMapper.findList(user);
        return new PageInfo<User>(list);
    }

    @Override
    public void insert(User user) {
        userMapper.insert(user);
    }

    @Override
    public void update(User user) {
        userMapper.update(user);
    }

    @Override
    public void delete(Integer id) {
        userMapper.delete(id);
    }

    @Override
    public void deleteIds(String ids) {
        String[] Ids = ids.split(",");
        for (String Id : Ids) {
            userMapper.delete(Integer.parseInt(Id));
        }
    }
}
