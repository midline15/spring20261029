package com.example.demo.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.common.Message;
import com.example.demo.mapper.BoardMapper;
import com.example.demo.model.Board;

@Service
public class BoardService {
	@Autowired
	BoardMapper boardMapper;
	
	public HashMap<String, Object> getBoardList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap();
		try {
            map.put("limit", Integer.parseInt((String)map.get("limit")));
            map.put("offset", Integer.parseInt((String)map.get("offset")));
			List<Board> list = boardMapper.selectBoardList(map);
            int count = boardMapper.selectBoardCount(map);

			resultMap.put("list", list);
            resultMap.put("count", count);
			resultMap.put("result", "success");
		} catch (Exception e) {
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());
		}
		return resultMap;
	}

	public HashMap<String, Object> getBoard(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap();
		try {
			resultMap.put("info", boardMapper.selectBoard(map));
			resultMap.put("message", Message.DELETE_SUCCESS);
			resultMap.put("result", "success");
		} catch (Exception e) {
			resultMap.put("result", "fail");
			resultMap.put("message", Message.DELETE_FAIL);
			System.out.println(e.getMessage());
		}
		return resultMap;
	}
	
	public HashMap<String, Object> removeBoard(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap();
		try {
			int cnt = boardMapper.deleteBoard(map);
			resultMap.put("message", Message.DELETE_SUCCESS);
			resultMap.put("result", "success");
		} catch (Exception e) {
			resultMap.put("result", "fail");
			resultMap.put("message", Message.DELETE_FAIL);
			System.out.println(e.getMessage());
		}
		return resultMap;
	}
	
	public HashMap<String, Object> removeBoardAll(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap();
		try {
			int cnt = boardMapper.deleteBoardAll(map);
			resultMap.put("message", Message.DELETE_SUCCESS);
			resultMap.put("result", "success");
		} catch (Exception e) {
			resultMap.put("result", "fail");
			resultMap.put("message", Message.DELETE_FAIL);
			System.out.println(e.getMessage());
		}
		return resultMap;
	}

	public HashMap<String, Object> addBoard(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap();
		try {
			int cnt = boardMapper.insertBoard(map);
			resultMap.put("message", Message.INSERT_SUCCESS);
			resultMap.put("result", "success");
		} catch (Exception e) {
			resultMap.put("result", "fail");
			resultMap.put("message", Message.INSERT_FAIL);
			System.out.println(e.getMessage());
		}
		return resultMap;
	}

	public HashMap<String, Object> editBoard(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap();
		try {
			int cnt = boardMapper.updateBoard(map);
			resultMap.put("message", Message.UPDATE_SUCCESS);
			resultMap.put("result", "success");
		} catch (Exception e) {
			resultMap.put("result", "fail");
			resultMap.put("message", Message.UPDATE_FAIL);
			System.out.println(e.getMessage());
		}
		return resultMap;
	}
	
	
}