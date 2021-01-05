package com.ezen709.ezenStop;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ezen709.ezenStop.model.ChatDTO;
import com.ezen709.ezenStop.service.ChatMapper;

@Controller
public class ChatController {
	@Autowired
	private ChatMapper chatMapper;
	
	@RequestMapping(value="/chatSubmit.chat", method= {RequestMethod.GET,RequestMethod.POST})
	public void chatSubmit(HttpServletRequest req,HttpServletResponse resp, @ModelAttribute ChatDTO dto) throws IOException {
		req.setCharacterEncoding("EUC-KR");
		resp.setContentType("text/html);charset=EUC-KR");
		if(dto.getChatContent()==null||dto.getChatContent().equals("")) {
			resp.getWriter().write(0);
			return;
		}
		int res = chatMapper.submit(dto.getFromId(), dto.getToId(), dto.getChatContent());
		resp.getWriter().write(res);
		return;
	}
	@RequestMapping(value="/chatList.chat", method= {RequestMethod.GET,RequestMethod.POST})
	public void chatList(HttpServletRequest req,HttpServletResponse resp) throws IOException{
		req.setCharacterEncoding("EUC-KR");
		resp.setContentType("text/html);charset=EUC-KR");
		String fromId = URLDecoder.decode(req.getParameter("fromId"), "EUC-KR");
		String toId = URLDecoder.decode(req.getParameter("toId"), "EUC-KR");
		String listType = URLDecoder.decode(req.getParameter("listType"), "EUC-KR");
		if(listType==null||listType.equals("")) {
			resp.getWriter().write("");
		}else if(listType.equals("ten")) resp.getWriter().write(getTen(URLDecoder.decode(fromId,"EUC-KR"),URLDecoder.decode(toId,"EUC-KR")));
		else {
			try {
				resp.getWriter().write(getId(URLDecoder.decode(fromId,"EUC-KR"), URLDecoder.decode(toId,"EUC-KR"), listType));
			}catch(Exception e) {
				e.printStackTrace();
				resp.getWriter().write("");
			}
		}
		
	}
	public String getTen(String fromId, String toId) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		List<ChatDTO> chatList = chatMapper.getChatListByRecent(fromId, toId, 100);
		if(chatList.size()==0) return"";
		for(int i = 0 ; i < chatList.size(); i++) {
			result.append("[{\"value\": \"" + chatList.get(i).getFromId() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getToId() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getChatContent() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getChatTime() + "\"}]");
			if( i!= chatList.size() -1) result.append(",");
		}
		result.append("], \"last\":\"" + chatList.get(chatList.size()-1).getChatId() +"\"}");
		chatMapper.readChat(fromId, toId);
		return result.toString();
	}
	public String getId(String fromId, String toId, String chatId) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		List<ChatDTO> chatList = chatMapper.getChatListById(fromId, toId, chatId);
		System.out.println(chatList.size());
		if(chatList.size()==0) return"";
		for(int i = 0 ; i < chatList.size(); i++) {
			result.append("[{\"value\": \"" + chatList.get(i).getFromId() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getToId() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getChatContent() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getChatTime() + "\"}]");
			if( i!= chatList.size() -1) result.append(",");
		}
		result.append("], \"last\":\"" + chatList.get(chatList.size()-1).getChatId() +"\"}");
		chatMapper.readChat(fromId, toId);
		return result.toString();
	}
	@RequestMapping(value="/getMessageBox.chat", method= {RequestMethod.GET,RequestMethod.POST})
	public void getMessageBox(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		HttpSession session = req.getSession();
		String userId = (String)session.getAttribute("userId");
		List<ChatDTO> list = chatMapper.getMessageBox(userId);
		for(int i = 0 ; i < list.size(); i++) {
			ChatDTO x = list.get(i);
			for(int j = 0 ; j < list.size() ; j++) {
				ChatDTO y = list.get(j);
				if(x.getFromId().equals(y.getToId())&&x.getToId().equals(y.getFromId())) {
					if(x.getChatId()<y.getChatId()) {
						list.remove(x);
						i--;
						break;
					} else {
						list.remove(y);
						j--;
					}
				}
			}
		}
		try {
			userId = URLDecoder.decode(userId, "EUC-KR");
			resp.getWriter().write(getMessage(userId));
		} catch (Exception e) {
			e.printStackTrace();
			resp.getWriter().write("");
		}
		
	}
	public String getMessage(String userId) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		List<ChatDTO> chatList = chatMapper.getMessageBox(userId);
		System.out.println(chatList.size());
		if(chatList.size()==0) return"";
		for(int i = 0 ; i < chatList.size(); i++) {
			result.append("[{\"value\": \"" + chatList.get(i).getFromId() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getToId() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getChatContent() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getChatTime() + "\"}]");
			if( i!= chatList.size() -1) result.append(",");
		}
		result.append("], \"last\":\"" + chatList.get(chatList.size()-1).getChatId() +"\"}");
		return result.toString();
	}
}
