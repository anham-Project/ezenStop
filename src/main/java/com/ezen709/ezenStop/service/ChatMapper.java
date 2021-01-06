package com.ezen709.ezenStop.service;

import java.text.SimpleDateFormat;
import java.util.Date;
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
		Date date = new Date();
		SimpleDateFormat format = new SimpleDateFormat("MM월 dd일 HH시 mm분 ss초");
		String time = format.format(date);
		map.put("chatTime", time);
		return sqlSession.insert("submitChat",map);
	}
	public List<ChatDTO> getMessageBox(String userId){
		Map<String,String> map = new Hashtable<>();
		map.put("userId", userId);
		return sqlSession.selectList("getMessageBox",map);
	}
	public int readChat(String fromId, String toId) {
		Map<String,String> map = new Hashtable<>();
		map.put("fromId", fromId);
		map.put("toId", toId);
		return sqlSession.update("readChat", map);
		
	}
	public int getAllUnreadChat(String userId) {
		return sqlSession.selectOne("getAllUnreadChat", userId);
		
	}
	public int getUnreadChat(String fromId, String toId) {
		Map<String,String> map = new Hashtable<>();
		map.put("fromId", fromId);
		map.put("toId", toId);
		return sqlSession.selectOne("getUnreadChat", map);
		
	}
}
