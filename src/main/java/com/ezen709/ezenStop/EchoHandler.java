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
	//���� ��û ó��
		//�޼��� �ޱ�, �޼��� ����
	
	//WebSocketSession Ŭ���̾�Ʈ �� �ϳ��� ����, �ش� Ŭ���̾�Ʈ�� ����� �������� �̿��� �� ����
	//�ش� ��ü�� ���� �޼����� �ְ����
	private List<WebSocketSession> users;
	private Map<String, Object> userMap;
	
	public EchoHandler() {
		users = new ArrayList<>();
		userMap = new HashMap<>();
	}
	//���� ���� ���� �� ���� �޼ҵ�
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("TextWebSocketHandler : ���� ����!");
		users.add(session);
	}
	// �޼��� ���� �� ���� �޼ҵ�
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println("TextWebSocketHandler : �޼��� ����!");
		System.out.println("�޼��� : "+message.getPayload());
		JSONObject object = new JSONObject(message.getPayload());
		String type = object.getString("type");
		
		if(type != null && type.equals("register")) {
			//��� ��û �޼���
			String user = object.getString("userId");
			//���̵�� Session�̶� ���� >>>>Map
			userMap.put(user, session);
		}else {
			//ä�� �޼��� : ���� ���̵� �����ؼ� �������̱� ������
			//Map���� ���� ���̵� �ش��ϴ� WebSocket�� �����ͼ� �޼��� ����
			String target = object.getString("target");
			WebSocketSession ws = (WebSocketSession)userMap.get(target);
			String msg = object.getString("content");
			if(ws!=null) {
				ws.sendMessage(new TextMessage(msg));
				System.out.println("�޼��� ���� ����!");
			}
		}
	}
	// ���� ���� �� ���� �޼ҵ�
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("TextWebSocketHandler : ���� ����!");
		users.remove(session);
	}
	
	
	
	
}
