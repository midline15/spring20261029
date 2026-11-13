package com.example.demo.dao;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.demo.common.Message;
import com.example.demo.mapper.UserMapper;
import com.example.demo.model.User;

import jakarta.servlet.http.HttpSession;

@Service
public class UserService {

	@Autowired
	UserMapper userMapper;

	@Autowired
	PasswordEncoder passwordEncoder;

	@Autowired 
	HttpSession session;

	public HashMap<String, Object> login(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap();

		try {
			User user = userMapper.selectUser(map);


			if (user != null) {
				// 아이디가 있는 경우
				boolean login = passwordEncoder.matches((String) map.get("pwd"), user.getPwd());

				if(login){
					// 비밀번호 일치
					resultMap.put("loginFlg", true);
					resultMap.put("message", user.getUserName() + "님 환영합니다.");

					session.setAttribute("sessionId", user.getUserId());
					session.setAttribute("sessionName", user.getUserName());
					session.setAttribute("sessionRole", user.getRole());

					if(user.getRole().equals("A")){
						resultMap.put("url", "/product/list.do");
					}else{
						resultMap.put("url", "/board/list.do");
					}

					// session.invalidate(); // 세션 정보 삭제
					// session.setMaxInactiveInterval(0); // 유지시간
				} else {
					// 비밀번호 불일치
					resultMap.put("loginFlg", false);
					resultMap.put("message", Message.LOGIN_FAIL);
				}
			} else {
				// 아이디가 없는 경우
				resultMap.put("loginFlg", false);
				resultMap.put("message", Message.LOGIN_FAIL);
			}
			resultMap.put("result", "success");
		} catch (Exception e) {

			resultMap.put("result", "fail");
			resultMap.put("message", Message.DB_ERR);
			System.out.println(e.getMessage());
		}

		return resultMap;
	}

	public HashMap<String, Object> addUser(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap();

		try {

			// 비밀번호 암호화(해시)
			String hashPwd = passwordEncoder.encode((String) map.get("pwd"));
			System.out.println("해시 전 패스워드 : " + map.get("pwd"));
			System.out.println("해시 후 패스워드 : " + hashPwd);
			map.put("pwd", hashPwd);

			userMapper.insertUser(map);
			resultMap.put("message", Message.JOIN_SUCCESS);
			resultMap.put("result", "success");
		} catch (Exception e) {

			resultMap.put("result", "fail");
			resultMap.put("message", Message.JOIN_FAIL);
			System.out.println(e.getMessage());
		}

		return resultMap;
	}

	public HashMap<String, Object> editPwd(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap();

		try {

			// 비밀번호 암호화(해시)
			String hashPwd = passwordEncoder.encode((String) map.get("pwd"));
			map.put("pwd", hashPwd);

			userMapper.updatePwd(map);
			resultMap.put("message", Message.JOIN_SUCCESS);
			resultMap.put("result", "success");
		} catch (Exception e) {

			resultMap.put("result", "fail");
			resultMap.put("message", Message.JOIN_FAIL);
			System.out.println(e.getMessage());
		}

		return resultMap;
	}

	public String getPhone(HashMap<String, Object> map) {

		try {
			return userMapper.selectUser(map).getPhone();
		} catch (Exception e) {

			System.out.println(e.getMessage());
			return null;
		}

	}

}