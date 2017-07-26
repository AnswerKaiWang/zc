package com.bo;

import java.util.Date;

public class FundAccountBo extends BaseBo{

	private Long id;
	
	private Long fundId;//基金编号
	
	private String money;//金额
	
	private Date beginTime;
	
	private String startMoney;//净值开始区间
	
	private String endMoney;//净值结束区间
	
	private Long sm;//净值开始区间
	
	private Long em;//净值结束区间

	private String fundName;
	
	private Long companyId;
	public Long getFundId() {
		return fundId;
	}

	public void setFundId(Long fundId) {
		this.fundId = fundId;
	}

	public String getStartMoney() {
		return startMoney;
	}

	public void setStartMoney(String startMoney) {
		this.startMoney = startMoney;
	}

	public String getEndMoney() {
		return endMoney;
	}

	public void setEndMoney(String endMoney) {
		this.endMoney = endMoney;
	}

	public Long getSm() {
		return sm;
	}

	public void setSm(Long sm) {
		this.sm = sm;
	}

	public Long getEm() {
		return em;
	}

	public void setEm(Long em) {
		this.em = em;
	}

	public String getMoney() {
		return money;
	}

	public void setMoney(String money) {
		this.money = money;
	}

	public Date getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(Date beginTime) {
		this.beginTime = beginTime;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Long companyId) {
		this.companyId = companyId;
	}

	public String getFundName() {
		return fundName;
	}

	public void setFundName(String fundName) {
		this.fundName = fundName;
	}


	
	
	
}
