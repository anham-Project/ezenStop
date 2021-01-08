package com.ezen709.ezenStop;

import java.io.File;
import java.io.IOException;
import java.util.*;

import javax.annotation.Resource;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.http.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import com.ezen709.ezenStop.model.*;
import com.ezen709.ezenStop.service.LoginMapper;

@Controller
public class LoginController {
	
	@Resource(name="uploadPath")
	private String uploadPath;
	@Autowired
	private LoginMapper	loginMapper;
	
	@RequestMapping(value="/index.do", method=RequestMethod.GET)//로그인버튼 눌렀을 떄
	public String index() {
		return "index";
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
		mav = new ModelAndView("index");
		session.setAttribute("userId", dto.getId());
		session.setAttribute("userGrade", dto.getGrade());
		return mav;
		}
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
			System.out.println("예외처리");
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
	@RequestMapping("/email_confirm.login") //인증번호 발송 
	public ModelAndView email_confirm(HttpServletRequest request, ModelMap mo) throws Exception{
			ModelAndView mav = new ModelAndView("message2");
			String toEmail = request.getParameter("email"); // 받는사람메일
		try {
			HttpSession session = request.getSession();
			String mailProtocol = "smtp";
			String mailHost = "smtp.gmail.com";
			String mailPort = "587";
			String mailId = "ezenstop@gmail.com"; // 구글계정
			String mailPassword = "ezen9510008"; // 구글계정 비밀번호
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
	public String changePasswd() {
		return "login/dropId";
	}
	@RequestMapping(value="/changePasswd.login", method=RequestMethod.POST) //비밀번호변경
	public ModelAndView changePasswd_ok(@RequestParam String id,@RequestParam String passwd) {
		ModelAndView mav = new ModelAndView("message2");
		loginMapper.change_passwd(id, passwd);
		String msg="비밀번호가 변경되었습니다!", url="changePasswd.login";
		mav.addObject("msg",msg);
		mav.addObject("url",url);
		return mav;
	}
	@RequestMapping(value="/dropId.login", method=RequestMethod.GET) //회원탈퇴 페이지로 이동
	public String dropId() {
		return "login/dropId";
	}
	@RequestMapping(value="/dropId_ok.login", method=RequestMethod.POST) //회원탈퇴
	public ModelAndView dropId_ok(HttpServletRequest req,@RequestParam String id,@RequestParam String passwd) {
		ModelAndView mav = new ModelAndView("message2");
		List<Ezen_memberDTO> al = loginMapper.getMemberDTO(id);
		Ezen_memberDTO dto = al.get(0);
		String msg=null, url=null;
		if(dto.getPasswd().equals(passwd)) {
			loginMapper.dropId(id);
			msg="회원탈퇴 하였습니다!";
			url="cancel";
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
	public String certification() {
		return "login/certification";
	}
	@RequestMapping(value="/certification.login", method=RequestMethod.POST) //회원 인증
	public ModelAndView certification_ok(@ModelAttribute Ezen_certificationDTO, @RequestParam String id, HttpServletRequest req) {
		
		ModelAndView mav = new ModelAndView("message");
		List<Ezen_memberDTO> al = loginMapper.getMemberDTO(id);
		Ezen_memberDTO dto = al.get(0);
		int status = dto.getStatus();
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest)req;
		MultipartFile file = mr.getFile("image");
		File target = new File(uploadPath, file.getOriginalFilename());
		int filesize = 0;
		String image = "파일없음";
		if(file.getSize() > 0 ) {
			if(status==0) {
				try {
					file.transferTo(target);
					filesize = (int)file.getSize();
					image = file.getOriginalFilename();
					loginMapper.insert_certification();//회원 인증 신청 db에 insert
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}else {
				try {
				Ezen_certificationDTO certDTO = loginMapper.getFile();
				File original = new File(uploadPath,certDTO.getImage());
				if(original.delete()) {	//실험용 나중에 삭제
					System.out.println("파일삭제성공");
				}else {
					System.out.println("파일삭제실패");
				}

				file.transferTo(target);
				filesize = (int)file.getSize();
				image = file.getOriginalFilename();
				loginMapper.update_certification();//회원 인증 신청 db에 update
				}catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
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
}
