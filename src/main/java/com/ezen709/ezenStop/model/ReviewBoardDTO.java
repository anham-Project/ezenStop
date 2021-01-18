package com.ezen709.ezenStop.model;

public class ReviewBoardDTO implements Comparable<ReviewBoardDTO> {
	private int article_num;		/*글번호*/
	private String category;		/*소분류*/
	private String subject;			/*제목*/
	private String id;				/*작성자*/
	private String content;			/*내용*/
	private String regdate;			/*작성일*/
	private String regdate_time;	/*작성시간*/
	private int readCount;			/*조회수*/
	private int replyCount;			/*댓글수*/
	private int upCount;			/*추천 받은 수*/
	private int downCount;			/*비추천 받은 수*/
	private String detaillocation;		/*신고 받은 수*/
	private int visible;			/*활성화-1/비활성화-0*/
	private String image;			/*이미지 파일이름*/
	private int filesize;			/*파일크기*/
	private int grade;				// 유저등급 **** DB 에는 들어가지않지만 JOIN할때 불러오는것의 편의를 위해 만들어줌.
	private String academyLocation;	// 유저 캠퍼스위치
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
