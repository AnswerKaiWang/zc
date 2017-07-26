package com.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Id;

/**
 * 委托联系人
 */
public class UserSecondContant implements Serializable{

	private static final long serialVersionUID = -6825487999539406113L;
	@Id
	private Long id;//客户id
	
	private String conName;//姓名
	
	private Boolean conSex;//性别
	
	private Long conCardTypeId;//证件类型
	
	private String conCardNo;//证件号码
	
	private String conQixian;//有效期
	
	private String conPhone;//手机
	
	private String conTel;//座机
	
	private String conEmail;//邮箱
	
	private Long conCityId;//城市
	
	private String conAddr;//地址
	
	private Date conBirthday;//生日
	
	private String conZip;//邮编

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getConName() {
		return conName;
	}

	public void setConName(String conName) {
		this.conName = conName;
	}

	public Boolean getConSex() {
		return conSex;
	}

	public void setConSex(Boolean conSex) {
		this.conSex = conSex;
	}

	public Long getConCardTypeId() {
		return conCardTypeId;
	}

	public void setConCardTypeId(Long conCardTypeId) {
		this.conCardTypeId = conCardTypeId;
	}

	public String getConCardNo() {
		return conCardNo;
	}

	public void setConCardNo(String conCardNo) {
		this.conCardNo = conCardNo;
	}

	public String getConQixian() {
		return conQixian;
	}

	public void setConQixian(String conQixian) {
		this.conQixian = conQixian;
	}

	public String getConPhone() {
		return conPhone;
	}

	public void setConPhone(String conPhone) {
		this.conPhone = conPhone;
	}

	public String getConTel() {
		return conTel;
	}

	public void setConTel(String conTel) {
		this.conTel = conTel;
	}

	public String getConEmail() {
		return conEmail;
	}

	public void setConEmail(String conEmail) {
		this.conEmail = conEmail;
	}

	public Long getConCityId() {
		return conCityId;
	}

	public void setConCityId(Long conCityId) {
		this.conCityId = conCityId;
	}

	public String getConAddr() {
		return conAddr;
	}

	public void setConAddr(String conAddr) {
		this.conAddr = conAddr;
	}

	public Date getConBirthday() {
		return conBirthday;
	}

	public void setConBirthday(Date conBirthday) {
		this.conBirthday = conBirthday;
	}

	public String getConZip() {
		return conZip;
	}

	public void setConZip(String conZip) {
		this.conZip = conZip;
	}
}
