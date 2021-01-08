package com.ezen709.ezenStop;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

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

import com.ezen709.ezenStop.model.ReviewBoardDTO;
import com.ezen709.ezenStop.service.BoardMapper;

@Controller
public class BoardController {
	
	@Autowired
	private BoardMapper boardMapper;
	
	@Resource(name="uploadPath")
	private String uploadPath;
	
	@RequestMapping("/review_list.board")
	public ModelAndView reviewList(HttpServletRequest req) {
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null) {
			pageNum = "1";
		}
		int pageSize = 10;
		int currentPage = Integer.parseInt(pageNum);
		int startRow = pageSize * currentPage - (pageSize - 1);
		int endRow = pageSize * currentPage;
		int count = boardMapper.reviewGetCount();
		if (endRow>count) endRow = count;
		List<ReviewBoardDTO> reviewList = boardMapper.reviewList(startRow, endRow);
		int startNum = count - ((currentPage-1) * pageSize);
		int pageBlock = 3;
		int pageCount = count/pageSize + (count%pageSize == 0 ? 0 : 1);
		int startPage = (currentPage - 1)/pageBlock * pageBlock + 1;
		int endPage = startPage + pageBlock - 1;
		if (endPage>pageCount) endPage = pageCount;
		
		ModelAndView mav = new ModelAndView("board/reviewList");
		mav.addObject("count", count);
		mav.addObject("startNum", startNum);
		mav.addObject("pageCount", pageCount);
		mav.addObject("startPage", startPage);
		mav.addObject("endPage", endPage);
		mav.addObject("pageBlock", pageBlock);
		mav.addObject("reviewList", reviewList);
		return mav;
	}
	@RequestMapping(value="/review_write.board", method=RequestMethod.GET)
	public String reviewWriteForm() {
		return "board/reviewWrite";
	}
	@RequestMapping(value="/review_write.board", method=RequestMethod.POST)
	public String reviewWritePro(HttpServletRequest req, @ModelAttribute ReviewBoardDTO dto, 
			BindingResult result, @RequestParam String reviewAddr) {
		if(result.hasErrors()) {}
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest)req;
		MultipartFile file = mr.getFile("image");
		File target = new File(uploadPath, file.getOriginalFilename());
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
		String subject = reviewAddr + dto.getSubject();
		dto.setSubject(subject);
		dto.setImage(image);
		dto.setFilesize(filesize);
		int res = boardMapper.reviewInsert(dto);
		return "redirect:review_list.board";
	}
	@RequestMapping("/review_detail.board")
	public ModelAndView reviewDetail(@RequestParam int article_num) {
		ReviewBoardDTO reviewDetail = boardMapper.reviewDetail(article_num);
		ModelAndView mav = new ModelAndView("board/reviewDetail");
		mav.addObject("reviewDetail", reviewDetail);
		return mav;
	}
	@RequestMapping("/review_reply_write.board")
	public String replyWritePro() {
		return null;
	}
}
