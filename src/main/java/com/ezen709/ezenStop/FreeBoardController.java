package com.ezen709.ezenStop;

import java.io.File;
import java.io.IOException;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;
import java.util.UUID;

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

import com.ezen709.ezenStop.model.ReplyDTO;
import com.ezen709.ezenStop.model.ReviewBoardDTO;
import com.ezen709.ezenStop.service.LJH_boardMapper;
import com.ezen709.ezenStop.service.ReplyMapper;


@Controller
public class FreeBoardController {
	
	@Autowired
	LJH_boardMapper boardMapper;
	@Autowired
	ReplyMapper replyMapper;
	
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
	
	@RequestMapping("/free_list.board")
	public ModelAndView free_list(HttpServletRequest req) {
		Map<String,Integer> map = setStartRowAndEndRow(req);
		String table = "ezen_free_board";
		int count = boardMapper.A_getCount(table);
		setEndRowWhenCountIsLessThanEndRow(map, count);
		List<ReviewBoardDTO> freeList = boardMapper.A_list(table, map.get("startRow"), map.get("endRow"));
		ModelAndView mav = finishMakeModelAndView(map, freeList, count);
		String cate = "FREE";
		List<ReviewBoardDTO> noticeList = boardMapper.A_notice_list(cate);
		mav.addObject("noticeList",noticeList);
		mav.setViewName("board/freeList");
		return mav;
	}
	@RequestMapping(value="/free_write.board", method=RequestMethod.GET)
	public String freeWriteForm() {
		return "board/freeWrite";
	}
	@RequestMapping(value="/free_write.board", method=RequestMethod.POST)
	public String freewWritePro(HttpServletRequest req, @ModelAttribute ReviewBoardDTO dto, 
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
		String table="ezen_free_board";
		dto.setDetaillocation("free_detail.board");
		dto.setSubject(subject);
		dto.setImage(image);
		dto.setFilesize(filesize);
		int res = boardMapper.A_insert(dto,table);
		return "redirect:free_list.board";
	}
	@RequestMapping("/free_detail.board")
	public ModelAndView freeDetail(@RequestParam int article_num) {
		String table = "ezen_free_board";
		boardMapper.A_plusReadCount(article_num,table);
		List<ReplyDTO> replyList = replyMapper.replyList(article_num);
		ReviewBoardDTO freeDetail = boardMapper.A_detail(article_num,table);
		ModelAndView mav = new ModelAndView("board/freeDetail");
		mav.addObject("uploadPath", uploadPath);
		mav.addObject("freeDetail", freeDetail);
		mav.addObject("replyList",replyList);
		return mav;
	}
	@RequestMapping(value="/free_edit.board", method=RequestMethod.GET)
	public ModelAndView freeEdit(@RequestParam int article_num) {
		String table = "ezen_free_board";
		ReviewBoardDTO freeDetail = boardMapper.A_detail(article_num,table);
		ModelAndView mav = new ModelAndView("board/freeEdit");
		String subject = freeDetail.getSubject();
		freeDetail.setSubject(subject);
		String[] categoryList = {"[잡담]","[질문]","[상담]","[기타]"};
		mav.addObject("categoryList", categoryList);
		mav.addObject("freeDetail", freeDetail);
		return mav;
	}
	@RequestMapping(value="/free_edit.board", method=RequestMethod.POST)
	public String freeEditPro(HttpServletRequest req, @ModelAttribute ReviewBoardDTO dto, 
			BindingResult result,@RequestParam String image0, @RequestParam int filesize0) {
		if(result.hasErrors()) {}
		String table = "ezen_free_board";
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
		return "redirect:free_list.board";
	}
	@RequestMapping("/free_delete.board")
	public String freeDelete(@RequestParam int article_num) {
		String table = "ezen_free_board";
		ReviewBoardDTO freeDetail = boardMapper.A_detail(article_num,table);
		System.out.println(freeDetail.getArticle_num()+"<글번호 파일크기>"+freeDetail.getFilesize());
		if(freeDetail.getFilesize() == 0) {
			boardMapper.A_delete(article_num,table);
		}
		else{
			String image = freeDetail.getImage();
			int res = boardMapper.A_delete(article_num,table);
			if(res>0) {
				File target = new File(uploadPath, image);
				freeDetail.setFilesize(0);
				target.delete();
			}
		}
		return "redirect:free_list.board";
	}
	@RequestMapping("/free_find.board")
	public ModelAndView searchFree(HttpServletRequest req) throws IOException {
		String searchType = req.getParameter("searchType");
		String searchString = "%"+req.getParameter("searchString")+"%";
		String table = "ezen_free_board";
		
		Map<String,Integer> map = setStartRowAndEndRow(req);
		
		int count = boardMapper.searchListGetCount(table,searchType,searchString);
		
		setEndRowWhenCountIsLessThanEndRow(map, count);
		
		List<ReviewBoardDTO> freeList = boardMapper.A_searchList(table,searchType, searchString, map.get("startRow"), map.get("endRow"));
		
		ModelAndView mav = finishMakeModelAndView(map, freeList, count);
		
		mav.setViewName("board/freeList");
		
		return mav;
	}
	@RequestMapping("/free_reply_delete.board")
	public String free_replyDeletePro(@RequestParam int reply_num, @RequestParam int article_num) {
		ReplyDTO dto = replyMapper.replyDetail(reply_num);
		dto.setContent("%$#@!");
		replyMapper.replyDelete(reply_num, dto);
		int replyCount = replyMapper.replyCount(article_num);
		String table = "ezen_free_board";
		boardMapper.A_updateReplyCount(article_num, replyCount, table);
		return "redirect:free_detail.board?article_num="+article_num;
	}
	@RequestMapping("/free_reply_write.board")
	public String free_replyWritePro(@RequestParam int article_num, HttpServletRequest req,
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
		String table = "ezen_free_board";
		boardMapper.A_updateReplyCount(dto.getArticle_num(), replyCount, table);
		return "redirect:free_detail.board?article_num="+article_num;
	}
}
