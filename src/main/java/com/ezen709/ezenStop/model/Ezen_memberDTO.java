package com.ezen709.ezenStop.model;

public class Ezen_memberDTO {
	private String email;		//이메일
	private String id;			//아이디
	private String passwd;		//패스워드
	private String name;		//이름
	private String reg_date;	//가입일
	private String where;		//학원지점
	private int grade;			//회원등급
	private int status;			//인증대기,인증완료
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
	public String getWhere() {
		return where;
	}
	public void setWhere(String where) {
		this.where = where;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
}
