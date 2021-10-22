package com.ezen709.ezenStop;

import java.io.File;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

import javax.annotation.Resource;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.http.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import com.ezen709.ezenStop.model.*;
import com.ezen709.ezenStop.service.BoardMapper;
import com.ezen709.ezenStop.service.LoginMapper;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class LoginController {
	CampusModel campusModel = new CampusModel();
	
	@Resource(name="uploadPath")
	private String uploadPath;
	@Autowired
	private LoginMapper	loginMapper;
	@Autowired
	private BoardMapper boardMapper;
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
	
	@RequestMapping(value="/index.do", method=RequestMethod.GET)//로그인버튼 눌렀을 떄
	public ModelAndView index() {
		List<ReviewBoardDTO> hot = boardMapper.getHotBoard();
		List<ReviewBoardDTO> list = hot.stream().sorted(Comparator.comparing(ReviewBoardDTO::getUpCount).reversed()).collect(Collectors.toList());
		if(list.size()>=6) {
		for(int i=6; i<list.size(); i++) {
		list.remove(i);
			}
		}
		Map<String,List<ReviewBoardDTO>> index = boardMapper.getIndexBoard();
		
		ModelAndView mav = new ModelAndView("index");
		mav.addObject("hotList", list);
		mav.addObject("indexListMap",index);
		return mav;
	}
	
	@RequestMapping(value="/login.login", method=RequestMethod.GET)//로그인버튼 눌렀을 떄
	public String login() {
		return "login/login";
	}
	@RequestMapping(value="/login.login", method=RequestMethod.POST)//
	public ModelAndView login_ok(HttpServletRequest req) {
		List<Ezen_memberDTO> list = loginMapper.login(req.getParameter("id"),req.getParameter("passwd"));
		HttpSession session = req.getSession();
		ModelAndView mav;
		if(list.size()==0) {
			mav = new ModelAndView("message2");
			String msg="없는 회원이거나 아이디 혹은 비밀번호가 일치하지 않습니다.";
			String url="login.login";
			mav.addObject("msg",msg);
			mav.addObject("url",url);
			return mav;
		}else {
		Ezen_memberDTO dto =list.get(0);
		if(dto.getGrade() == -1) {
			mav =  new ModelAndView("message2");
			mav.addObject("msg", "관리자에 의해 정지된 회원입니다. 관리자에게 문의하세요");
			mav.addObject("url","index.do");
			return mav;
		}
		mav = new ModelAndView("redirect:index.do");
		session.setAttribute("userId", dto.getId());
		session.setAttribute("userGrade", dto.getGrade());
		return mav;
		}
	}
	@RequestMapping(value="/kakao.login")
	public ModelAndView kbk(String code, HttpServletRequest req) {
		HttpSession session = req.getSession();
		ModelAndView mav = new ModelAndView("login/kakao");
		// POST방식으로 key=value 데이터를 요청(카카오쪽으로)
		//Retrofit2 --안드로이드에서 많이 씀
		//Okhttp 
		//RestTemplate
		RestTemplate rt = new RestTemplate();
		//HttpHeader 오브젝트 생성
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-type", "application/x-www-form-urlencoded;chareset=utf-8");
		//HttpBody 오브젝트 생성
		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("client_id","270731007f2c443403dd4204eaf7e9b2"); //원래는 변수화 시켜서 사용하는게 좋다.
		params.add("grant_type","authorization_code");
		params.add("redirect_uri","http://localhost:8005/ezenStop/kakao.login");
		params.add("code",code);
		//HttpHeader와 HttpBody를 하나의 오브젝트에 담기
		HttpEntity<MultiValueMap<String,String>> kakaoTokenRequest = new HttpEntity<>(params,headers);
		
		// Http 요청하기 - post방식으로 - 그리고 responese 변수의 응답 받음
		ResponseEntity<String> response =rt.exchange(
				"https://kauth.kakao.com/oauth/token",
				HttpMethod.POST,
				kakaoTokenRequest,
				String.class
		);
		//Gson,Json Simple, ObjectMapper -- json형태 데이터 받기
		ObjectMapper objectMapper = new ObjectMapper();
		OAuthToken oauthToken = null;
		try {
			oauthToken = objectMapper.readValue(response.getBody(), OAuthToken.class);
			session.setAttribute("ACT", oauthToken.getAccess_token());
		} catch (JsonParseException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		//사용자 정보 가져오기 요청
		RestTemplate rt2 = new RestTemplate();
		HttpHeaders headers2 = new HttpHeaders();
		headers2.add("Content-type", "application/x-www-form-urlencoded;chareset=utf-8");
		headers2.add("Authorization", "Bearer "+oauthToken.getAccess_token());
		HttpEntity<MultiValueMap<String,String>> kakaoProfileRequest2 = new HttpEntity<>(headers2);
		ResponseEntity<String> response2 =rt2.exchange(
				"https://kapi.kakao.com/v2/user/me",
				HttpMethod.POST,
				kakaoProfileRequest2,
				String.class
		);
		ObjectMapper objectMapper2 = new ObjectMapper();
		KakaoProfile kakaoProfile = null;
		try {
			kakaoProfile = objectMapper2.readValue(response2.getBody(), KakaoProfile.class);
		} catch (JsonParseException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		String get_email = kakaoProfile.kakao_account.email;
		mav.addObject("response",response2);
		int res = loginMapper.kakao_check(get_email);
		System.out.println(res);
		if(res == 1) {
			Ezen_memberDTO dto = loginMapper.get_info(get_email);
			String url, msg;
			url = "dropId";
			msg = "로그인 되었습니다.";
			mav = new ModelAndView("message2");
			mav.addObject("url",url);
			mav.addObject("msg",msg);
			session.setAttribute("userId", dto.getId());
			session.setAttribute("userGrade", dto.getGrade());
		}else {
			System.out.print("여기까진 완료");
//			mav = new ModelAndView("redirect:/sign_up.login");
//			session.setAttribute("email",get_email);
		}
		return mav;
	}
	@RequestMapping(value="/logout.login")//로그아웃버튼 눌렀을 떄
	public ModelAndView logout(HttpServletRequest req ) {
		ModelAndView mav = new ModelAndView("message2");
		HttpSession session = req.getSession();
		session.invalidate();
		String msg = "로그아웃 되었습니다!", url = "index.do";
		mav.addObject("msg",msg);
		mav.addObject("url",url);
		return mav;
	}
	@RequestMapping(value="/sign_up.login", method=RequestMethod.POST)//회원가입버튼 눌렀을 떄
	public String sign_up(HttpServletRequest req) {
		return "login/sign_up";
	}
	@RequestMapping(value="/sign_up_ok.login", method=RequestMethod.POST)
	public ModelAndView sign_up_ok(HttpServletRequest req, @ModelAttribute Ezen_memberDTO dto, BindingResult result) {
		if(result.hasErrors()) {
		}
		dto.setAcademyLocation("none");
		dto.setGrade(0);
		dto.setStatus(0);
		int res = loginMapper.createMember(dto);
		String msg=null,url="cancel";
		if(res>0) {
			msg="회원가입 완료했습니다";
		}else {
			msg="회원가입에서 오류가 발생했습니다.";
			}
		ModelAndView mav = new ModelAndView("message2");
		mav.addObject("msg",msg);
		mav.addObject("url",url);
		return mav;
	}
	@RequestMapping("/id_check.login")
	public void id_check(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String id = req.getParameter("id");
		if(id.equals("")) {
			resp.getWriter().write("공백");
			return;
		}
		String res = String.valueOf(loginMapper.id_check(id));
		resp.getWriter().write(res);
	}

	@RequestMapping(value="/email.login", method=RequestMethod.GET)//회원가입버튼 눌렀을 때 이메일 인증페이지
	public String email() {
		return "login/email";
	}
	@RequestMapping(value="/email_ok.login")	//인증번호적기 페이지
	public ModelAndView email_ok(HttpServletRequest req) {
		String hardNumber = req.getParameter("hardNumber");
		return new ModelAndView("login/email_ok","hardNumber",hardNumber);
	}
	@RequestMapping("/find.login")
	public String find() {
		return "login/find";
	}
	@RequestMapping("/find_id.login")
	public ModelAndView findId(@RequestParam String name,@RequestParam String email) {
		String id = loginMapper.find_id(name, email);
		String msg=null, url="find.login";
		ModelAndView mav = new ModelAndView("message2");
		if(StringUtils.isEmpty(id)){
			msg = "일치하는 회원이 없습니다";}
		else {
			int blind = id.length()-3;
			String blindId = id.substring(0,blind);
			msg = "회원님의 아이디는 "+blindId+"*** 입니다";
		}
		mav.addObject("msg",msg);
		mav.addObject("url",url);
		return mav;
	}
	@RequestMapping("/find_passwd.login")
	public ModelAndView findPasswd(@RequestParam String name,@RequestParam String email,@RequestParam String id) {
		ModelAndView mav = new ModelAndView();
		String msg=null, url="find.login";
		int count = loginMapper.find_passwd(name,email,id);
		if(count>0) {
				String passwd = loginMapper.change_passwd(id);
				msg="발급되신 임시 비밀번호는 '"+passwd+"'입니다";
		}else {
				msg="일치하는 회원이 없습니다";
		}
		mav.addObject("msg",msg);
		mav.addObject("url",url);
		mav.setViewName("message2");
		return mav;
	}
	@RequestMapping("/email_check.login")
	public void email_check(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String email = req.getParameter("email");
		String res = String.valueOf(loginMapper.emailCheck(email));
		resp.getWriter().write(res);
	}

	@RequestMapping("/email_confirm.login") //인증번호 발송 
	public ModelAndView email_confirm(HttpServletRequest request) throws Exception{
			ModelAndView mav = new ModelAndView("login/email_ok");
			String toEmail = request.getParameter("email"); // 받는사람메일
		try {
			HttpSession session = request.getSession();
			String mailProtocol = "smtp";
			String mailHost = "smtp.gmail.com";
			String mailPort = "587";
			String mailId = "ezenstop@gmail.com"; // 구글계정
			String mailPassword = "stop9510008"; // 구글계정 비밀번호
			String fromName = "이젠그만";			//보내는사람 이름
			String fromEmail = "ezenstop@gmail.com"; // 보내는 사람 메일
			String toName = "받는사람이름";
			String hardNumber =String.valueOf((int)(Math.random()*900000+100000));
			String mailTitle = "이젠그만 이메일 인증번호 입니다.";
			String mailContents = 
					"안녕하세요 EZEN's TOP 회원가입 입니다 인증번호는 '"+hardNumber+"' 입니다.";
			session.setAttribute("email", toEmail);
			String debugMode = "false";
			String authMode = "true";
			String mmsg="인증번호를 발송하였습니다", url="confirm";
			mav.addObject("hardNumber",hardNumber);
			mav.addObject("msg", mmsg);
			mav.addObject("url", url);
			boolean debug = Boolean.valueOf(debugMode).booleanValue();
			Properties mailProps = new Properties();
			mailProps.put("mail.smtp.starttls.enable", "true");
			mailProps.setProperty("mail.transport.protocol", mailProtocol);
			mailProps.put("mail.debug", debugMode);
			mailProps.put("mail.smtp.host", mailHost);
			mailProps.put("mail.smtp.port", mailPort);
			mailProps.put("mail.smtp.connectiontimeout", "5000");
			mailProps.put("mail.smtp.timeout", "5000");
			mailProps.put("mail.smtp.auth", authMode);
			Session msgSession = null;
			if (authMode.equals("true")) {
				Authenticator auth = new MyAuthentication(mailId, mailPassword);
				msgSession = Session.getInstance(mailProps, auth);
			} else {
				msgSession = Session.getInstance(mailProps, null);
			}
			msgSession.setDebug(debug);
			MimeMessage msg = new MimeMessage(msgSession);
			msg.setFrom(new InternetAddress(fromEmail, fromName));
			msg.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail, toName));
			msg.setSubject(mailTitle);
			msg.setContent(mailContents, "text/html; charset=euc-kr");
			// 스태틱함수로 직접 보내지 않고 객체를 이용해서 보내고 객체를 닫아준다.
			Transport t = msgSession.getTransport(mailProtocol);
			try {
				t.connect();
				t.sendMessage(msg, msg.getAllRecipients());
			} finally {
				t.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	@RequestMapping(value="/myInfo.login") //마이페이지 정보 보기
	public ModelAndView myInfo(@RequestParam String id) {
		ModelAndView mav = new ModelAndView("login/myInfo");
		List<Ezen_memberDTO> al = loginMapper.getMemberDTO(id);
		Ezen_memberDTO dto = al.get(0);
		mav.addObject("myPageDTO",dto);
		return mav;
	}
	@RequestMapping(value="/changePasswd.login", method=RequestMethod.GET) //비밀번호변경 페이지로 이동
	public ModelAndView changePasswd(@RequestParam String id) {
		ModelAndView mav = new ModelAndView("login/changePasswd");
		List<Ezen_memberDTO> list = loginMapper.getMemberDTO(id);
		Ezen_memberDTO dto = list.get(0);
		mav.addObject("passwdOri",dto.getPasswd());
		mav.addObject("id",id);
		return mav;
	}
	@RequestMapping(value="/changePasswd.login", method=RequestMethod.POST) //비밀번호변경
	public ModelAndView changePasswd_ok(@RequestParam String id,@RequestParam String passwd) {
		ModelAndView mav = new ModelAndView("message2");
		loginMapper.change_passwd(id, passwd);
		String msg="비밀번호가 변경되었습니다!", url="changePasswd.login?id="+id;
		mav.addObject("msg",msg);
		mav.addObject("url",url);
		return mav;
	}
	@RequestMapping(value="/dropId.login", method=RequestMethod.GET) //회원탈퇴 페이지로 이동
	public String dropId() {
		return "login/dropId";
	}
	@RequestMapping(value="/dropId.login", method=RequestMethod.POST) //회원탈퇴
	public ModelAndView dropId_ok(HttpServletRequest req,@RequestParam String id,@RequestParam String passwd) {
		ModelAndView mav = new ModelAndView("message2");
		List<Ezen_memberDTO> al = loginMapper.getMemberDTO(id);
		Ezen_memberDTO dto = al.get(0);
		String msg=null, url=null;
		if(dto.getPasswd().equals(passwd)) {
			loginMapper.dropId(id);
			loginMapper.dropChat(id);
			List<Ezen_certificationDTO> list = loginMapper.getFile(id);
			if(list.size()>0) {
				Ezen_certificationDTO certDTO = list.get(0);
				File original = new File(uploadPath,certDTO.getImage());
				original.delete();
			}
			loginMapper.dropImage(id);
			msg="회원탈퇴 하였습니다!";
			url="dropId";
		}else {
			msg="비밀번호가 일치하지 않습니다.!";
			url="dropId.login";
		}
		mav.addObject("msg",msg);
		mav.addObject("url",url);
		HttpSession session = req.getSession();
		session.invalidate();
		return mav;
	}
	@RequestMapping(value="/certification.login", method=RequestMethod.GET) //회원인증 페이지로 이동
	public ModelAndView certification() {
		ModelAndView mav = new ModelAndView("login/certification");
		String[] locationList = campusModel.getLocationList();
		mav.addObject("locationList",locationList);
		return mav;
	}
	@RequestMapping(value="/certification.login", method=RequestMethod.POST) //회원 인증
	public ModelAndView certification_ok(@RequestParam String id, @RequestParam String academy, HttpServletRequest req) {
		ModelAndView mav = new ModelAndView("message2");
		List<Ezen_memberDTO> al = loginMapper.getMemberDTO(id);
		Ezen_memberDTO dto = al.get(0);
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest)req;
		MultipartFile file = mr.getFile("image");
		UUID uuid = UUID.randomUUID();
		String file_name = uuid.toString()+"_"+file.getOriginalFilename();
		File target = new File(uploadPath, file_name);
		int filesize = 0;
		String msg = null, url="certification.login";
		Ezen_certificationDTO certDTO = new Ezen_certificationDTO();
		if(file.getSize() > 0 ) {
			if(dto.getStatus()==0) {
				try {
					file.transferTo(target);
					filesize = (int)file.getSize();
					certDTO.setId(dto.getId());
					certDTO.setName(dto.getName());
					certDTO.setImage(file_name);
					certDTO.setFilesize(filesize);
					certDTO.setAcademyLocation(academy);
					loginMapper.insert_certification(certDTO);//회원 인증 신청 db에 insert
					loginMapper.member_upStatus(id);
					msg = "인증 신청완료";
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}else {
				try {
				List<Ezen_certificationDTO> list = loginMapper.getFile(id);
				if(list.size()>0) {
					Ezen_certificationDTO DTO = list.get(0);
					File original = new File(uploadPath,DTO.getImage());
					original.delete();
				}
				file.transferTo(target);
				filesize = (int)file.getSize();
				System.out.print(file_name);
				loginMapper.update_certification(id,academy,file_name,filesize);//회원 인증 신청 db에 update
				msg = "인증 수정완료";
				}catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		mav.addObject("msg",msg);
		mav.addObject("url",url);
		return mav;
	}
	@RequestMapping("/member_management.login")
	public ModelAndView memberList(HttpServletRequest req) {
		Map<String,Integer> map = setStartRowAndEndRow(req);
		int count = loginMapper.memberGetCount();
		setEndRowWhenCountIsLessThanEndRow(map, count);
		List<Ezen_memberDTO> list = loginMapper.getMemberList(map.get("startRow"),map.get("endRow"));
		ModelAndView mav = finishMakeModelAndView(map, list, count);
		String[] locationList = campusModel.getLocationList();
		mav.setViewName("login/mbmt");
		mav.addObject("locationList",locationList);
		return mav;
	}
	@RequestMapping("/view_waitting.login")
	public ModelAndView view_all(HttpServletRequest req) {
		Map<String,Integer> map = setStartRowAndEndRow(req);
		int count = loginMapper.waittingMemberGetCount();
		setEndRowWhenCountIsLessThanEndRow(map, count);
		List<Ezen_memberDTO> list = loginMapper.getWaittingMemberList(map.get("startRow"),map.get("endRow"));
		ModelAndView mav = finishMakeModelAndView(map, list, count);
		String[] locationList = campusModel.getLocationList();
		mav.setViewName("login/mbmt");
		mav.addObject("locationList",locationList);
		return mav;
	}
	@RequestMapping("/search_member.login")
	public ModelAndView searchMember(HttpServletRequest req) throws IOException {
		String searchType = req.getParameter("searchType");
		String searchString = "%"+req.getParameter("searchString")+"%";
		Map<String,Integer> map = setStartRowAndEndRow(req);
		int count = loginMapper.searchMemberGetCount(searchType,searchString);
		setEndRowWhenCountIsLessThanEndRow(map, count);
		List<Ezen_memberDTO> list = loginMapper.searchMember(searchType,searchString,map.get("startRow"),map.get("endRow"));
		ModelAndView mav = finishMakeModelAndView(map, list, count);
		String[] locationList = campusModel.getLocationList();
		mav.setViewName("login/mbmt");
		mav.addObject("locationList",locationList);
		return mav;
	}
	@RequestMapping("/edit_ok.login")
	public ModelAndView edit_ok(@ModelAttribute(value="MultiRowMember") MultiRowMember dtolist) {
		ModelAndView mav = new ModelAndView("message2");
		String msg="변경 완료되었습니다.", url="member_management.login";
		mav.addObject("msg",msg);
		mav.addObject("url",url);
		List<Ezen_memberDTO>list = dtolist.getDtoList();
		for(int i = 0; i<list.size(); i++) {
			Ezen_memberDTO dto = list.get(i);
			loginMapper.updateMember(dto.getAcademyLocation(),dto.getId(),dto.getGrade(),dto.getStatus());
		}
		return mav;
	}
	@RequestMapping("/view_file.login")
	public ModelAndView view_file(@RequestParam String id) {
		ModelAndView mav = new ModelAndView("login/view_file");
		Ezen_certificationDTO dto = new Ezen_certificationDTO();
		List<Ezen_certificationDTO> list = loginMapper.getFile(id);
		if(list.size()>0) {
			dto = list.get(0);
		}
		mav.addObject("upPath",uploadPath);
		mav.addObject("CMDTO",dto);
		return mav;
	}
	@RequestMapping("/myBoard.login")
	public ModelAndView getmyBoard(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		HttpSession session = req.getSession();
		String id = (String)session.getAttribute("userId");
		Map<String,Integer> map = setStartRowAndEndRow(req);
		int count = loginMapper.myBoardGetCount(id);
		setEndRowWhenCountIsLessThanEndRow(map, count);
		List<ReviewBoardDTO> list = loginMapper.myBoardList(id,map.get("startRow"),map.get("endRow"));
		ModelAndView mav = finishMakeModelAndView(map, list, count);
		mav.setViewName("login/myBoard");
		return mav;
	}
	@RequestMapping("/myBoard_find.board")
	public ModelAndView search_myBoard(HttpServletRequest req) {
		String searchType = req.getParameter("searchType");
		String searchString = "%"+req.getParameter("searchString")+"%";
		String id = req.getParameter("id");
		Map<String,Integer> map = setStartRowAndEndRow(req);
		int count = loginMapper.search_myBoardGetCount(id,searchType,searchString);
		setEndRowWhenCountIsLessThanEndRow(map, count);
		List<ReviewBoardDTO> list = loginMapper.search_myBoard(id,searchType,searchString,map.get("startRow"),map.get("endRow"));
		ModelAndView mav = finishMakeModelAndView(map, list, count);
		mav.setViewName("login/myBoard");
		return mav;
	}
	class MyAuthentication extends Authenticator {
	    PasswordAuthentication pa;
	    public MyAuthentication(String mailId, String mailPass) {
	        pa = new PasswordAuthentication(mailId, mailPass);  
	    }
	    public PasswordAuthentication getPasswordAuthentication() {
	        return pa;
	    }
	}
	@RequestMapping("/blockList.login")
	public ModelAndView blockList(@RequestParam String id,HttpServletRequest req) {
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null) {
			pageNum = "1";
		}
		int pageSize = 5;
		int currentPage = Integer.parseInt(pageNum);
		int startRow = pageSize * currentPage - (pageSize - 1);
		int endRow = pageSize * currentPage;
		Map<String,Integer> map = new Hashtable<>();
		map.put("currentPage", currentPage);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		map.put("pageSize", pageSize);
		int count = loginMapper.myBlockListCount(id);
		setEndRowWhenCountIsLessThanEndRow(map, count);
		List<BlockDTO> list = loginMapper.blockList(id,map.get("startRow"),map.get("endRow"));
		ModelAndView mav = finishMakeModelAndView(map, list, count);
		mav.setViewName("login/blockList");
		return mav;
	}
	@RequestMapping("blockList_search.login")
	public ModelAndView search_blockList(HttpServletRequest req) {
		String searchType = req.getParameter("searchType");
		String searchString = "%"+req.getParameter("searchString")+"%";
		String id = req.getParameter("id");
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null) {
			pageNum = "1";
		}
		int pageSize = 5;
		int currentPage = Integer.parseInt(pageNum);
		int startRow = pageSize * currentPage - (pageSize - 1);
		int endRow = pageSize * currentPage;
		Map<String,Integer> map = new Hashtable<>();
		map.put("currentPage", currentPage);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		map.put("pageSize", pageSize);
		int count = loginMapper.search_myBlockListCount(id,searchType,searchString);
		setEndRowWhenCountIsLessThanEndRow(map, count);
		List<BlockDTO> list = loginMapper.search_blockList(id,searchType,searchString,map.get("startRow"),map.get("endRow"));
		ModelAndView mav = finishMakeModelAndView(map, list, count);
		mav.setViewName("login/blockList");
		return mav;
	}
	@RequestMapping("addBlock.login")
	public ModelAndView block_user(HttpServletRequest req) {
		String blockId = req.getParameter("blockId");
		String id = req.getParameter("id");
		ModelAndView mav = new ModelAndView("login/block_user");
		HttpSession session =req.getSession();
		session.setAttribute("id", id);
		mav.addObject("blockId",blockId);
		return mav;
	}
	@RequestMapping("addBlock_ok.login")
	public ModelAndView block_user_ok(@ModelAttribute BlockDTO dto,HttpServletRequest req) {
		ModelAndView mav = new ModelAndView("message2");
		HttpSession session = req.getSession();
		int res = loginMapper.addBlock(dto);
		if (res>0) {
			String url="addBlock";
			String msg="차단되었습니다.";
			mav.addObject("url",url);
			mav.addObject("msg",msg);
			List<String> blockList = loginMapper.blockIdList(dto.getId());
			session.setAttribute("blockList",blockList);
		} else {
			System.out.print("차단 오류");
		}
		return mav;
	}
	@RequestMapping("release_block.login")
	public ModelAndView release_block(@RequestParam String userId, @RequestParam String blockId) {
		ModelAndView mav = new ModelAndView("message2");
		int res = loginMapper.release_block(userId,blockId);
		if (res>0) {
			String fun = "release_block";
			String url = "blockList.login?id="+userId;
			String msg = "차단이 해제되었습니다!";
			mav.addObject("fun",fun);
			mav.addObject("url",url);
			mav.addObject("msg",msg);
		}else {
			System.out.print("차단해제 오류");
		}
		return mav;
	}
}
