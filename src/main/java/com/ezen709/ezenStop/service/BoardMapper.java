package com.ezen709.ezenStop.service;

import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen709.ezenStop.model.BoardReportDTO;
import com.ezen709.ezenStop.model.BoardUpDownDTO;
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
	public int setUnvisible(int article_num) {
		return sqlSession.update("setUnvisible", article_num);
	}
	public List<BoardReportDTO> getReportList(int start, int end){
		Map<String, Integer> map = new Hashtable<>();
		map.put("start", start);
		map.put("end", end);
		return sqlSession.selectList("getReportList", map);
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
	public int changeVisibleStatus(int article_num) {
		return sqlSession.update("changeVisibleStatus",article_num);
	}
}
