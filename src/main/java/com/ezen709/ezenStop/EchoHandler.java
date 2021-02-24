package com.ezen709.ezenStop;

import java.util.*;

import org.json.JSONObject;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component
public class EchoHandler extends TextWebSocketHandler {
	//연결 요청 처리
		//메세지 받기, 메세지 전달
	
	//WebSocketSession 클라이언트 당 하나씩 생성, 해당 클라이언트와 연결된 웹소켓을 이용할 수 있음
	//해당 객체를 통해 메세지를 주고받음
	private List<WebSocketSession> users;
	private Map<String, Object> userMap;
	
	public EchoHandler() {
		users = new ArrayList<>();
		userMap = new HashMap<>();
	}
	//소켓 연결 생성 후 실행 메소드
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("TextWebSocketHandler : 연결 생성!");
		users.add(session);
	}
	// 메세지 수신 후 실행 메소드
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println("TextWebSocketHandler : 메세지 수신!");
		System.out.println("메세지 : "+message.getPayload());
		JSONObject object = new JSONObject(message.getPayload());
		String type = object.getString("type");
		
		if(type != null && type.equals("register")) {
			//등록 요청 메세지
			String user = object.getString("userId");
			//아이디랑 Session이랑 매핑 >>>>Map
			userMap.put(user, session);
		}else {
			//채팅 메세지 : 상대방 아이디를 포함해서 보낼것이기 때문에
			//Map에서 상대방 아이디에 해당하는 WebSocket을 꺼내와서 메세지 전송
			String target = object.getString("target");
			WebSocketSession ws = (WebSocketSession)userMap.get(target);
			String msg = object.getString("content");
			if(ws!=null) {
				ws.sendMessage(new TextMessage(msg));
				System.out.println("메세지 전송 성공!");
			}
		}
	}
	// 연결 해제 후 실행 메소드
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("TextWebSocketHandler : 연결 종료!");
		users.remove(session);
	}
	
	
	
	
}
