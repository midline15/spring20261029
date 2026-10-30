package com.example.demo.model;

import lombok.Getter;


public class User {

    private String userId;
    private String pwd;
    @Getter 
    private String userName;
    private String addr;
    private String role;
}
