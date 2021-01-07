package com.ezen709.ezenStop.model;

public class Ezen_memberDTO {
	private String email;		//이메일
	private String id;			//아이디
	private String passwd;		//패스워드
	private String name;		//이름
	private String reg_date;	//가입일
	private String academyLocation;	//학원지점
	private int grade;			//회원등급 0 = 인증전회원, 1 = 인증 후 회원, 2 = 관리자 등급, -1= 블락된 회원
	private int status;			//0 = 인증신청 안한 회원, 1 = 인증 신청하고 대기중 회원, 2 = 인증완료 회원
	public String getAcademyLocation() {
		return academyLocation;
	}
	public void setAcademyLocation(String academyLocation) {
		this.academyLocation = academyLocation;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
}
