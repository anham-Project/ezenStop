package com.ezen709.ezenStop;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ezen709.ezenStop.model.*;
import com.ezen709.ezenStop.service.*;
import java.util.*;

import javax.servlet.http.HttpServletRequest;

@Controller
public class LJH_boardController {
	@Autowired
	LJH_boardMapper boardMapper;
	
	public Map<String,Integer> setStartRowAndEndRow(HttpServletRequest req){
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null) {
			pageNum = "1";
		}
		int pageSize = 10;
		int currentPage = Integer.parseInt(pageNum);
		int startRow = pageSize * currentPage - (pageSize - 1);
		int endRow = pageSize * currentPage;
		Map<String,Integer> map = new Hashtable<>();
		map.put("currentPage", currentPage);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		map.put("pageSize", pageSize);
		return map;
	}
	public void setEndRowWhenCountIsLessThanEndRow(Map<String,Integer> map, int count) {
		if(map.get("endRow")>count) map.put("endRow", count);
		return;
	}
	public ModelAndView finishMakeModelAndView(Map<String,Integer> map, List list, int count) { //list���ڷ����� �����߽��ϴ�.(mav�� �ٷ� add���ֱ⶧����)
		int startNum = count - ((map.get("currentPage")-1) * map.get("pageSize"));
		int pageBlock = 3;
		int pageCount = count/map.get("pageSize") + (count%map.get("pageSize") == 0 ? 0 : 1);
		int startPage = (map.get("currentPage") - 1)/pageBlock * pageBlock + 1;
		int endPage = startPage + pageBlock - 1;
		if(endPage>pageCount) endPage = pageCount;
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("count", count);
		mav.addObject("startNum", startNum);
		mav.addObject("pageCount", pageCount);
		mav.addObject("startPage", startPage);
		mav.addObject("endPage", endPage);
		mav.addObject("pageBlock", pageBlock);
		mav.addObject("list", list); // ����Ʈ �̸� list���߽��ϴ�. jsp���� ��Ȯ���ϼ���!!
		return mav;			//��ü�鸸 ����ְ� ��δ� �ȴ���� .. ��μ����� �ϼ���!!
	}
	
	@RequestMapping("/notice_list.board")
	public ModelAndView notice_list(HttpServletRequest req) {
		Map<String,Integer> map = setStartRowAndEndRow(req);
		int count = boardMapper.noticeGetCount();
		setEndRowWhenCountIsLessThanEndRow(map, count);
		List<NoticeBoardDTO> reviewList = boardMapper.noticeList(map.get("startRow"), map.get("endRow"));
		ModelAndView mav = finishMakeModelAndView(map, reviewList, count);
		mav.setViewName("board/noticeList");
		return mav;
	}
}
