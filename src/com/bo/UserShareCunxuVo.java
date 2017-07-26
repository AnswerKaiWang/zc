package com.bo;

import java.util.Date;

import com.enums.OrderType;

public class UserShareCunxuVo {

	private Long fundId;
	
	private String fundName;
	
	private Long money;
	
	private OrderType type;

	private Date okTime;
	
	private String duration;
	
	private Date createTime;
	
	private Date beginTime;
	
	private Long fundAccountMoney;
	
	private Long share;
	
	private String no;
	
	private String bei;
	
	private String size;
	
	public Long getFundId() {
		return fundId;
	}

	public void setFundId(Long fundId) {
		this.fundId = fundId;
	}

	public String getFundName() {
		return fundName;
	}

	public void setFundName(String fundName) {
		this.fundName = fundName;
	}

	public Long getMoney() {
		return money;
	}

	public void setMoney(Long money) {
		this.money = money;
	}

	public OrderType getType() {
		return type;
	}

	public void setType(OrderType type) {
		this.type = type;
	}

	public Date getOkTime() {
		return okTime;
	}

	public void setOkTime(Date okTime) {
		this.okTime = okTime;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getDuration() {
		return duration;
	}

	public void setDuration(String duration) {
		this.duration = duration;
	}

	public Date getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(Date beginTime) {
		this.beginTime = beginTime;
	}

	public Long getFundAccountMoney() {
		return fundAccountMoney;
	}

	public void setFundAccountMoney(Long fundAccountMoney) {
		this.fundAccountMoney = fundAccountMoney;
	}

	public Long getShare() {
		return share;
	}

	public void setShare(Long share) {
		this.share = share;
	}

	public String getNo() {
		return no;
	}

	public void setNo(String no) {
		this.no = no;
	}

	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}

	public String getBei() {
		return bei;
	}

	public void setBei(String bei) {
		this.bei = bei;
	}
	
	
}
