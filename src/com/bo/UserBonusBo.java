package com.bo;

import java.util.Date;

public class UserBonusBo extends BaseBo{

	private Long id;
	
	private Date dengjiSatrtTime;
	
	private Date dengjiEndTime;
	
	private Date sendSatrtTime;
	
	private Date sendEndTime;
	
	private Long companyId;//分红公司
	
	private String type;//分红方式
	
	private Date okTime;//分红日期
	
	private Date dengjiTime;//权益登记日
	
	private Date sendTime;//发放日
	
	private Long userId;//分红用户
	
	private Long fundId;//分红基金
	
	private Long share;//份额
	
	private String oneMoney;//每单位分红
	
	private String totalMoney;//总额
	
	private String realMoney;//实发金额
	
	private String cardNo;
	
	private String phone;
	
	private String name;
	
	private String fundName;
	
	private String userNo;
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Date getDengjiSatrtTime() {
		return dengjiSatrtTime;
	}

	public void setDengjiSatrtTime(Date dengjiSatrtTime) {
		this.dengjiSatrtTime = dengjiSatrtTime;
	}

	public Date getDengjiEndTime() {
		return dengjiEndTime;
	}

	public void setDengjiEndTime(Date dengjiEndTime) {
		this.dengjiEndTime = dengjiEndTime;
	}

	public Date getSendSatrtTime() {
		return sendSatrtTime;
	}

	public void setSendSatrtTime(Date sendSatrtTime) {
		this.sendSatrtTime = sendSatrtTime;
	}

	public Date getSendEndTime() {
		return sendEndTime;
	}

	public void setSendEndTime(Date sendEndTime) {
		this.sendEndTime = sendEndTime;
	}

	public Long getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Long companyId) {
		this.companyId = companyId;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Date getOkTime() {
		return okTime;
	}

	public void setOkTime(Date okTime) {
		this.okTime = okTime;
	}

	public Date getDengjiTime() {
		return dengjiTime;
	}

	public void setDengjiTime(Date dengjiTime) {
		this.dengjiTime = dengjiTime;
	}

	public Date getSendTime() {
		return sendTime;
	}

	public void setSendTime(Date sendTime) {
		this.sendTime = sendTime;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public Long getFundId() {
		return fundId;
	}

	public void setFundId(Long fundId) {
		this.fundId = fundId;
	}

	public Long getShare() {
		return share;
	}

	public void setShare(Long share) {
		this.share = share;
	}

	public String getOneMoney() {
		return oneMoney;
	}

	public void setOneMoney(String oneMoney) {
		this.oneMoney = oneMoney;
	}

	public String getTotalMoney() {
		return totalMoney;
	}

	public void setTotalMoney(String totalMoney) {
		this.totalMoney = totalMoney;
	}

	public String getRealMoney() {
		return realMoney;
	}

	public void setRealMoney(String realMoney) {
		this.realMoney = realMoney;
	}

	public String getCardNo() {
		return cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getFundName() {
		return fundName;
	}

	public void setFundName(String fundName) {
		this.fundName = fundName;
	}

	public String getUserNo() {
		return userNo;
	}

	public void setUserNo(String userNo) {
		this.userNo = userNo;
	}
	
	
}
