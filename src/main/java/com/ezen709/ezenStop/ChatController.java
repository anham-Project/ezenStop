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
	public void chatSubmit(HttpServletRequest req,HttpServletResponse resp) throws IOException {
		req.setCharacterEncoding("EUC-KR");
		resp.setContentType("text/html;charset=EUC-KR");
		HttpSession session = req.getSession();
		String userId = (String)session.getAttribute("userId");
		String toId = (String)session.getAttribute("toId");
		String chatContent = req.getParameter("chatContent");
		ChatDTO dto = new ChatDTO();
		dto.setFromId(userId);
		dto.setToId(toId);
		dto.setChatContent(chatContent);
		if(dto.getChatContent()==null||dto.getChatContent().equals("")) {
			resp.getWriter().write(0);
			return;
		}else if(userId.equals(toId)) {
			resp.getWriter().write(-1);
		}else {
		int res = chatMapper.submit(dto.getFromId(), dto.getToId(), dto.getChatContent());
		resp.getWriter().write(res);
		}
	}
	@RequestMapping(value="/chatList.chat", method= {RequestMethod.GET,RequestMethod.POST})
	public void chatList(HttpServletRequest req,HttpServletResponse resp) throws IOException{
		req.setCharacterEncoding("EUC-KR");
		resp.setContentType("text/html;charset=EUC-KR");
		String fromId = URLDecoder.decode(req.getParameter("fromId"), "EUC-KR");
		String toId = URLDecoder.decode(req.getParameter("toId"), "EUC-KR");
		String listType = URLDecoder.decode(req.getParameter("listType"), "EUC-KR");
		if(listType==null||listType.equals("")) {
			resp.getWriter().write("");
		}else {
			try {
				resp.getWriter().write(getId(URLDecoder.decode(fromId,"EUC-KR"), URLDecoder.decode(toId,"EUC-KR"), listType));
			}catch(Exception e) {
				e.printStackTrace();
				resp.getWriter().write("");
			}
		}
		
	}
	public String getId(String fromId, String toId, String chatId) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		List<ChatDTO> chatList = chatMapper.getChatListById(fromId, toId, chatId);
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
		if(list.size()==0) return"";
		for(int i = list.size()-1 ; i >= 0; i--) {
			String unread = "";
			if(userId.equals(list.get(i).getToId())) {
				unread = chatMapper.getUnreadChat(list.get(i).getFromId(), userId)+"";
				if(unread.equals("0")) unread="";
			}
			result.append("[{\"value\": \"" + list.get(i).getFromId() + "\"},");
			result.append("{\"value\": \"" + list.get(i).getToId() + "\"},");
			result.append("{\"value\": \"" + list.get(i).getChatContent() + "\"},");
			result.append("{\"value\": \"" + list.get(i).getChatTime() + "\"},");
			result.append("{\"value\": \"" + unread + "\"}]");
			if( i!= 0) result.append(",");
		}
		result.append("], \"last\":\"" + list.get(list.size()-1).getChatId() +"\"}");
		return result.toString();
	}
	@RequestMapping(value="/countUnreadMessage.chat", method= {RequestMethod.GET,RequestMethod.POST})
	public void countUnreadMessage(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		HttpSession session = req.getSession();
		String userId = (String)session.getAttribute("userId");
		if(userId==null||userId.equals("")) {
			resp.getWriter().write("0");
		}else {
			userId = URLDecoder.decode(userId, "EUC-KR");
			int res = chatMapper.getAllUnreadChat(userId);
			resp.getWriter().write(res+"");
		}
		
	}
	@RequestMapping(value="/moveChat.chat" , method= RequestMethod.GET)
	public String moveChat(HttpServletRequest req) {
		HttpSession session = req.getSession();
		String toId = req.getParameter("toId");
		session.setAttribute("toId", toId);
		return "chat/message";
	}
	@RequestMapping(value="/moveChatBox.chat", method= {RequestMethod.GET,RequestMethod.POST})
	public String moveChatBox() {
		return "chat/messagebox";
	}
}
