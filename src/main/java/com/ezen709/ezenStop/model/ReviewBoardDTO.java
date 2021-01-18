package com.ezen709.ezenStop.model;

public class ReviewBoardDTO implements Comparable<ReviewBoardDTO> {
	private int article_num;		/*�۹�ȣ*/
	private String category;		/*�Һз�*/
	private String subject;			/*����*/
	private String id;				/*�ۼ���*/
	private String content;			/*����*/
	private String regdate;			/*�ۼ���*/
	private String regdate_time;	/*�ۼ��ð�*/
	private int readCount;			/*��ȸ��*/
	private int replyCount;			/*��ۼ�*/
	private int upCount;			/*��õ ���� ��*/
	private int downCount;			/*����õ ���� ��*/
	private String detaillocation;		/*�Ű� ���� ��*/
	private int visible;			/*Ȱ��ȭ-1/��Ȱ��ȭ-0*/
	private String image;			/*�̹��� �����̸�*/
	private int filesize;			/*����ũ��*/
	private int grade;				// ������� **** DB ���� ���������� JOIN�Ҷ� �ҷ����°��� ���Ǹ� ���� �������.
	private String academyLocation;	// ���� ķ�۽���ġ
	public String getAcademyLocation() {
		return academyLocation;
	}
	public void setAcademyLocation(String academyLocation) {
		this.academyLocation = academyLocation;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
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
	public String getRegdate_time() {
		return regdate_time;
	}
	public void setRegdate_time(String regdate_time) {
		this.regdate_time = regdate_time;
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
	
	public String getDetaillocation() {
		return detaillocation;
	}
	public void setDetaillocation(String detaillocation) {
		this.detaillocation = detaillocation;
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
	public int compareTo(ReviewBoardDTO dto) {
		return Integer.compare(dto.getArticle_num(), this.article_num);
	}
}
