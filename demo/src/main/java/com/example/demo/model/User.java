package com.example.demo.model;

import lombok.Data;
import lombok.Getter;

@Data
public class User {

    private String userId;
    private String pwd;
    private String userName;
    private String addr;
    private String role;
}
