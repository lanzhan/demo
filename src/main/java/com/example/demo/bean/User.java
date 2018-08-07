package com.example.demo.bean;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

@Data
public class User implements Serializable {

    private Integer id;

    private String name;

    private String address;

    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date birthday;

    private Integer page;

    private Integer pageSize;
}
