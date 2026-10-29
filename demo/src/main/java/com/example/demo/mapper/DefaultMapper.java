package com.example.demo.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.model.User;

@Mapper
public interface DefaultMapper {

	List<User> selectUserList();
	
	int deleteUser(HashMap<String, Object> map);
}
