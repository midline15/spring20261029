package com.example.demo.dao;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.mapper.ProfessorMapper;

@Service
public class ProfessorService {
	
	@Autowired
	ProfessorMapper professorMapper;
	
	public HashMap<String, Object> getProfessorList(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<>();
		try {
			resultMap.put("list", professorMapper.selectProfessorList(map));
			resultMap.put("deptList", professorMapper.selectDeptList(map));
			resultMap.put("result", "success");
		} catch (Exception e) {
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());
		}
		
		return resultMap;
	}
	
	public HashMap<String, Object> removeProfessor(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<>();
		professorMapper.deleteProfessor(map);
		
		resultMap.put("result", "success");
		return resultMap;
	}

	public HashMap<String, Object> addProfessor(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<>();
		professorMapper.insertProfessor(map);
		
		resultMap.put("result", "success");
		return resultMap;
	}

	public HashMap<String, Object> getProfessor(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<>();
		
		resultMap.put("info", professorMapper.selectProfessor(map));
		resultMap.put("result", "success");
		return resultMap;
	}
	
    public HashMap<String, Object> editProfessor(HashMap<String,Object> map) {
		HashMap<String, Object> resultMap = new HashMap<>();
		try {
			professorMapper.updateProfessor(map);
			resultMap.put("result", "success");
		} catch (Exception e) {
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());
		}
		return resultMap;
    }

	public HashMap<String, Object> getDeptList(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<>();
		resultMap.put("deptList", professorMapper.selectDeptList(map));
		resultMap.put("result", "success");
		
		return resultMap;
	}
}
