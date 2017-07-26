package com.entity;

import java.util.Date;

import com.enums.OrderType;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.util.JsonDateSerialize;
import com.util.JsonMoney4Serialize;
import com.util.JsonMoneySerialize;

/**
 * 份额信息
 *
 */
public class UserShare extends BaseEntity{

	private static final long serialVersionUID = -1997908258429581645L;

	private Long fundId;//基金编号
	
	private Long userId;//申请人
	
	private Date okTime;//确认日期
	
	private Long fundAccountMoney;//当前净值
	
	private OrderType type;//申请类型
	
	private Long money;//确认金额
	
	private Long share;//确认份额

	private Long companyId;//公司
	
	public Long getFundId() {
		return fundId;
	}

	public void setFundId(Long fundId) {
		this.fundId = fundId;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	@JsonSerialize(using=JsonDateSerialize.class)
	public Date getOkTime() {
		return okTime;
	}

	public void setOkTime(Date okTime) {
		this.okTime = okTime;
	}
	@JsonSerialize(using=JsonMoney4Serialize.class)
	public Long getFundAccountMoney() {
		return fundAccountMoney;
	}

	public void setFundAccountMoney(Long fundAccountMoney) {
		this.fundAccountMoney = fundAccountMoney;
	}

	public OrderType getType() {
		return type;
	}

	public void setType(OrderType type) {
		this.type = type;
	}

	@JsonSerialize(using=JsonMoneySerialize.class)
	public Long getMoney() {
		return money;
	}

	public void setMoney(Long money) {
		this.money = money;
	}
	public Long getShare() {
		return share;
	}

	public void setShare(Long share) {
		this.share = share;
	}

	public Long getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Long companyId) {
		this.companyId = companyId;
	}
	
	
}
