package com.ezen709.ezenStop;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.ezen709.ezenStop.model.*;
import com.ezen709.ezenStop.service.*;

import java.io.File;
import java.io.IOException;
import java.util.*;

import javax.annotation.Resource;
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
	public ModelAndView finishMakeModelAndView(Map<String,Integer> map, List list, int count) { //list의자료형은 안정했습니다.(mav에 바로 add해주기때문에)
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
		mav.addObject("list", list); // 리스트 이름 list로했습니다. jsp파일 꼭확인하세요!!
		return mav;			//객체들만 담아주고 경로는 안담아줌 .. 경로설정꼭 하세요!!
	}
	
	@RequestMapping("/notice_list.board")
	public ModelAndView notice_list(HttpServletRequest req) {
		Map<String,Integer> map = setStartRowAndEndRow(req);
		int count = boardMapper.noticeGetCount();
		setEndRowWhenCountIsLessThanEndRow(map, count);
		List<ReviewBoardDTO> reviewList = boardMapper.noticeList(map.get("startRow"), map.get("endRow"));
		ModelAndView mav = finishMakeModelAndView(map, reviewList, count);
		mav.setViewName("board/noticeList");
		return mav;
	}
	@RequestMapping(value="/notice_write.board", method=RequestMethod.GET)
	public String noticeWriteForm() {
		return "board/noticeWrite";
	}
	@RequestMapping(value="/notice_write.board", method=RequestMethod.POST)
	public String noticewWritePro(HttpServletRequest req, @ModelAttribute ReviewBoardDTO dto, 
			BindingResult result, @RequestParam String reviewAddr) {
		if(result.hasErrors()) {}
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest)req;
		MultipartFile file = mr.getFile("image");
/*		File target = new File(uploadPath, file.getOriginalFilename());
		int filesize = 0;
		String image = "파일없음";
		if(file.getSize() > 0 ) {
			try {
				file.transferTo(target);
				filesize = (int)file.getSize();
				image = file.getOriginalFilename();
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		*/
		String subject = reviewAddr + dto.getSubject();
		dto.setSubject(subject);
//		dto.setImage(image);
//		dto.setFilesize(filesize);
		int res = boardMapper.noticeInsert(dto);
		return "redirect:notice_list.board";
	}
}
