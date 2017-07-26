package com.bo;

import java.util.Date;

import com.enums.OrderType;

public class UserShareBo extends BaseBo{

	private Long id;
	
	private Long fundId;//基金编号
	
	private OrderType type;//申请类型
	
	private Long userId;
	
	private Long companyId;

	private Date okTime;//确认日期
	
	private String fundAccountMoney;//当前净值
	
	private String money;//确认金额
	
	private Long share;//确认份额

	private String cardNo;
	
	private String phone;
	
	private String name;
	
	private String userNo;
	
	private String fundName;
	
	public Long getFundId() {
		return fundId;
	}

	public void setFundId(Long fundId) {
		this.fundId = fundId;
	}

	public OrderType getType() {
		return type;
	}

	public void setType(OrderType type) {
		this.type = type;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public Long getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Long companyId) {
		this.companyId = companyId;
	}

	public Date getOkTime() {
		return okTime;
	}

	public void setOkTime(Date okTime) {
		this.okTime = okTime;
	}

	public String getFundAccountMoney() {
		return fundAccountMoney;
	}

	public void setFundAccountMoney(String fundAccountMoney) {
		this.fundAccountMoney = fundAccountMoney;
	}

	public String getMoney() {
		return money;
	}

	public void setMoney(String money) {
		this.money = money;
	}
	public Long getShare() {
		return share;
	}

	public void setShare(Long share) {
		this.share = share;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
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

	public String getUserNo() {
		return userNo;
	}

	public void setUserNo(String userNo) {
		this.userNo = userNo;
	}

	public String getFundName() {
		return fundName;
	}

	public void setFundName(String fundName) {
		this.fundName = fundName;
	}

	

	
	
	
}
