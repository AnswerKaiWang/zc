package com.bo;

import com.entity.UserBonus;

public class UserBonusVo extends UserBonus {
	
	private static final long serialVersionUID = -8674784606484471775L;

	private String fundName;//基金名称
	
	private String no;//基金编号
	
	private String userNo;
	
	private String cardNo;
	
	private String phone;
	
	private String name;
	
	public String getFundName() {
		return fundName;
	}

	public void setFundName(String fundName) {
		this.fundName = fundName;
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

	public String getNo() {
		return no;
	}

	public void setNo(String no) {
		this.no = no;
	}

	public String getUserNo() {
		return userNo;
	}

	public void setUserNo(String userNo) {
		this.userNo = userNo;
	}
	
	
}
