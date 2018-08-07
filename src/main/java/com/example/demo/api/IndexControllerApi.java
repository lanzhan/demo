package com.example.demo.api;

import com.example.demo.bean.User;
import com.example.demo.bean.result.ResponseResult;
import com.example.demo.service.UserService;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

@RestController
@RequestMapping("api/user")
public class IndexControllerApi {

    @Resource
    private UserService userService;

    @PostMapping("/list")
    public ResponseResult findList(@RequestBody User user){
        PageInfo<User> list = userService.findList(user);
        return new ResponseResult<>(list);
    }

    @PostMapping("/insert")
    public ResponseResult insert(@RequestBody User user){
        userService.insert(user);
        return new ResponseResult();
    }

    @PostMapping("/update")
    public ResponseResult update(@RequestBody User user){
        userService.update(user);
        return new ResponseResult();
    }

    @GetMapping("delete")
    public ResponseResult delete(Integer id){
        userService.delete(id);
        return new ResponseResult();
    }

    @GetMapping("deleteIds")
    public ResponseResult deleteIds(String ids){
        userService.deleteIds(ids);
        return new ResponseResult();
    }
}
