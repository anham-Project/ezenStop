package com.ezen709.ezenStop.service;

import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen709.ezenStop.model.ChatDTO;

@Service
public class LoginMapper {
	
	@Autowired
	private SqlSession sqlSession;
	
	public List<ChatDTO> getChatListById(String fromId,String toId, String chatId){
		Map<String,String> map = new Hashtable<>();
		map.put("fromId1", fromId);
		map.put("toId1", toId);
		map.put("fromId2", toId);
		map.put("toId2", fromId);
		map.put("chatId", chatId);
		return sqlSession.selectList("listChatContent",map);
	}
	public void createMember(String id, String name, String email, String passwd) {
		Map<String,String> map = new Hashtable<>();
		map.put("email",email);
		map.put("id", id);
		map.put("name",name);
		map.put("passwd",passwd);
	}

}
