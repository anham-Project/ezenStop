package com.ezen709.ezenStop;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {
	
	@RequestMapping(value="/", method=RequestMethod.GET)
	public String home(HttpServletRequest req) {
		req.setAttribute("userId", "userId");
		req.setAttribute("toId", "toId");
		
		return "chat/message";
	}
}
