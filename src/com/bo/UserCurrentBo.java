package com.bo;

import java.util.Date;

import com.enums.FundStatus;
import com.enums.FundType;
import com.enums.OrderType;

public class UserCurrentBo {

	private OrderType orderType;
	
	private String cardNo;
	
	private String timeType="1";
	
	private String name;
	
	private Date startTime;
	
	private Date endTime;
	
	private int page;

	private FundStatus[] fundStatus;
	
	private Long companyId;
	
	private Long userId;
	
	private String type;
	
	private FundType fundType;
	
	private String lawWay;
	
	private String storePeriod;
	
	public OrderType getOrderType() {
		return orderType;
	}

	public void setOrderType(OrderType orderType) {
		this.orderType = orderType;
	}

	public String getTimeType() {
		return timeType;
	}

	public void setTimeType(String timeType) {
		this.timeType = timeType;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public FundStatus[] getFundStatus() {
		return fundStatus;
	}

	public void setFundStatus(FundStatus[] fundStatus) {
		this.fundStatus = fundStatus;
	}

	public Long getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Long companyId) {
		this.companyId = companyId;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getCardNo() {
		return cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	public FundType getFundType() {
		return fundType;
	}

	public void setFundType(FundType fundType) {
		this.fundType = fundType;
	}

	public String getLawWay() {
		return lawWay;
	}

	public void setLawWay(String lawWay) {
		this.lawWay = lawWay;
	}

	public String getStorePeriod() {
		return storePeriod;
	}

	public void setStorePeriod(String storePeriod) {
		this.storePeriod = storePeriod;
	}
	
	
}
