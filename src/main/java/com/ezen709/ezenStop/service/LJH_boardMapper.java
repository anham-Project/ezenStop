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
	
	public List<NoticeBoardDTO> noticeList(int start, int end){
		Map<String,Integer> map = new Hashtable();
		map.put("start",start);
		map.put("end",end);
		List<NoticeBoardDTO> list = sqlSession.selectList("noticeList",map);
		return list;
	}
	public int noticeGetCount() {
		return sqlSession.selectOne("noticeGetCount");
	}
}
