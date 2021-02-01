package com.ezen709.ezenStop.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen709.ezenStop.model.*;
import java.util.*;

@Service
public class LJH_boardMapper {
	
	@Autowired
	private SqlSession sqlSession;
	
	public Map<String,Object> putMap(int article_num, String table){
		Map<String,Object> map = new Hashtable<>();
		map.put("tableName",table);
		map.put("article_num",article_num);
		return map;
	}
	
	public List<ReviewBoardDTO> A_list(String table,int start, int end){
		Map<String,Object> map = new Hashtable<>();
		map.put("tableName",table);
		map.put("start",start);
		map.put("end",end);
		List<ReviewBoardDTO> list = sqlSession.selectList("A_list",map);
		return list;
	}
	public List<ReviewBoardDTO> A_notice_list(String cate) {
		Map<String,Object> map = new Hashtable<>();
		map.put("category",cate);
		List<ReviewBoardDTO> noticeList = sqlSession.selectList("AllNotice_list");
		List<ReviewBoardDTO> list = new ArrayList<>();
		list = sqlSession.selectList("A_notice_list",map);
		if(list.size()>0) {
		for(int i = 0; i<list.size();i++) {
			ReviewBoardDTO dto = new ReviewBoardDTO();
			dto = list.get(i);
			noticeList.add(dto);
		}
		}
		return noticeList;
	}
	
	public int A_getCount(String table) {
		Map<String,Object> map = new Hashtable<>();
		map.put("tableName",table);
		return sqlSession.selectOne("A_getCount",map);
	}
	public int A_insert(ReviewBoardDTO dto, String table) {
		Map<String,Object> map = new Hashtable<>();
		map.put("category",dto.getCategory());
		map.put("subject",dto.getSubject());
		map.put("id",dto.getId());
		map.put("content",dto.getContent());
		map.put("detaillocation",dto.getDetaillocation());
		map.put("image",dto.getImage());
		map.put("filesize",dto.getFilesize());
		map.put("tableName",table);
		return sqlSession.insert("A_insert", map);
	}
	public void A_plusReadCount(int article_num,String table) {
		Map<String,Object> map = putMap(article_num, table);
		sqlSession.update("A_plusReadCount", map);
	}
	public ReviewBoardDTO A_detail(int article_num,String table) {
		Map<String,Object> map = putMap(article_num, table);
		return sqlSession.selectOne("A_detail", map);
	}
	public int A_delete(int article_num,String table) {
		Map<String,Object> map = putMap(article_num, table);
		return sqlSession.delete("A_delete", map);
	}
	public int A_fileDelete(int article_num,String table) {
		Map<String,Object> map = putMap(article_num, table);
		return sqlSession.delete("A_fileDelete", map);
	}
	public int A_edit(ReviewBoardDTO dto, String table) {
		System.out.println(table+"\n"+dto.getArticle_num());
		Map<String,Object> map = putMap(dto.getArticle_num(),table);
		map.put("category",dto.getCategory());
		map.put("subject",dto.getSubject());
		map.put("content",dto.getContent());
		map.put("image",dto.getImage());
		map.put("filesize",dto.getFilesize());
		return sqlSession.update("A_edit", map);
	}
	public int searchListGetCount(String table,String searchType, String searchString) {
		Map<String,String> map = new Hashtable<>();
		map.put("tableName",table);
		map.put("searchtype", searchType);
		map.put("searchstring", searchString);
		int count = sqlSession.selectOne("searchListGetCount",map);
		return count;
	}
	public List<ReviewBoardDTO> A_searchList(String table,String searchType, String searchString,int startrow, int endrow){
		Map map = new Hashtable();
		map.put("tableName",table);
		map.put("searchtype", searchType);
		map.put("searchstring", searchString);
		map.put("start", startrow);
		map.put("end", endrow);
		List<ReviewBoardDTO> list = sqlSession.selectList("A_searchList",map);
		return list;
	}
	public int changeVisibleStatus(int article_num, String table) {
		Map<String,Object> map = putMap(article_num, table);
		return sqlSession.update("A_changeVisibleStatus", map);
	}
	public void A_updateReplyCount(int article_num, int replyCount, String table) {
		Map<String,Object> map = putMap(article_num,table);
		map.put("replyCount", replyCount);
		sqlSession.update("A_updateReplyCount",map);
	}
	public int A_upBoard(int article_num, String userId, String table) {
		BoardUpDownDTO dto = new BoardUpDownDTO();
		dto.setArticle_num(article_num);
		dto.setUserId(userId);
		dto.setBehavior(1);
		int res = A_upCountBoard(article_num,table);
		if(res<=0) return -1;
		return sqlSession.insert("upBoard", dto);
	}
	public int A_downBoard(int article_num, String userId, String table) {
		BoardUpDownDTO dto = new BoardUpDownDTO();
		dto.setArticle_num(article_num);
		dto.setUserId(userId);
		dto.setBehavior(-1);
		int res = A_downCountBoard(article_num, table);
		if(res<=0) return -1;
		return sqlSession.insert("downBoard", dto);
	}
	public int A_upCountBoard(int article_num,String table) {
		Map<String,Object> map = putMap(article_num,table);
		return sqlSession.update("A_upCountBoard", map);
	}
	public int A_downCountBoard(int article_num, String table) {
		Map<String,Object> map = putMap(article_num,table);
		return sqlSession.update("A_downCountBoard", map);
	}

	public int checkUserUpDown(int article_num, String userId) {
		BoardUpDownDTO dto = new BoardUpDownDTO();
		dto.setArticle_num(article_num);
		dto.setUserId(userId);
		return sqlSession.selectOne("A_checkUserUpDown", dto);
	}
	public void A_AllDelete(int article_num) {
		List<String> tableList = sqlSession.selectList("getTableHasArticle_num");
		for(String tableName : tableList) {
			Map<String,Object> map = new Hashtable<>();
			map.put("article_num", article_num);
			map.put("tableName", tableName);
			sqlSession.delete("deleteHasArticle_num", map);
		}
	}
}
