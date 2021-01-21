package com.ezen709.ezenStop.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen709.ezenStop.model.BoardReportDTO;
import com.ezen709.ezenStop.model.BoardUpDownDTO;
import com.ezen709.ezenStop.model.Ezen_memberDTO;
import com.ezen709.ezenStop.model.ReviewBoardDTO;

@Service
public class BoardMapper {
	
	@Autowired
	private SqlSession sqlSession;
	
	public List<ReviewBoardDTO> reviewList(int start,int end){
		Map<String, Integer> map = new Hashtable<>();
		map.put("start", start);
		map.put("end", end);
		return sqlSession.selectList("reviewList", map);
	}
	public int reviewGetCount() {
		return sqlSession.selectOne("reviewGetCount");
	}
	public int reviewInsert(ReviewBoardDTO dto) {
		return sqlSession.insert("reviewInsert", dto);
	}
	public ReviewBoardDTO reviewDetail(int article_num) {
		return sqlSession.selectOne("reviewDetail", article_num);
	}
	public int reviewDelete(int article_num) {
		return sqlSession.delete("reviewDelete", article_num);
	}
	public int reviewfileDelete(int article_num) {
		return sqlSession.delete("reviewfileDelete", article_num);
	}
	public int reviewEdit(ReviewBoardDTO dto) {
		return sqlSession.update("reviewEdit", dto);
	}
	public void plusReadCount(int article_num) {
		sqlSession.update("plusReadCount", article_num);
	}
	public void updateReplyCount(int article_num, int replyCount) {
		Map<String, Integer> map = new Hashtable<>();
		map.put("article_num", article_num);
		map.put("replyCount", replyCount);
		sqlSession.update("updateReplyCount", map);
	}
	public int searchReviewGetCount(String searchType, String searchString) {
		Map<String,String> map = new Hashtable<>();
		map.put("searchtype", searchType);
		map.put("searchstring", searchString);
		int count = sqlSession.selectOne("searchReviewGetCount",map);
		return count;
	}
	public List<ReviewBoardDTO> searchMember(String searchType, String searchString,int startrow, int endrow){
		Map map = new Hashtable();
		map.put("searchtype", searchType);
		map.put("searchstring", searchString);
		map.put("start", startrow);
		map.put("end", endrow);
		List<ReviewBoardDTO> list = sqlSession.selectList("searchReview",map);
		return list;
	}
	public int checkUserUpDown(int article_num, String userId) {
		BoardUpDownDTO dto = new BoardUpDownDTO();
		dto.setArticle_num(article_num);
		dto.setUserId(userId);
		return sqlSession.selectOne("checkUserUpDown", dto);
	}
	public int upBoard(int article_num, String userId) {
		BoardUpDownDTO dto = new BoardUpDownDTO();
		dto.setArticle_num(article_num);
		dto.setUserId(userId);
		dto.setBehavior(1);
		int res = upCountBoard(article_num);
		if(res<=0) return -1;
		return sqlSession.insert("upBoard", dto);
	}
	public int downBoard(int article_num, String userId) {
		BoardUpDownDTO dto = new BoardUpDownDTO();
		dto.setArticle_num(article_num);
		dto.setUserId(userId);
		dto.setBehavior(-1);
		int res = downCountBoard(article_num);
		if(res<=0) return -1;
		return sqlSession.insert("downBoard", dto);
	}
	public int upCountBoard(int article_num) {
		return sqlSession.update("upCountBoard", article_num);
	}
	public int downCountBoard(int article_num) {
		return sqlSession.update("downCountBoard", article_num);
	}
	public int reportBoard(int article_num, String userId) {
		BoardUpDownDTO dto = new BoardUpDownDTO();
		dto.setArticle_num(article_num);
		dto.setUserId(userId);
		return sqlSession.insert("reportBoard", dto);
		
	}
	public int checkUserReport(int article_num, String userId) {
		BoardUpDownDTO dto = new BoardUpDownDTO();
		dto.setArticle_num(article_num);
		dto.setUserId(userId);
		return sqlSession.selectOne("checkUserReport", dto);
	}
	public int sendReportContent(int article_num, String userId, String reportContent) {
		BoardReportDTO dto = new BoardReportDTO();
		dto.setArticle_num(article_num);
		dto.setReportContent(reportContent);
		dto.setUserId(userId);
		return sqlSession.insert("insertReportContent", dto);
	}
	public int checkReportCount(int article_num) {
		return sqlSession.selectOne("checkReportCount", article_num);
	}
	public int setUnvisible(int article_num,String table) {
		Map<String,Object> map = new Hashtable<>();
		map.put("article_num", article_num);
		map.put("tableName",table);
		return sqlSession.update("setUnvisible", map);
	}
	public List<BoardReportDTO> getReportList(int start, int end){
		Map<String, Integer> map = new Hashtable<>();
		map.put("start", start);
		map.put("end", end);
		return sqlSession.selectList("getReportList", map);
	}
	public List<BoardReportDTO> SearchReportList(String searchType,String searchString,int start, int end){
		Map map = new Hashtable<>();
		map.put("searchType", searchType);
		map.put("searchString", searchString);
		map.put("start", start);
		map.put("end", end);
		return sqlSession.selectList("SearchReportList", map);
	}
	public int reportGetCount() {
		return sqlSession.selectOne("reportGetCount");
	}
	public List<String> getTableHasLocation(){
		return sqlSession.selectList("getTableHasLocation");
	}
	public String getLocation(List<String> list, String article_num) {
		for(String tableName : list) {
			Map<String,String> map = new Hashtable<>();
			map.put("tableName", tableName);
			map.put("article_num", article_num);
			String result = sqlSession.selectOne("getLocation", map);
			if(result != null) {
				return result;
			}
		}
		return null;
	}
	public List<ReviewBoardDTO> getUnvisibleBoard(List<String> list) {
		List<ReviewBoardDTO> unvisibleList = new ArrayList<>();
		for(String tableName : list) {
			Map<String,String> map = new Hashtable<String,String>();
			map.put("tableName", tableName);
			List<ReviewBoardDTO> result = sqlSession.selectList("selectUnvisibleBoard",map);
			for(ReviewBoardDTO dto : result) {
				unvisibleList.add(dto);
			}
		}
		return unvisibleList;
	}
	public int changeVisibleStatus(int article_num) {
		return sqlSession.update("changeVisibleStatus",article_num);
	}
	public List<ReviewBoardDTO> unvisibleList(int start, int end){
		List<String> list = getTableHasLocation();
		List<ReviewBoardDTO> unvisibleList = getUnvisibleBoard(list);
		Collections.sort(unvisibleList);
		List<ReviewBoardDTO> sortedList = new ArrayList<>();
		for(int i = start -1 ; i <= end -1 ; i++) {
			sortedList.add(unvisibleList.get(i));
		}
		return sortedList;
	}
	public int unvisibleGetCount() {
		return getUnvisibleBoard(getTableHasLocation()).size();
	}
	public int searchUnvisibleGetCount(String searchType,String searchString) {
		List<String> list = getTableHasLocation();
		List<ReviewBoardDTO> unvisibleList = new ArrayList<>();
		for(String tableName : list) {
			Map<String,String> map = new Hashtable<String,String>();
			map.put("tableName", tableName);
			map.put("searchType", searchType);
			map.put("searchString", searchString);
			List<ReviewBoardDTO> result = sqlSession.selectList("searchUnvisibleBoard",map);
			for(ReviewBoardDTO dto : result) {
				unvisibleList.add(dto);
			}
		}
		return unvisibleList.size();
	}
	public List<ReviewBoardDTO> SearchUnvisibleList(String searchType,String searchString,int start, int end){
		List<String> list = getTableHasLocation();
		List<ReviewBoardDTO> unvisibleList = new ArrayList<>();
		for(String tableName : list) {
			Map<String,String> map = new Hashtable<String,String>();
			map.put("tableName", tableName);
			map.put("searchType", searchType);
			map.put("searchString", searchString);
			List<ReviewBoardDTO> result = sqlSession.selectList("searchUnvisibleBoard",map);
			for(ReviewBoardDTO dto : result) {
				unvisibleList.add(dto);
			}
		}
		Collections.sort(unvisibleList);
		List<ReviewBoardDTO> sortedList = new ArrayList<>();
		System.out.println(start +"//"+end+"\n"+unvisibleList.size());
		for(int i = start -1 ; i <= end -1 ; i++) {
			sortedList.add(unvisibleList.get(i));
			
		}
		return sortedList;
	}
	public List<ReviewBoardDTO> getHotBoard(){
		List<String> tableList = getTableHasLocation();
		List<ReviewBoardDTO> hotList = new ArrayList<>();
		for(String tableName : tableList) {
			Map<String,String> map = new Hashtable<String,String>();
			map.put("tableName", tableName);
			List<ReviewBoardDTO> result = sqlSession.selectList("getHotBoard",map);
			for(ReviewBoardDTO dto : result) {
				hotList.add(dto);
			}
		}
		return hotList;
	}
	public Map<String, List<ReviewBoardDTO>> getIndexBoard(){
		List<String> tableList = getTableHasLocation();
		Map<String, List<ReviewBoardDTO>> listMap = new Hashtable<>();
		for(String tableName : tableList) {
			Map<String,String> map = new Hashtable<>();
			map.put("tableName", tableName);
			List<ReviewBoardDTO> list = sqlSession.selectList("getReviewIndex",map);
			listMap.put(tableName, list);
		}
		return listMap;
	}
	public List<ReviewBoardDTO> getCampusBoard(int start, int end, String where){
		Map<String,Object> map = new Hashtable<>();
		map.put("start", start);
		map.put("end", end);
		map.put("where", where);

		List<ReviewBoardDTO> list = sqlSession.selectList("getCampusBoard", map);
		
		return list;
		
		
	}
	public int campusBoardCount(String where) {
		int res = sqlSession.selectOne("campusBoardCount",where);
		return res;
	}
	public String getCertifiedCampus(String id) {
		Map<String,String> map = new Hashtable<>();
		map.put("id", id);
		Ezen_memberDTO dto = sqlSession.selectOne("getCertifiedCampus",id);
	}
	}
