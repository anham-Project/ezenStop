package com.ezen709.ezenStop.model;

public class Ezen_memberDTO {
	private String email;		//�̸���
	private String id;			//���̵�
	private String passwd;		//�н�����
	private String name;		//�̸�
	private String reg_date;	//������
	private String academyLocation;	//�п�����
	private int grade;			//ȸ����� 0 = ������ȸ��, 1 = ���� �� ȸ��, 2 = ������ ���, -1= ����� ȸ��
	private int status;			//0 = ������û ���� ȸ��, 1 = ���� ��û�ϰ� ����� ȸ��, 2 = �����Ϸ� ȸ��
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
