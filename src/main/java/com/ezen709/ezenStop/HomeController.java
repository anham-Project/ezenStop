package com.ezen709.ezenStop;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {
	
	@RequestMapping(value="/", method=RequestMethod.GET)
	public String home(HttpServletRequest req) {
		//HttpSession session = req.getSession();
		//session.setAttribute("userId", "userId");
		return "index";
	}
}
