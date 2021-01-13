package com.ezen709.ezenStop.service;

import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen709.ezenStop.model.ReplyDTO;

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
			sql = "update ezen_reply set re_step = re_step + 1 where article_num = "+dto.getAticle_num();
		}else {
			sql = "update ezen_reply set re_step = re_step + 1 where re_step > " + dto.getRe_step() + " and "
					+ "article_num = " + dto.getAticle_num();
			dto.setRe_step(dto.getRe_step() + 1);
			dto.setRe_level(dto.getRe_level() + 1);
		}
		Map<String, String> map = new Hashtable<>();
		map.put("sql", sql);
		sqlSession.update("plusStep", map);
		int res = sqlSession.insert("insertReply", dto);
		return res;
	}
	public int replyCount(int article_num) {
		Map<String, Integer> map = new Hashtable<>();
		map.put("article_num", article_num);
		return sqlSession.selectOne("replyCount", map);
	}
	public void replyDelete(int reply_num) {
		Map<String, Integer> map = new Hashtable<>();
		map.put("reply_num", reply_num);
		sqlSession.delete("replyDelete", map);
	}
}
