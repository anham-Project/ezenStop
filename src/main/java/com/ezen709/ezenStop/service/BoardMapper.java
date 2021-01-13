package com.ezen709.ezenStop.service;

import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	public void plusReadCount(int article_num) {
		sqlSession.update("plusReadCount", article_num);
	}
	public void updateReplyCount(int article_num, int replyCount) {
		Map<String, Integer> map = new Hashtable<>();
		map.put("article_num", article_num);
		map.put("replyCount", replyCount);
		sqlSession.update("updateReplyCount", map);
	}
}
