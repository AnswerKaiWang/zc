package com.entity;

import java.util.Date;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.util.JsonDateSerialize;
import com.util.JsonMoneySerialize;

/**
 * 客户分红
 * @author syblike
 *
 */
public class UserBonus extends BaseEntity{

	private static final long serialVersionUID = -5362109341888052595L;

	private Date okTime;//分红日期
	
	private Long userId;//分红用户
	
	private Long fundId;//分红基金
	
	private Long companyId;//分红公司
	
	private String type;//分红方式
	
	private Date dengjiTime;//权益登记日
	
	private Date sendTime;//发放日
	
	private Long share;//份额
	
	private Long oneMoney;//每单位分红
	
	private Long totalMoney;//总额
	
	private Long realMoney;//实发金额

	@JsonSerialize(using=JsonDateSerialize.class)
	public Date getOkTime() {
		return okTime;
	}

	public void setOkTime(Date okTime) {
		this.okTime = okTime;
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
	@JsonSerialize(using=JsonDateSerialize.class)
	public Date getDengjiTime() {
		return dengjiTime;
	}

	public void setDengjiTime(Date dengjiTime) {
		this.dengjiTime = dengjiTime;
	}
	@JsonSerialize(using=JsonDateSerialize.class)
	public Date getSendTime() {
		return sendTime;
	}

	public void setSendTime(Date sendTime) {
		this.sendTime = sendTime;
	}

	public Long getShare() {
		return share;
	}

	public void setShare(Long share) {
		this.share = share;
	}
	@JsonSerialize(using=JsonMoneySerialize.class)
	public Long getOneMoney() {
		return oneMoney;
	}

	public void setOneMoney(Long oneMoney) {
		this.oneMoney = oneMoney;
	}
	@JsonSerialize(using=JsonMoneySerialize.class)
	public Long getTotalMoney() {
		return totalMoney;
	}

	public void setTotalMoney(Long totalMoney) {
		this.totalMoney = totalMoney;
	}
	@JsonSerialize(using=JsonMoneySerialize.class)
	public Long getRealMoney() {
		return realMoney;
	}

	public void setRealMoney(Long realMoney) {
		this.realMoney = realMoney;
	}
	
	
	
}
