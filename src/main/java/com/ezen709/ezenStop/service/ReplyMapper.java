package com.ezen709.ezenStop.service;

import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen709.ezenStop.model.ReplyDTO;
import com.ezen709.ezenStop.model.ReviewBoardDTO;

@Service
public class ReplyMapper {
	
	@Autowired
	private SqlSession sqlSession;
	
	public List<ReplyDTO> replyList(int article_num){
		Map<String, Integer> map = new Hashtable<>();
		map.put("article_num", article_num);
		return sqlSession.selectList("replyList", map);
	}
	public int insertReply(ReplyDTO dto) {
		String sql = null;
		if (dto.getReply_num()==0) {
			sql = "update ezen_reply set re_step = re_step - 1 where article_num = "+dto.getAticle_num();
		}else {
			sql = "update ezen_reply set re_step = re_step - 1 where re_step <= " + dto.getRe_step() + " and "
					+ "article_num = " + dto.getAticle_num();
			dto.setRe_step(dto.getRe_step());
			dto.setRe_level(dto.getRe_level() + 1);
		}
		Map<String, String> map = new Hashtable<>();
		map.put("sql", sql);
		sqlSession.update("plusStep", map);
		int res = sqlSession.insert("insertReply", dto);
		return res;
	}
	public int replyMaxRe_step(int parent_num, int article_num) {
		Map<String, Integer> map = new Hashtable<>();
		map.put("parent_num", parent_num);
		map.put("article_num", article_num);
		if(sqlSession.selectOne("replyMaxRe_step", map) == null) {
			return 0;
		}else {
			return sqlSession.selectOne("replyMaxRe_step", map);
		}
	}
	public int replyCount(int article_num) {
		Map<String, Integer> map = new Hashtable<>();
		map.put("article_num", article_num);
		return sqlSession.selectOne("replyCount", map);
	}
	public void replyDelete(int reply_num, ReplyDTO dto) {
		Map<String, String> map = new Hashtable<>();
		sqlSession.update("replyDelete", dto);
	}
	public ReplyDTO replyDetail(int reply_num) {
		return sqlSession.selectOne("replyDetail", reply_num);
	}
	public List<ReplyDTO> replyListForAnonymous(int article_num){
		Map<String, Integer> map = new Hashtable<>();
		map.put("article_num", article_num);
		return sqlSession.selectList("replyListForAnonymous", map);
	}
}
