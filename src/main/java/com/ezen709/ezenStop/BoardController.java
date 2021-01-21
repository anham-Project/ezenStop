package com.ezen709.ezenStop;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import com.ezen709.ezenStop.model.CampusModel;
import com.ezen709.ezenStop.model.ReplyDTO;
import com.ezen709.ezenStop.model.ReviewBoardDTO;
import com.ezen709.ezenStop.service.BoardMapper;
import com.ezen709.ezenStop.service.LJH_boardMapper;
import com.ezen709.ezenStop.service.LoginMapper;
import com.ezen709.ezenStop.service.ReplyMapper;

@Controller
public class BoardController {
	
	CampusModel campusModel = new CampusModel();
	
	@Autowired
	private BoardMapper boardMapper;
	
	@Autowired
	private ReplyMapper replyMapper;
	
	@Autowired
	private LoginMapper loginMapper;
	
	@Autowired
	private LJH_boardMapper commonMapper; 
	
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
		mav.addObject("currentPage", map.get("currentPage"));
		mav.addObject("list", list); // ����Ʈ �̸� list���߽��ϴ�. jsp���� ��Ȯ���ϼ���!!
		return mav;			//��ü�鸸 ����ְ� ��δ� �ȴ���� .. ��μ����� �ϼ���!!
	}
	@RequestMapping("/review_list.board")
	public ModelAndView reviewList(HttpServletRequest req) {
	/*	String pageNum = req.getParameter("pageNum");
		if (pageNum == null) {
			pageNum = "1";
		}
		int pageSize = 10;
		int currentPage = Integer.parseInt(pageNum);
		int startRow = pageSize * currentPage - (pageSize - 1);
		int endRow = pageSize * currentPage;
		int count = boardMapper.reviewGetCount();  */
		Map<String,Integer> map = setStartRowAndEndRow(req);
		int count = boardMapper.reviewGetCount();
		//if (endRow>count) endRow = count;
		setEndRowWhenCountIsLessThanEndRow(map, count);
		//List<ReviewBoardDTO> reviewList = boardMapper.reviewList(startRow, endRow);
		List<ReviewBoardDTO> reviewList = boardMapper.reviewList(map.get("startRow"), map.get("endRow"));
		/*int startNum = count - ((currentPage-1) * pageSize);
		int pageBlock = 3;
		int pageCount = count/pageSize + (count%pageSize == 0 ? 0 : 1);
		int startPage = (currentPage - 1)/pageBlock * pageBlock + 1;
		int endPage = startPage + pageBlock - 1;
		if (endPage>pageCount) endPage = pageCount;*/
		
		//ModelAndView mav = new ModelAndView("board/reviewList");
		ModelAndView mav = finishMakeModelAndView(map, reviewList, count);
		
		mav.setViewName("board/reviewList");
		return mav;
		/*mav.addObject("count", count);
		mav.addObject("startNum", startNum);
		mav.addObject("pageCount", pageCount);
		mav.addObject("startPage", startPage);
		mav.addObject("endPage", endPage);
		mav.addObject("pageBlock", pageBlock);
		mav.addObject("reviewList", reviewList);
		return mav;*/
		
	}
	@RequestMapping(value="/review_write.board", method=RequestMethod.GET)
	public ModelAndView reviewWriteForm(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView("board/reviewWrite");;
		String reply_id = req.getParameter("id");
		String location = loginMapper.getIdGrade(reply_id);
		String[] reviewAddr;
		if(location.equals("2")){
			reviewAddr = campusModel.getLocationList();
			for(int i = 0; i < reviewAddr.length; i++) {
				System.out.println(reviewAddr[i]+", ");
			}
			mav.addObject("reviewAddr", reviewAddr);
		}else if(location.equals("1")) {
			location = loginMapper.getIdLocation(reply_id);
			reviewAddr = new String[0];
			reviewAddr[0] = location;
			mav.addObject("reviewAddr", reviewAddr);
		}
		return mav;
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
		mav.addObject("uploadPath", uploadPath);
		mav.addObject("reviewDetail", reviewDetail);
		mav.addObject("replyList", replyList);
		return mav;
	}
	@RequestMapping(value="/review_edit.board", method=RequestMethod.GET)
	public ModelAndView reviewEdit(@RequestParam int article_num) {
		ReviewBoardDTO reviewDetail = boardMapper.reviewDetail(article_num);
		ModelAndView mav = new ModelAndView("board/reviewEdit");
		String[] categoryList = {"[6���� ����]","[3���� ����]","[�ܱ����]","[��Ÿ]"};
		String location = loginMapper.getIdGrade(reviewDetail.getId());
		String[] reviewAddrList;
		if(location.equals("2")){
			reviewAddrList = campusModel.getLocationList();
			mav.addObject("reviewAddrList",reviewAddrList);
		}else if(location.equals("1")) {
			location = loginMapper.getIdLocation(reviewDetail.getId());
			reviewAddrList = new String[0];
			reviewAddrList[0] = location;
			mav.addObject("reviewAddrList",reviewAddrList);
		}
		String addrAndSuject = reviewDetail.getSubject();
		String reviewAddr = addrAndSuject.substring(addrAndSuject.lastIndexOf("]")+1);
		int allLength = addrAndSuject.length();
		int addrLength = allLength - reviewAddr.length();
		String subject = addrAndSuject.substring(addrLength,allLength);
		reviewDetail.setSubject(subject);
		mav.addObject("reviewDetail", reviewDetail);
		mav.addObject("categoryList", categoryList);
		mav.addObject("reviewAddr", reviewAddr);
		return mav;
	}
	@RequestMapping(value="/review_edit.board", method=RequestMethod.POST)
	public String reviewEditPro(HttpServletRequest req, @ModelAttribute ReviewBoardDTO dto, 
			BindingResult result, @RequestParam String reviewAddr, 
			@RequestParam String image0, @RequestParam int filesize0) {
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
				int res = boardMapper.reviewfileDelete(Integer.parseInt(mr.getParameter("article_num")));
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
		String subject = reviewAddr + dto.getSubject();
		dto.setSubject(subject);
		dto.setImage(image);
		dto.setFilesize(filesize);
		int res = boardMapper.reviewEdit(dto);
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
	@RequestMapping("/review_find.board")
	public ModelAndView searchMember(HttpServletRequest req) throws IOException {
		String searchType = req.getParameter("searchType");
		String searchString = "%"+req.getParameter("searchString")+"%";
		
		Map<String,Integer> map = setStartRowAndEndRow(req);
		
		int count = boardMapper.searchReviewGetCount(searchType,searchString);
		
		setEndRowWhenCountIsLessThanEndRow(map, count);
		
		List<ReviewBoardDTO> reviewList = boardMapper.searchMember(searchType, searchString, map.get("startRow"), map.get("endRow"));
		
		ModelAndView mav = finishMakeModelAndView(map, reviewList, count);
		
		mav.setViewName("board/reviewList");
		
		return mav;
		
	}
	@RequestMapping("/review_reply_write.board")
	public String replyWritePro(@RequestParam int article_num, HttpServletRequest req,
			@RequestParam String id, @RequestParam String content) {
		ReplyDTO dto = new ReplyDTO();
		int reply_num = 0;
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
	@RequestMapping("/review_reply_delete.board")
	public String replyDeletePro(@RequestParam int reply_num, @RequestParam int article_num) {
		replyMapper.replyDelete(reply_num);
		int replyCount = replyMapper.replyCount(article_num);
		boardMapper.updateReplyCount(article_num, replyCount);
		return "redirect:review_detail.board?article_num="+article_num;
	}
	@RequestMapping("/getWriterGrade.board")
	public void getWriterGrade(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		String reply_id = req.getParameter("reply_id");
		String grade = loginMapper.getIdGrade(reply_id);
		if(grade.equals("2") || grade.equals("0")){
			
		}else if(grade.equals("1")) {
			grade = loginMapper.getIdLocation(reply_id);
		}
		resp.getWriter().write(grade);
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
				res = boardMapper.upBoard(article_num, userId, "ezen_review_board")+"";
				
			}else {
				res = boardMapper.downBoard(article_num, userId, "ezen_review_board")+"";
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
		
		Map<String,Integer> map = setStartRowAndEndRow(req);
		
		int count = boardMapper.reportGetCount();
		
		setEndRowWhenCountIsLessThanEndRow(map, count);
		
		List<BoardReportDTO> reportList = boardMapper.getReportList(map.get("startRow"), map.get("endRow"));
		
		ModelAndView mav = finishMakeModelAndView(map, reportList, count);
		
		mav.setViewName("board/reportList");
		
		return mav;
		
	}
	@RequestMapping("/report_find.board")
	public ModelAndView report_find(HttpServletRequest req){
		String searchType = req.getParameter("searchType");
		String searchString = "%"+req.getParameter("searchString")+"%";
		
		Map<String,Integer> map = setStartRowAndEndRow(req);
		
		int count = boardMapper.reportGetCount();
		
		setEndRowWhenCountIsLessThanEndRow(map, count);
		
		List<BoardReportDTO> reportList = boardMapper.SearchReportList(searchType, searchString, map.get("startRow"), map.get("endRow"));
		
		ModelAndView mav = finishMakeModelAndView(map, reportList, count);
		
		mav.setViewName("board/reportList");
		
		return mav;
	}
	@RequestMapping("unvisible_find.board")
	public ModelAndView unvisible_find(HttpServletRequest req){
		String searchType = req.getParameter("searchType");
		String searchString = "%"+req.getParameter("searchString")+"%";
		Map<String,Integer> map = setStartRowAndEndRow(req);
		
		int count = boardMapper.searchUnvisibleGetCount(searchType,searchString);
		
		setEndRowWhenCountIsLessThanEndRow(map, count);
		
		List<ReviewBoardDTO> unvisibleList = boardMapper.SearchUnvisibleList(searchType, searchString, map.get("startRow"), map.get("endRow"));
		
		ModelAndView mav = finishMakeModelAndView(map, unvisibleList, count);
		
		mav.setViewName("board/unvisibleBoard");
		
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
	@RequestMapping("/unvisible_list.board")
	public ModelAndView unvisibleList(HttpServletRequest req) {
		Map<String,Integer> map = setStartRowAndEndRow(req);
		
		int count = boardMapper.unvisibleGetCount();
		
		setEndRowWhenCountIsLessThanEndRow(map, count);
		
		List<ReviewBoardDTO> unvisibleList = boardMapper.unvisibleList(map.get("startRow"), map.get("endRow"));
		
		ModelAndView mav = finishMakeModelAndView(map, unvisibleList, count);
		
		mav.setViewName("board/unvisibleBoard");
		
		return mav;
		
	}
	@RequestMapping("/campusBoardList.board")
	public ModelAndView campusBoardList(HttpServletRequest req) {
		HttpSession session = req.getSession();
		String id = (String)session.getAttribute("userId");
		if(id ==null || id.equals(""))return new ModelAndView("redirect:index.do");
		
		int userGrade = (int)session.getAttribute("userGrade");
		if(userGrade == 0 ) return new ModelAndView("redirect:index.do");
		
		String[] location = new CampusModel().getLocationList();
		String where = req.getParameter("where");
		if(where ==null|| where.equals(""))return new ModelAndView("redirect:index.do");
		int locationIndex = Integer.parseInt(where) - 11;
		
		
		
		ArrayList<String> locationList = new ArrayList<>();
		for(String A : location) {
			locationList.add(A);
		}
		where = locationList.get(locationIndex);
		
		if(userGrade == 1) {
		String certifiedCampus = boardMapper.getCertifiedCampus(id);
		if(!certifiedCampus.equals(where))return new ModelAndView("redirect:index.do");
		if(id ==null || id.equals(""))return new ModelAndView("redirect:index.do");
		String checkRandomId = (String)session.getAttribute("randomId");
		if(checkRandomId == null) {
		Random random = new Random();
		StringBuffer buf = new StringBuffer();
		for(int i = 0 ; i < 8 ; i++) {
			if(random.nextBoolean()) {
				buf.append((char)((int)(random.nextInt(26))+97));
			}else {
				buf.append((random.nextInt(10)));
			}
		}
		String randomId = buf.toString();
		session.setAttribute("randomId", randomId);
		}
		}
		if(userGrade ==2) {
			session.setAttribute("randomId", id);
		}
		Map<String,Integer> map = setStartRowAndEndRow(req);
		
		int count = boardMapper.campusBoardCount(where);
		
		setEndRowWhenCountIsLessThanEndRow(map, count);
		
		List<ReviewBoardDTO> list = boardMapper.getCampusBoard(map.get("startRow"),map.get("endRow"),where);
		
		ModelAndView mav = finishMakeModelAndView(map, list, count);
		
		mav.setViewName("board/campusBoardList");
		mav.addObject("where", where);
		mav.addObject("whereCode",locationIndex+11);
		return mav;
		
		
	}
	@RequestMapping("/campus_write.board")
	public ModelAndView campusBoardWirte(HttpServletRequest req) {
		String where = req.getParameter("where");
		System.out.println(where);
		ModelAndView mav = new ModelAndView("board/campusBoardWrite");
		String[] locationList = new CampusModel().getLocationList();
		String reviewAddr = locationList[Integer.parseInt(where)-11];
		mav.addObject("reviewAddr", reviewAddr);
		mav.addObject("reviewAddrCode",Integer.parseInt(where));
		return mav;
	}
	@RequestMapping(value="/campus_writePro.board")
	public String campusWritePro(HttpServletRequest req, @ModelAttribute ReviewBoardDTO dto, 
			BindingResult result, @RequestParam String reviewAddr, @RequestParam int where) {
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
		
		String[] locationList = new CampusModel().getLocationList();
		dto.setCategory(locationList[where-11]);
		
		boardMapper.campusInsert(dto);
		return "redirect:campusBoardList.board?where="+where;
	}
	@RequestMapping("/campus_detail.board")
	public ModelAndView campusDetail(@RequestParam int article_num, @RequestParam int where) {
		int whereCode = where - 11;
		String[] locationList = new CampusModel().getLocationList();
		String campusName = locationList[whereCode];
		String table = "ezen_campus_board";
		commonMapper.A_plusReadCount(article_num, table);
		ReviewBoardDTO reviewDetail = commonMapper.A_detail(article_num, table);
		List<ReplyDTO> replyList = replyMapper.replyList(article_num);
		ModelAndView mav = new ModelAndView("board/campusBoardDetail");
		mav.addObject("uploadPath", uploadPath);
		mav.addObject("reviewDetail", reviewDetail);
		mav.addObject("replyList", replyList);
		mav.addObject("where", campusName);
		mav.addObject("whereCode",where);
		return mav;
	}
	@RequestMapping("/commonChangeVisibleStatus.board")
	public void commonChangeVisibleStatus(HttpServletRequest req) {
		int article_num = Integer.parseInt(req.getParameter("article_num"));
		commonMapper.changeVisibleStatus(article_num, "ezen_campus_board");
	}
	@RequestMapping("/campusupdownPro.board")
	public void campusUpdownPro(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String table = "ezen_campus_board";
		int article_num = Integer.parseInt(req.getParameter("article_num"));
		String userId = req.getParameter("userId");
		String somethingDo = req.getParameter("somethingDo");
		String res;
		int check = boardMapper.checkUserUpDown(article_num, userId);
		if(check>0) {
			res = "-2";
		}else {
			if(somethingDo.equals("up")) {
				res = boardMapper.upBoard(article_num, userId, table)+"";
			}else {
				res = boardMapper.downBoard(article_num, userId, table)+"";
			}
		}
		resp.getWriter().write(res);
	}
	@RequestMapping("/campus_delete.board")
	public String campusDelete(@RequestParam int article_num, @RequestParam int where) {
		String table = "ezen_campus_board";
		ReviewBoardDTO reviewDetail = commonMapper.A_detail(article_num, table);
		System.out.println(reviewDetail.getArticle_num()+"<�۹�ȣ ����ũ��>"+reviewDetail.getFilesize());
		if(reviewDetail.getFilesize() == 0) {
			commonMapper.A_delete(article_num, table);
		}
		else{
			commonMapper.A_fileDelete(article_num, table);
			commonMapper.A_delete(article_num, table);
		}
		return "redirect:campusBoardList.board?where="+where;
	}
	@RequestMapping("/campus_reply_write.board")
	public String campusReplyWritePro(@RequestParam int article_num, HttpServletRequest req,
			@RequestParam String id, @RequestParam String content) {
		ReplyDTO dto = new ReplyDTO();
		int reply_num = 0;
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
}
