package com.ezen709.ezenStop;

import java.util.*;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import com.ezen709.ezenStop.service.LoginMapper;

@Controller
public class LoginController {
	
	@Autowired
	private LoginMapper	loginMapper;
	
	@RequestMapping(value="/login.login", method=RequestMethod.GET)//�α��ι�ư ������ ��
	public String login() {
		return "login/login";
	}
	@RequestMapping(value="/login.login", method=RequestMethod.POST)//
	public String login_ok() {
		return "login/login";
	}	
	@RequestMapping(value="/sign_up.login", method=RequestMethod.POST)//ȸ�����Թ�ư ������ ��
	public String sign_up(HttpServletRequest req) {
		return "login/sign_up";
	}
	@RequestMapping(value="/sign_up_ok.login", method=RequestMethod.POST)
	public String sign_up_ok(HttpServletRequest request) {
		
		return "message2";
	}
	@RequestMapping(value="/email.login", method=RequestMethod.GET)//ȸ�����Թ�ư ������ �� �̸��� ����������
	public String email() {
		return "login/email";
	}
	@RequestMapping(value="/email_ok.login")	//������ȣ���� ������
	public ModelAndView email_ok(HttpServletRequest req) {
		
		
		return new ModelAndView("login/email_ok");
	}
	@RequestMapping("/find.login")
	public String find() {
		return "login/find";
	}
	@RequestMapping("/email_confirm.login") //������ȣ �߼� 
	public ModelAndView email_confirm(HttpServletRequest request, ModelMap mo) throws Exception{
			ModelAndView mav = new ModelAndView("message2");
			String toEmail = request.getParameter("email"); // �޴»������
			
		try {
			HttpSession session = request.getSession();
			String mailProtocol = "smtp";
			String mailHost = "smtp.gmail.com";
			String mailPort = "587";
			String mailId = "ezenstop@gmail.com"; // ���۰���
			String mailPassword = "ezen9510008"; // ���۰��� ��й�ȣ
			String fromName = "�����׸�";			//�����»�� �̸�
			String fromEmail = "ezenstop@gamil.com"; // ������ ��� ����
			String toName = "�޴»���̸�";
			String hardNumber =String.valueOf((int)(Math.random()*900000+100000));
			String mailTitle = "�����׸� �̸��� ������ȣ �Դϴ�.";
			String mailContents = 
					"�ȳ��ϼ��� EZEN's TOP ȸ������ �Դϴ� ������ȣ�� '"+hardNumber+"' �Դϴ�.";
			request.setAttribute("hardNumber", hardNumber);
			session.setAttribute("email", toEmail);
			String debugMode = "false";
			String authMode = "true";
			String mmsg="������ȣ�� �߼��Ͽ����ϴ�", url="confirm";
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
			// ����ƽ�Լ��� ���� ������ �ʰ� ��ü�� �̿��ؼ� ������ ��ü�� �ݾ��ش�.
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
