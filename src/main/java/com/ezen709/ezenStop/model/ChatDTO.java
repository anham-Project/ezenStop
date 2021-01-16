package com.ezen709.ezenStop.model;

public class ChatDTO {
	private int chatId;				//채팅 내용을 담고있는 chat객체의 고유primary key;
	private String fromId;			//보내는사람의 id
	private String toId;			//받는사람의 id
	private String chatContent;		//채팅 내용
	private String chatTime;		//메세지를 보낸 시간
	private int chatRead;			//메세지 읽음 여부
	public int getChatRead() {
		return chatRead;
	}
	public void setChatRead(int chatRead) {
		this.chatRead = chatRead;
	}
	public int getChatId() {
		return chatId;
	}
	public void setChatId(int chatId) {
		this.chatId = chatId;
	}
	public String getFromId() {
		return fromId;
	}
	public void setFromId(String fromId) {
		this.fromId = fromId;
	}
	public String getToId() {
		return toId;
	}
	public void setToId(String toId) {
		this.toId = toId;
	}
	public String getChatContent() {
		return chatContent;
	}
	public void setChatContent(String chatContent) {
		this.chatContent = chatContent;
	}
	public String getChatTime() {
		return chatTime;
	}
	public void setChatTime(String chatTime) {
		this.chatTime = chatTime;
	}
}
