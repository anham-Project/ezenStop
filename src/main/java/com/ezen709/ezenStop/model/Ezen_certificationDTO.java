package com.ezen709.ezenStop.model;

public class Ezen_certificationDTO {
	private String id;				/*��û�� ���̵�*/
	private String name;			/*��û�� �̸�*/
	private String image;			/*�̹��� �����̸�*/
	private int filesize;			/*����ũ��*/
	private String reg_date;		/*��û��*/
	private String academyLocation;	/*�п�����*/

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getAcademyLocation() {
		return academyLocation;
	}
	public void setAcademyLocation(String academyLocation) {
		this.academyLocation = academyLocation;
	}
}
