package com.ezen709.ezenStop.model;

public class ReviewBoardDTO {
	private int article_num;		/*�۹�ȣ*/
	private String category;		/*�Һз�*/
	private String subject;			/*����*/
	private String id;				/*�ۼ���*/
	private String content;			/*����*/
	private String regdate;			/*�ۼ���*/
	private int readCount;			/*��ȸ��*/
	private int replyCount;			/*��ۼ�*/
	private int upCount;			/*��õ ���� ��*/
	private int downCount;			/*����õ ���� ��*/
	private int reportCount;		/*�Ű� ���� ��*/
	private int visible;			/*Ȱ��ȭ-1/��Ȱ��ȭ-0*/
	private String image;			/*�̹��� �����̸�*/
	private int filesize;			/*����ũ��*/
	public int getArticle_num() {
		return article_num;
	}
	public void setArticle_num(int article_num) {
		this.article_num = article_num;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
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
	public int getReadCount() {
		return readCount;
	}
	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}
	public int getReplyCount() {
		return replyCount;
	}
	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}
	public int getUpCount() {
		return upCount;
	}
	public void setUpCount(int upCount) {
		this.upCount = upCount;
	}
	public int getDownCount() {
		return downCount;
	}
	public void setDownCount(int downCount) {
		this.downCount = downCount;
	}
	public int getReportCount() {
		return reportCount;
	}
	public void setReportCount(int reportCount) {
		this.reportCount = reportCount;
	}
	public int getVisible() {
		return visible;
	}
	public void setVisible(int visible) {
		this.visible = visible;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public int getFilesize() {
		return filesize;
	}
	public void setFilesize(int filesize) {
		this.filesize = filesize;
	}
	
}