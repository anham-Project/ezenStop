package com.ezen709.ezenStop.model;

public class BoardReportDTO implements Comparable<BoardReportDTO>{
	private int article_num;
	private String userId;
	private String reportContent;
	private String reportDate;
	private int visible;			// 활성화상태역시 join으로가져오기위해 db엔없지만 생성.
	private int grade;
	private String academyLocation;
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public String getAcademyLocation() {
		return academyLocation;
	}
	public void setAcademyLocation(String academyLocation) {
		this.academyLocation = academyLocation;
	}
	public int getVisible() {
		return visible;
	}
	public void setVisible(int visible) {
		this.visible = visible;
	}
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
	public String getReportContent() {
		return reportContent;
	}
	public void setReportContent(String reportContent) {
		this.reportContent = reportContent;
	}
	public String getReportDate() {
		return reportDate;
	}
	public void setReportDate(String reportDate) {
		this.reportDate = reportDate;
	}
	public int compareTo(BoardReportDTO dto) {
		return Integer.compare(dto.getArticle_num(), this.article_num);
	}
}
