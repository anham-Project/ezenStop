package com.ezen709.ezenStop.model;

public class BoardUpDownDTO {
	private int article_num; //�۹�ȣ
	private String userId; //�������̵�
	private int behavior; //������ �ൿ  1-��õ -1-����õ 2-�Ű�
	
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
