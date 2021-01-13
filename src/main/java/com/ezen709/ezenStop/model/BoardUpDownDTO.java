package com.ezen709.ezenStop.model;

public class BoardUpDownDTO {
	private int article_num; //글번호
	private String userId; //유저아이디
	private int behavior; //유저의 행동  1-추천 -1-비추천 2-신고
	
	public int getArticle_num() {
		return article_num;
	}
	public void setArticle_num(int article_num) {
		this.article_num = article_num;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getBehavior() {
		return behavior;
	}
	public void setBehavior(int behavior) {
		this.behavior = behavior;
	}
	
	
}
