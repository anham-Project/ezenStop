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
	
	public List<ReviewBoardDTO> noticeList(String table,int start, int end){
		Map<String,Object> map = new Hashtable();
		map.put("tableName",table);
		map.put("start",start);
		map.put("end",end);
		List<ReviewBoardDTO> list = sqlSession.selectList("noticeList",map);
		return list;
	}
	public int noticeGetCount(String table) {
		Map<String,Object> map = new Hashtable();
		map.put("tableName",table);
		return sqlSession.selectOne("A_GetCount",map);
	}
	public int noticeInsert(ReviewBoardDTO dto) {
		return sqlSession.insert("noticeInsert", dto);
	}
	public void notice_plusReadCount(int article_num,String table) {
		Map<String,Object> map = putMap(article_num, table);
		sqlSession.update("A_plusReadCount", map);
	}
	public ReviewBoardDTO noticeDetail(int article_num,String table) {
		Map<String,Object> map = putMap(article_num, table);
		return sqlSession.selectOne("A_Detail", map);
	}
	public int noticeDelete(int article_num,String table) {
		Map<String,Object> map = putMap(article_num, table);
		return sqlSession.delete("A_Delete", map);
	}
	public int noticefileDelete(int article_num,String table) {
		Map<String,Object> map = putMap(article_num, table);
		return sqlSession.delete("A_fileDelete", map);
	}
	public int noticeEdit(ReviewBoardDTO dto) {
		return sqlSession.update("noticeEdit", dto);
	}
	public int searchNoticeGetCount(String table,String searchType, String searchString) {
		Map<String,String> map = new Hashtable<>();
		map.put("tableName",table);
		map.put("searchtype", searchType);
		map.put("searchstring", searchString);
		int count = sqlSession.selectOne("A_searchGetCount",map);
		return count;
	}
	public List<ReviewBoardDTO> searchNotice(String table,String searchType, String searchString,int startrow, int endrow){
		Map map = new Hashtable();
		map.put("tableName",table);
		map.put("searchtype", searchType);
		map.put("searchstring", searchString);
		map.put("start", startrow);
		map.put("end", endrow);
		List<ReviewBoardDTO> list = sqlSession.selectList("A_searchList",map);
		return list;
	}
	
}
