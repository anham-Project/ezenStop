package com.ezen709.ezenStop.service;

import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen709.ezenStop.model.ChatDTO;
import com.ezen709.ezenStop.model.*;

@Service
public class LoginMapper {
	
	@Autowired
	private SqlSession sqlSession;
	
//	public List<ChatDTO> getChatListById(String fromId,String toId, String chatId){
//		Map<String,String> map = new Hashtable<>();
//		map.put("fromId1", fromId);
//		map.put("toId1", toId);
//		map.put("fromId2", toId);
//		map.put("toId2", fromId);
//		map.put("chatId", chatId);
//		return sqlSession.selectList("listChatContent",map);
//	}
	public int createMember(Ezen_memberDTO dto) {
		return sqlSession.insert("createMember", dto);
	}
	public List<Ezen_memberDTO> login(String id, String passwd) {
		Map<String,String> map = new Hashtable<>();
		map.put("id", id);
		map.put("passwd",passwd);
		return sqlSession.selectList("login", map);
	}
	public String find_id(String name, String email) {
		Map<String,String> map = new Hashtable<>();
		map.put("name", name);
		map.put("email", email);
		String id = sqlSession.selectOne("find_id",map);
		return id;
	}
	public int find_passwd(String name, String email, String id) {
		Map<String,String> map = new Hashtable<>();
		map.put("name", name);
		map.put("email", email);
		map.put("id",id);
		int count = sqlSession.selectOne("find_passwd",map);
		return count;
	}
	public String change_passwd(String id) {
		Map<String,String> map = new Hashtable<>();
		String passwd = String.valueOf((int)(Math.random()*900000+100000));
		map.put("passwd", passwd);
		map.put("id",id);
		sqlSession.update("change_passwd",map);
		return passwd;
	}
	public void change_passwd(String id,String passwd) {
		Map<String,String> map = new Hashtable<>();
		map.put("passwd", passwd);
		map.put("id",id);
		sqlSession.update("change_passwd",map);
	}
	public List<Ezen_memberDTO> getMemberDTO(String id) {
		List<Ezen_memberDTO> al = sqlSession.selectList("change_passwd",id);
		return al;
	}
	public void dropId(String id) {
		sqlSession.delete("change_passwd",id);
	}
	public int insert_certification() {
		int res=0;
		return res;
	}
	public Ezen_certificationDTO getFile(String id) {
		Ezen_certificationDTO dto = sqlSession.selectOne("getFile",id);
		return dto;
	}
	public void update_certification(String id,String image,int filesize) {
		sqlSession.update("update_certification");
	}

}
