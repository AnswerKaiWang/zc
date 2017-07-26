package com.entity;

import com.enums.Status;
import com.enums.UserType;
/**
 * 客户基础信息
 * @author	tyb
 * @date	2016年8月23日下午4:48:46
 * @desc
 */
public class UserSecond extends BaseEntity{

	private static final long serialVersionUID = 1111658769433506472L;

	private UserType userType;//客户类型
	
	private String userNo;//客户编号
	
	private String password;//密码
	
	private Long memberId;//专属顾问
	
	private String welcomeCode;//邀请码
	
	private String name;//客户名称
	
	private Long userRiskLevelId;//风险等级
	
	private String userEvaluateTime;//评测时间
	
	private Long userLevelId;//客户等级
	
	private Long infoSourceId;//信息来源
	
	private Long customerSourceId;//客户来源
	
	private String note;//备注
	
	private String innerNote;//内部备注
		
	private Status status;//状态

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

	public String getWelcomeCode() {
		return welcomeCode;
	}

	public void setWelcomeCode(String welcomeCode) {
		this.welcomeCode = welcomeCode;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Long getUserLevelId() {
		return userLevelId;
	}

	public void setUserLevelId(Long userLevelId) {
		this.userLevelId = userLevelId;
	}

	public Long getInfoSourceId() {
		return infoSourceId;
	}

	public void setInfoSourceId(Long infoSourceId) {
		this.infoSourceId = infoSourceId;
	}

	public Long getCustomerSourceId() {
		return customerSourceId;
	}

	public void setCustomerSourceId(Long customerSourceId) {
		this.customerSourceId = customerSourceId;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getInnerNote() {
		return innerNote;
	}

	public void setInnerNote(String innerNote) {
		this.innerNote = innerNote;
	}

	public Status getStatus() {
		return status;
	}

	public void setStatus(Status status) {
		this.status = status;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Long getUserRiskLevelId() {
		return userRiskLevelId;
	}

	public void setUserRiskLevelId(Long userRiskLevelId) {
		this.userRiskLevelId = userRiskLevelId;
	}

	public String getUserEvaluateTime() {
		return userEvaluateTime;
	}

	public void setUserEvaluateTime(String userEvaluateTime) {
		this.userEvaluateTime = userEvaluateTime;
	}
}
