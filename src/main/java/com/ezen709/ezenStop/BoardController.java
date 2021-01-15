package com.ezen709.ezenStop;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.ezen709.ezenStop.model.BoardReportDTO;
import com.ezen709.ezenStop.model.ReplyDTO;
import com.ezen709.ezenStop.model.ReviewBoardDTO;
import com.ezen709.ezenStop.service.BoardMapper;
import com.ezen709.ezenStop.service.ReplyMapper;

@Controller
public class BoardController {
	
	@Autowired
	private BoardMapper boardMapper;
	
	@Autowired
	private ReplyMapper replyMapper;
	
	@Resource(name="uploadPath")
	private String uploadPath;
	
	@RequestMapping("/review_list.board")
	public ModelAndView reviewList(HttpServletRequest req) {
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null) {
			pageNum = "1";
		}
		int pageSize = 2;
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
		String image = "���Ͼ���";
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
		boardMapper.plusReadCount(article_num);
		ReviewBoardDTO reviewDetail = boardMapper.reviewDetail(article_num);
		List<ReplyDTO> replyList = replyMapper.replyList(article_num);
		ModelAndView mav = new ModelAndView("board/reviewDetail");
		mav.addObject("reviewDetail", reviewDetail);
		mav.addObject("replyList", replyList);
		return mav;
	}
	@RequestMapping(value="/review_edit.board", method=RequestMethod.GET)
	public ModelAndView reviewEdit(@RequestParam int article_num) {
		ReviewBoardDTO reviewDetail = boardMapper.reviewDetail(article_num);
		ModelAndView mav = new ModelAndView("board/reviewEdit");
		String[] categoryList = {"[6���� ����]","[3���� ����]","[�ܱ����]","[��Ÿ]"};
		String[] reviewAddrList = {"[���]","[����]"};
		String addrAndSuject = reviewDetail.getSubject();
		String reviewAddr = addrAndSuject.substring(addrAndSuject.lastIndexOf("]")+1);
		int addrLength = reviewAddr.length();
		int allLength = addrAndSuject.length();
		String subject = addrAndSuject.substring(addrLength,allLength);
		reviewDetail.setSubject(subject);
		mav.addObject("reviewDetail", reviewDetail);
		mav.addObject("reviewAddrList",reviewAddrList);
		mav.addObject("categoryList", categoryList);
		mav.addObject("reviewAddr", reviewAddr);
		return mav;
	}
	@RequestMapping(value="/review_edit.board", method=RequestMethod.POST)
	public String reviewEditPro(HttpServletRequest req, @ModelAttribute ReviewBoardDTO dto, 
			BindingResult result, @RequestParam String reviewAddr) {
		if(result.hasErrors()) {}
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest)req;
		MultipartFile file = mr.getFile("image");
		File target = new File(uploadPath, file.getOriginalFilename());
		int filesize = 0;
		String image = "���Ͼ���";
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
	@RequestMapping("/review_delete.board")
	public String reviewDelete(@RequestParam int article_num) {
		ReviewBoardDTO reviewDetail = boardMapper.reviewDetail(article_num);
		System.out.println(reviewDetail.getArticle_num()+"<�۹�ȣ ����ũ��>"+reviewDetail.getFilesize());
		if(reviewDetail.getFilesize() == 0) {
			boardMapper.reviewDelete(article_num);
		}
		else{
			String image = reviewDetail.getImage();
			int res = boardMapper.reviewDelete(article_num);
			if(res>0) {
				File target = new File(uploadPath, image);
				reviewDetail.setFilesize(0);
				target.delete();
			}
		}
		return "redirect:review_list.board";
	}
	@RequestMapping("/review_reply_write.board")
	public String replyWritePro(@RequestParam int article_num, HttpServletRequest req,
			@RequestParam String id, @RequestParam String content) {
		ReplyDTO dto = new ReplyDTO();
		int reply_num =0;
		if(StringUtils.isEmpty(req.getParameter("reply_num"))) {
			dto.setRe_step(0);
			dto.setRe_level(0);
			dto.setParent_num(0);
		}else {
			reply_num = Integer.parseInt(req.getParameter("reply_num"));
			ReplyDTO dto2 = replyMapper.replyDetail(reply_num);
			dto.setRe_step(dto2.getRe_step());
			dto.setRe_level(dto2.getRe_level());
			dto.setParent_num(reply_num);
		}
		dto.setId(id);
		dto.setContent(content);
		dto.setReply_num(reply_num);
		dto.setAticle_num(article_num);
		int res = replyMapper.insertReply(dto);
		int replyCount = replyMapper.replyCount(dto.getArticle_num());
		boardMapper.updateReplyCount(dto.getArticle_num(), replyCount);
		return "redirect:review_detail.board?article_num="+article_num;
	}
	@RequestMapping("review_reply_delete.board")
	public String replyDeletePro(@RequestParam int reply_num, @RequestParam int article_num) {
		replyMapper.replyDelete(reply_num);
		int replyCount = replyMapper.replyCount(article_num);
		boardMapper.updateReplyCount(article_num, replyCount);
		return "redirect:review_detail.board?article_num="+article_num;
	}
	@RequestMapping("/updownPro.board")
	public void updownPro(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		int article_num = Integer.parseInt(req.getParameter("article_num"));
		String userId = req.getParameter("userId");
		String somethingDo = req.getParameter("somethingDo");
		String res;
		int check = boardMapper.checkUserUpDown(article_num, userId);
		if(check>0) {
			res = "-2";
		}else {
			if(somethingDo.equals("up")) {
				res = boardMapper.upBoard(article_num, userId)+"";
			}else {
				res = boardMapper.downBoard(article_num, userId)+"";
			}
		}
		resp.getWriter().write(res);
	}
	@RequestMapping("/reportPro.board")
	public void reportPro(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String userId = req.getParameter("userId");
		String reportContent = req.getParameter("reportContent");
		int article_num = Integer.parseInt(req.getParameter("article_num"));
		int check = boardMapper.checkUserReport(article_num, userId);
		String res;
		if(check>0) {
			res = "-2";
		}else {
			res = boardMapper.sendReportContent(article_num, userId, reportContent)+"";
			String res1 = boardMapper.reportBoard(article_num, userId)+"";
			if(!res.equals(res1)) res="-3";
		}
		if(res.equals("1") && boardMapper.checkReportCount(article_num) == 5) {
			boardMapper.setUnvisible(article_num);
			ReplyDTO dto = new ReplyDTO();
			dto.setRe_step(0);
			dto.setRe_level(0);
			dto.setParent_num(0);
			dto.setId("master");
			dto.setContent("������ ������� ��Ȱ��ȭ ó���Ǿ����ϴ�. �����ڿ��� �������ּ���.");
			dto.setReply_num(0);
			dto.setAticle_num(article_num);
			replyMapper.insertReply(dto);
			int replyCount = replyMapper.replyCount(dto.getArticle_num());
			boardMapper.updateReplyCount(dto.getArticle_num(), replyCount);
		}
		resp.getWriter().write(res);
		
	}
	@RequestMapping("/reportBoard.board")
	public ModelAndView reportBoard (HttpServletRequest req) {
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null) {
			pageNum = "1";
		}
		int pageSize = 2;
		int currentPage = Integer.parseInt(pageNum);
		int startRow = pageSize * currentPage - (pageSize - 1);
		int endRow = pageSize * currentPage;
		int count = boardMapper.reportGetCount();
		if (endRow>count) endRow = count;
		List<BoardReportDTO> reportList = boardMapper.getReportList(startRow, endRow);
		int startNum = count - ((currentPage-1) * pageSize);
		int pageBlock = 3;
		int pageCount = count/pageSize + (count%pageSize == 0 ? 0 : 1);
		int startPage = (currentPage - 1)/pageBlock * pageBlock + 1;
		int endPage = startPage + pageBlock - 1;
		if (endPage>pageCount) endPage = pageCount;
		ModelAndView mav = new ModelAndView("board/reportList");
		mav.addObject("count", count);
		mav.addObject("startNum", startNum);
		mav.addObject("pageCount", pageCount);
		mav.addObject("startPage", startPage);
		mav.addObject("endPage", endPage);
		mav.addObject("pageBlock", pageBlock);
		mav.addObject("reportList", reportList);
		return mav;
	}
	@RequestMapping("/getDetail.board")
	public void getDetail(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		String article_num = req.getParameter("article_num");
		List<String> hasDetaillocationTable = boardMapper.getTableHasLocation();
		String location = boardMapper.getLocation(hasDetaillocationTable,article_num);
		resp.getWriter().write(location);
	}
	@RequestMapping("/changeVisibleStatus.board")
	public void changeVisibleStatus(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		String article_num = req.getParameter("article_num");
		int res = boardMapper.changeVisibleStatus(Integer.parseInt(article_num));
	}
}
