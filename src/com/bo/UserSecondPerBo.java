package com.bo;

import com.enums.Status;
import com.enums.UserType;

public class UserSecondPerBo extends BaseBo{
	
	private UserType userType;//客户类型
	private String userNo;//客户编号
	private Long memberId;//专属顾问
	private String name;//客户名称
	private Status status;//状态
	private Long perCardTypeId;//证件类型
	private String perCardNo;//证件号码
	private String perPhone;//手机
	private Long infoSourceId;//信息来源
	private Long userLevelId;//客户等级
	public UserType getUserType() {
		return userType;
	}
	public void setUserType(UserType userType) {
		this.userType = userType;
	}
	public String getUserNo() {
		return userNo;
	}
	public void setUserNo(String userNo) {
		this.userNo = userNo;
	}
	public Long getMemberId() {
		return memberId;
	}
	public void setMemberId(Long memberId) {
		this.memberId = memberId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Status getStatus() {
		return status;
	}
	public void setStatus(Status status) {
		this.status = status;
	}
	public Long getPerCardTypeId() {
		return perCardTypeId;
	}
	public void setPerCardTypeId(Long perCardTypeId) {
		this.perCardTypeId = perCardTypeId;
	}
	public String getPerCardNo() {
		return perCardNo;
	}
	public void setPerCardNo(String perCardNo) {
		this.perCardNo = perCardNo;
	}
	public String getPerPhone() {
		return perPhone;
	}
	public void setPerPhone(String perPhone) {
		this.perPhone = perPhone;
	}
	public Long getInfoSourceId() {
		return infoSourceId;
	}
	public void setInfoSourceId(Long infoSourceId) {
		this.infoSourceId = infoSourceId;
	}
	public Long getUserLevelId() {
		return userLevelId;
	}
	public void setUserLevelId(Long userLevelId) {
		this.userLevelId = userLevelId;
	}

	
}
