package com.ezen709.ezenStop.service;

import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen709.ezenStop.model.ChatDTO;

@Service
public class ChatMapper {
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
	public List<ChatDTO> getChatListByRecent(String fromId,String toId, int number){
		Map<String,String> map = new Hashtable<>();
		map.put("fromId1", fromId);
		map.put("toId1", toId);
		map.put("fromId2", toId);
		map.put("toId2", fromId);
		map.put("number", String.valueOf(number));
		return sqlSession.selectList("listRecentChatContent",map);
	}
	public int submit(String fromId,String toId, String chatContent){
		Map<String,String> map = new Hashtable<>();
		map.put("fromId", fromId);
		map.put("toId", toId);
		map.put("chatContent", chatContent);
		return sqlSession.insert("submitChat",map);
	}
}
