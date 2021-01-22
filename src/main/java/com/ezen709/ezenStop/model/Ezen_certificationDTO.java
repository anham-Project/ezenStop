package com.ezen709.ezenStop.model;

public class Ezen_certificationDTO {
	private String id;				/*신청한 아이디*/
	private String name;			/*신청한 이름*/
	private String image;			/*이미지 파일이름*/
	private int filesize;			/*파일크기*/
	private String reg_date;		/*신청일*/
	private String academyLocation;	/*학원지점*/

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
