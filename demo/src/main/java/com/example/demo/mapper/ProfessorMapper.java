package com.example.demo.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.model.Professor;

@Mapper
public interface ProfessorMapper {
	
	//교수 목록
	List<Professor> selectProfessorList(HashMap<String, Object> map);
	
	//교수 삭제
	int deleteProfessor(HashMap<String, Object> map);

	int insertProfessor(HashMap<String, Object> map);

	Professor selectProfessor(HashMap<String, Object> map);

}
