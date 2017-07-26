package com.entity;

import java.util.Date;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.util.JsonDateSerialize;
import com.util.JsonMoney4Serialize;
import com.util.JsonMoneySerialize;

/**
 * 基金净值
 * @author Administrator
 *
 */
public class FundAccount extends BaseEntity{

	private static final long serialVersionUID = -1524051944223674898L;

	private Long fundId;//基金编号
	
	private Date beginTime; //日期
	
	private Long money;//净值
	
	private Long allMoney;//累计净值
	
	private Long rose;//涨跌幅
	
	private Long companyId;//公司编号
	
	public Long getFundId() {
		return fundId;
	}

	public void setFundId(Long fundId) {
		this.fundId = fundId;
	}

	@JsonSerialize(using=JsonDateSerialize.class)
	public Date getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(Date beginTime) {
		this.beginTime = beginTime;
	}

	@JsonSerialize(using=JsonMoney4Serialize.class)
	public Long getMoney() {
		return money;
	}

	public void setMoney(Long money) {
		this.money = money;
	}
	
	@JsonSerialize(using=JsonMoney4Serialize.class)
	public Long getAllMoney() {
		return allMoney;
	}

	public void setAllMoney(Long allMoney) {
		this.allMoney = allMoney;
	}
	
	@JsonSerialize(using=JsonMoneySerialize.class)
	public Long getRose() {
		return rose;
	}

	public void setRose(Long rose) {
		this.rose = rose;
	}

	public Long getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Long companyId) {
		this.companyId = companyId;
	}
	
	
}
