package com.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Id;

/**
 * 商品预约情况
 * @author Administrator
 *
 */
public class FundApply implements Serializable{
 
	private static final long serialVersionUID = -683688193554341843L;

	@Id
    private Long fundId;
	
	private boolean used;
	
	private Long applyMoney;
	
	private Date applyEndTime;

	public boolean getUsed() {
		return used;
	}

	public void setUsed(boolean used) {
		this.used = used;
	}
	
	public Date getApplyEndTime() {
		return applyEndTime;
	}

	public void setApplyEndTime(Date applyEndTime) {
		this.applyEndTime = applyEndTime;
	}

	public Long getFundId() {
		return fundId;
	}

	public void setFundId(Long fundId) {
		this.fundId = fundId;
	}

	public Long getApplyMoney() {
		return applyMoney;
	}

	public void setApplyMoney(Long applyMoney) {
		this.applyMoney = applyMoney;
	}
	
	
	
}
