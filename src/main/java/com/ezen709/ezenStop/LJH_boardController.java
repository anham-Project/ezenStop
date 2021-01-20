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
import javax.servlet.http.HttpServletResponse;

@Controller
public class LJH_boardController {
	@Autowired
	LJH_boardMapper boardMapper;
	@Resource(name="uploadPath")
	private String uploadPath;
	
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
		mav.addObject("currentPage", map.get("currentPage"));
		mav.addObject("list", list); // 리스트 이름 list로했습니다. jsp파일 꼭확인하세요!!
		return mav;			//객체들만 담아주고 경로는 안담아줌 .. 경로설정꼭 하세요!!
	}
	@RequestMapping("/A_changeVisibleStatus.board")
	public void changeVisibleStatus(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		int article_num = Integer.parseInt(req.getParameter("article_num"));
		String table = req.getParameter("table");
		int res = boardMapper.changeVisibleStatus(article_num, table);
	}
	
	
	
	//공지사항
	
	@RequestMapping("/notice_list.board")
	public ModelAndView notice_list(HttpServletRequest req) {
		Map<String,Integer> map = setStartRowAndEndRow(req);
		String table = "ezen_notice_board";
		int count = boardMapper.A_getCount(table);
		setEndRowWhenCountIsLessThanEndRow(map, count);
		List<ReviewBoardDTO> noticeList = boardMapper.A_list(table, map.get("startRow"), map.get("endRow"));
		ModelAndView mav = finishMakeModelAndView(map, noticeList, count);
		mav.setViewName("board/noticeList");
		return mav;
	}
	@RequestMapping(value="/notice_write.board", method=RequestMethod.GET)
	public String noticeWriteForm() {
		return "board/noticeWrite";
	}
	@RequestMapping(value="/notice_write.board", method=RequestMethod.POST)
	public String noticewWritePro(HttpServletRequest req, @ModelAttribute ReviewBoardDTO dto, 
			BindingResult result) {
		if(result.hasErrors()) {}
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest)req;
		MultipartFile file = mr.getFile("image");
		UUID uuid = UUID.randomUUID();
		String fileName = uuid.toString()+"_"+file.getOriginalFilename();
		File target = new File(uploadPath, fileName);
		int filesize = 0;
		String image = "파일없음";
		if(file.getSize() > 0 ) {
			try {
				file.transferTo(target);
				filesize = (int)file.getSize();
				image = fileName;
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		String subject = dto.getSubject();
		String table="ezen_notice_board";
		dto.setDetaillocation("notice_detail.board");
		dto.setSubject(subject);
		dto.setImage(image);
		dto.setFilesize(filesize);
		int res = boardMapper.A_insert(dto,table);
		return "redirect:notice_list.board";
	}
	@RequestMapping("/notice_detail.board")
	public ModelAndView noticeDetail(@RequestParam int article_num) {
		String table = "ezen_notice_board";
		boardMapper.A_plusReadCount(article_num,table);
		ReviewBoardDTO noticeDetail = boardMapper.A_detail(article_num,table);
		ModelAndView mav = new ModelAndView("board/noticeDetail");
		mav.addObject("uploadPath", uploadPath);
		mav.addObject("noticeDetail", noticeDetail);
		return mav;
	}
	@RequestMapping(value="/notice_edit.board", method=RequestMethod.GET)
	public ModelAndView noticeEdit(@RequestParam int article_num) {
		String table = "ezen_notice_board";
		ReviewBoardDTO noticeDetail = boardMapper.A_detail(article_num,table);
		ModelAndView mav = new ModelAndView("board/noticeEdit");
		String subject = noticeDetail.getSubject();
		noticeDetail.setSubject(subject);
		mav.addObject("noticeDetail", noticeDetail);
		return mav;
	}
	@RequestMapping(value="/notice_edit.board", method=RequestMethod.POST)
	public String noticeEditPro(HttpServletRequest req, @ModelAttribute ReviewBoardDTO dto, 
			BindingResult result,@RequestParam String image0, @RequestParam int filesize0) {
		if(result.hasErrors()) {}
		String table = "ezen_notice_board";
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest)req;
		MultipartFile file = mr.getFile("image");
		UUID uuid = UUID.randomUUID();
		String fileName = uuid.toString()+"_"+file.getOriginalFilename();
		File target = new File(uploadPath, fileName);
		int filesize = 0;
		String image = "파일없음";
		if(file.getSize() > 0 ) {
			try {
				file.transferTo(target);
				filesize = (int)file.getSize();
				image = fileName;
				int res = boardMapper.A_fileDelete(Integer.parseInt(mr.getParameter("article_num")),table);
				if(res>0) {
					File target0 = new File(uploadPath, image0);
					target0.delete();
				}
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if(filesize0 > 0){
			image = image0;
			filesize = filesize0;
		}
		String subject = dto.getSubject();
		dto.setSubject(subject);
		dto.setImage(image);
		dto.setFilesize(filesize);
		int res = boardMapper.A_edit(dto,table);
		return "redirect:notice_list.board";
	}
	@RequestMapping("/notice_delete.board")
	public String noticeDelete(@RequestParam int article_num) {
		String table = "ezen_notice_board";
		ReviewBoardDTO noticeDetail = boardMapper.A_detail(article_num,table);
		System.out.println(noticeDetail.getArticle_num()+"<글번호 파일크기>"+noticeDetail.getFilesize());
		if(noticeDetail.getFilesize() == 0) {
			boardMapper.A_delete(article_num,table);
		}
		else{
			String image = noticeDetail.getImage();
			int res = boardMapper.A_delete(article_num,table);
			if(res>0) {
				File target = new File(uploadPath, image);
				noticeDetail.setFilesize(0);
				target.delete();
			}
		}
		return "redirect:notice_list.board";
	}
	@RequestMapping("/notice_find.board")
	public ModelAndView searchMember(HttpServletRequest req) throws IOException {
		String searchType = req.getParameter("searchType");
		String searchString = "%"+req.getParameter("searchString")+"%";
		String table = "ezen_notice_board";
		
		Map<String,Integer> map = setStartRowAndEndRow(req);
		
		int count = boardMapper.searchListGetCount(table,searchType,searchString);
		
		setEndRowWhenCountIsLessThanEndRow(map, count);
		
		List<ReviewBoardDTO> noticeList = boardMapper.A_searchList(table,searchType, searchString, map.get("startRow"), map.get("endRow"));
		
		ModelAndView mav = finishMakeModelAndView(map, noticeList, count);
		
		mav.setViewName("board/noticeList");
		
		return mav;
	}
	
	// 중고책 거래 게시판
	
	
	
	@RequestMapping("/trade_list.board")
	public ModelAndView trade_list(HttpServletRequest req) {
		Map<String,Integer> map = setStartRowAndEndRow(req);
		String table = "ezen_trade_board";
		int count = boardMapper.A_getCount(table);
		setEndRowWhenCountIsLessThanEndRow(map, count);
		List<ReviewBoardDTO> noticeList = boardMapper.A_list(table, map.get("startRow"), map.get("endRow"));
		ModelAndView mav = finishMakeModelAndView(map, noticeList, count);
		mav.setViewName("board/tradeList");
		return mav;
	}
	@RequestMapping(value="/trade_write.board", method=RequestMethod.GET)
	public String tradeWriteForm() {
		return "board/tradeWrite";
	}
	@RequestMapping(value="/trade_write.board", method=RequestMethod.POST)
	public String tradewWritePro(HttpServletRequest req, @ModelAttribute ReviewBoardDTO dto, 
			BindingResult result) {
		if(result.hasErrors()) {}
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest)req;
		MultipartFile file = mr.getFile("image");
		UUID uuid = UUID.randomUUID();
		String fileName = uuid.toString()+"_"+file.getOriginalFilename();
		File target = new File(uploadPath, fileName);
		int filesize = 0;
		String image = "파일없음";
		if(file.getSize() > 0 ) {
			try {
				file.transferTo(target);
				filesize = (int)file.getSize();
				image = fileName;
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		String subject = dto.getSubject();
		dto.setSubject(subject);
		dto.setImage(image);
		dto.setFilesize(filesize);
		dto.setDetaillocation("trade_detail.board");
		String table="ezen_trade_board";
		int res = boardMapper.A_insert(dto,table);
		System.out.println(res);
		return "redirect:trade_list.board";
	}
	@RequestMapping("/trade_detail.board")
	public ModelAndView tradeDetail(@RequestParam int article_num) {
		String table = "ezen_trade_board";
		boardMapper.A_plusReadCount(article_num,table);
		ReviewBoardDTO noticeDetail = boardMapper.A_detail(article_num,table);
		ModelAndView mav = new ModelAndView("board/tradeDetail");
		mav.addObject("uploadPath", uploadPath);
		mav.addObject("tradeDetail", noticeDetail);
		return mav;
	}
	@RequestMapping(value="/trade_edit.board", method=RequestMethod.GET)
	public ModelAndView tradeEdit(@RequestParam int article_num) {
		String table = "ezen_trade_board";
		ReviewBoardDTO tradeDetail = boardMapper.A_detail(article_num,table);
		ModelAndView mav = new ModelAndView("board/noticeEdit");
		String subject = tradeDetail.getSubject();
		tradeDetail.setSubject(subject);
		mav.addObject("tradeDetail", tradeDetail);
		return mav;
	}
	@RequestMapping(value="/trade_edit.board", method=RequestMethod.POST)
	public String tradeEditPro(HttpServletRequest req, @ModelAttribute ReviewBoardDTO dto, 
			BindingResult result,@RequestParam String image0, @RequestParam int filesize0) {
		if(result.hasErrors()) {}
		String table = "ezen_trade_board";
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest)req;
		MultipartFile file = mr.getFile("image");
		UUID uuid = UUID.randomUUID();
		String fileName = uuid.toString()+"_"+file.getOriginalFilename();
		File target = new File(uploadPath, fileName);
		int filesize = 0;
		String image = "파일없음";
		if(file.getSize() > 0 ) {
			try {
				file.transferTo(target);
				filesize = (int)file.getSize();
				image = fileName;
				int res = boardMapper.A_fileDelete(Integer.parseInt(mr.getParameter("article_num")),table);
				if(res>0) {
					File target0 = new File(uploadPath, image0);
					target0.delete();
				}
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if(filesize0 > 0){
			image = image0;
			filesize = filesize0;
		}
		String subject = dto.getSubject();
		dto.setSubject(subject);
		dto.setImage(image);
		dto.setFilesize(filesize);
		int res = boardMapper.A_edit(dto,table);
		return "redirect:trade_list.board";
	}
	@RequestMapping("/trade_delete.board")
	public String tradeDelete(@RequestParam int article_num) {
		String table = "ezen_trade_board";
		ReviewBoardDTO noticeDetail = boardMapper.A_detail(article_num,table);
		System.out.println(noticeDetail.getArticle_num()+"<글번호 파일크기>"+noticeDetail.getFilesize());
		if(noticeDetail.getFilesize() == 0) {
			boardMapper.A_delete(article_num,table);
		}
		else{
			String image = noticeDetail.getImage();
			int res = boardMapper.A_delete(article_num,table);
			if(res>0) {
				File target = new File(uploadPath, image);
				noticeDetail.setFilesize(0);
				target.delete();
			}
		}
		return "redirect:trade_list.board";
	}
	@RequestMapping("/trade_find.board")
	public ModelAndView searchTrade(HttpServletRequest req) throws IOException {
		String searchType = req.getParameter("searchType");
		String searchString = "%"+req.getParameter("searchString")+"%";
		String table = "ezen_trade_board";
		
		Map<String,Integer> map = setStartRowAndEndRow(req);
		
		int count = boardMapper.searchListGetCount(table,searchType,searchString);
		
		setEndRowWhenCountIsLessThanEndRow(map, count);
		
		List<ReviewBoardDTO> noticeList = boardMapper.A_searchList(table,searchType, searchString, map.get("startRow"), map.get("endRow"));
		
		ModelAndView mav = finishMakeModelAndView(map, noticeList, count);
		
		mav.setViewName("board/tradeList");
		
		return mav;
	}
}
