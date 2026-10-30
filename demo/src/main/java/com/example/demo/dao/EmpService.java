package com.example.demo.dao;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.mapper.EmpMapper;

@Service
public class EmpService {
	
	@Autowired
	EmpMapper empMapper;
	
	public HashMap<String, Object> getEmpList(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<>();
		try {
			
			resultMap.put("list", empMapper.selectEmpList(map));
			resultMap.put("gradeList", empMapper.selectGradeList(map));
			resultMap.put("result", "success");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}
	
	public HashMap<String, Object> removeEmp(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<>();
		empMapper.deleteEmp(map);
		
		resultMap.put("result", "success");
		return resultMap;
	}

	public HashMap<String, Object> addEmp(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<>();
		try {
			empMapper.insertEmp(map);		
			resultMap.put("result", "success");
		} catch (Exception e) {
			resultMap.put("result", "fail");
		}
		return resultMap;
	}

	public HashMap<String, Object> getEmp(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<>();
		
		try {
			resultMap.put("info", empMapper.selectEmp(map));
			resultMap.put("result", "success");
		} catch (Exception e) {
			resultMap.put("result", "fail");
		}
		return resultMap;
	}

	public HashMap<String, Object> getGradeList(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<>();
		try {
			
			resultMap.put("gradeList", empMapper.selectGradeList(map));
			resultMap.put("result", "success");
		} catch (Exception e) {
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}
}
