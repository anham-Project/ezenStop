package com.ezen709.ezenStop.service;

import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	public String getIdGrade(String reply_id) {
		String grade = sqlSession.selectOne("getIdGrade", reply_id) +"";
		return grade;
	}
	public String getIdLocation(String reply_id) {
		String grade = (String)sqlSession.selectOne("getIdLocation", reply_id);
		return grade;
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
		List<Ezen_memberDTO> al = sqlSession.selectList("getMemberDTO",id);
		return al;
	}
	public void dropId(String id) {
		sqlSession.delete("dropId",id);
	}
	public int insert_certification(Ezen_certificationDTO dto) {
		int res = sqlSession.insert("insert_certification",dto);
		return res;
	}
	public void member_upStatus(String id) {
		sqlSession.update("member_upStatus",id);
	}
	public Ezen_certificationDTO getFile(String id) {
		Ezen_certificationDTO dto = sqlSession.selectOne("getFile",id);
		return dto;
	}
	public void update_certification(String id,String image,int filesize) {
		Map map = new Hashtable();
		map.put("image",image);
		map.put("filesize",filesize);
		map.put("id",id);
		sqlSession.update("update_certification",map);
	}
	public List<Ezen_memberDTO> getMemberList(int startrow, int endrow){
		Map<String,Integer> map = new Hashtable<>();
		map.put("start", startrow);
		map.put("end", endrow);
		List<Ezen_memberDTO> list = sqlSession.selectList("getMemberList",map);
		return list;
	}
	public int memberGetCount() {
		int count = sqlSession.selectOne("memberGetCount");
		return count;
	}
	public int waittingMemberGetCount() {
		int count = sqlSession.selectOne("waittingMemberGetCount");
		return count;
	}
	public int id_check(String id) {
		int count = sqlSession.selectOne("id_check",id);
		return count;
	}
	public int emailCheck(String email) {
		int count = sqlSession.selectOne("emailCheck",email);
		return count;
	}
	public int searchMemberGetCount(String searchType, String searchString) {
		Map<String,String> map = new Hashtable();
		map.put("searchtype", searchType);
		map.put("searchstring", searchString);
		int count = sqlSession.selectOne("searchMemberGetCount",map);
		return count;
	}
	public List<Ezen_memberDTO> getWaittingMemberList(int startrow, int endrow) {
		Map<String,Integer> map = new Hashtable<>();
		map.put("start", startrow);
		map.put("end", endrow);
		List<Ezen_memberDTO> list = sqlSession.selectList("getWaittingMemberList",map);
		return list;
	}
	public List<Ezen_memberDTO> searchMember(String searchType, String searchString,int startrow, int endrow){
		Map map = new Hashtable();
		map.put("searchtype", searchType);
		map.put("searchstring", searchString);
		map.put("start", startrow);
		map.put("end", endrow);
		List<Ezen_memberDTO> list = sqlSession.selectList("searchMember",map);
		return list;
	}
	
	public void updateMember(String academyLocation,String id,int grade, int status) {
		Map map = new Hashtable();
		map.put("academyLocation",academyLocation);
		map.put("id",id);
		map.put("grade",grade);
		map.put("status",status);
		sqlSession.update("updateMember",map);
	}
	public List<String> getLocation(){
		return sqlSession.selectList("myBoardLocation");
	}
	public int myBoardGetCount(String id) {
		List<String> list = getLocation();
		int count = 0;
		for(String tableName : list) {
			Map<String,String> map = new Hashtable<String,String>();
			map.put("tableName", tableName);
			map.put("id",id);
			List<ReviewBoardDTO> result = sqlSession.selectList("myBoard",map);
			count += result.size();
		}
		return count;
	}
	public int search_myBoardGetCount(String id, String searchType, String searchString) {
		List<String> list = getLocation();
		int count = 0;
		for(String tableName : list) {
			Map<String,String> map = new Hashtable<String,String>();
			map.put("tableName", tableName);
			map.put("id",id);
			map.put("searchType", searchType);
			map.put("searchString", searchString);
			List<ReviewBoardDTO> result = sqlSession.selectList("search_myBoard",map);
			count += result.size();
		}
		return count;
	}
	public List<ReviewBoardDTO> myBoardList(String id, int start, int end) {
		List<String> list = getLocation();
		List<ReviewBoardDTO> boardList = new ArrayList<>();
		for(String tableName : list) {
			Map map = new Hashtable<>();
			map.put("tableName", tableName);
			map.put("id", id);
			List<ReviewBoardDTO> result = sqlSession.selectList("myBoard", map);
			for(ReviewBoardDTO dto : result) {
				boardList.add(dto);
			}
		}
		Collections.sort(boardList);
		List<ReviewBoardDTO> sortedList = new ArrayList<>();
		for(int i = start -1 ; i <= end -1 ; i++) {
			sortedList.add(boardList.get(i));
		}
		return sortedList;
	}
	public List<ReviewBoardDTO> search_myBoard(String id, String searchType, String searchString, int start, int end){
		List<String> list = getLocation();
		List<ReviewBoardDTO> boardList = new ArrayList<>();
		for(String tableName : list) {
			Map map = new Hashtable<>();
			map.put("tableName", tableName);
			map.put("id", id);
			map.put("searchType",searchType);
			map.put("searchString",searchString);
			List<ReviewBoardDTO> result = sqlSession.selectList("search_myBoard", map);
			for(ReviewBoardDTO dto : result) {
				boardList.add(dto);
			}
		}
		Collections.sort(boardList);
		List<ReviewBoardDTO> sortedList = new ArrayList<>();
		for(int i = start -1 ; i <= end -1 ; i++) {
			sortedList.add(boardList.get(i));
		}
		return sortedList;
	}
}
