package com.ezen709.ezenStop.model;

public class ReplyDTO {
	private int reply_num;
	private int article_num;
	private int re_step;
	private int re_level;
	private String id;
	private String content;
	private String regdate;
	private String regdate_time;
	
	public int getReply_num() {
		return reply_num;
	}
	public void setReply_num(int reply_num) {
		this.reply_num = reply_num;
	}
	public int getAticle_num() {
		return article_num;
	}
	public void setAticle_num(int aticle_num) {
		this.article_num = aticle_num;
	}
	public int getRe_step() {
		return re_step;
	}
	public void setRe_step(int re_step) {
		this.re_step = re_step;
	}
	public int getRe_level() {
		return re_level;
	}
	public void setRe_level(int re_level) {
		this.re_level = re_level;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getRegdate_time() {
		return regdate_time;
	}
	public void setRegdate_time(String regdate_time) {
		this.regdate_time = regdate_time;
	}
	
}
