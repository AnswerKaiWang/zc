package com.entity;

import java.io.Serializable;

import javax.persistence.Id;

/**
 * 客户个人附加属性
 *
 */
public class UserSecondAttr implements Serializable{

	private static final long serialVersionUID = 8449502893411992323L;
	@Id
	private Long id;//客户id
	
	private Long yearIncomeId;//年收入
	
	private String phoneOne;//其他电话1
	
	private String phoneTwo;//其他电话2
	
	private String canTouru;//可投入金额

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getYearIncomeId() {
		return yearIncomeId;
	}

	public void setYearIncomeId(Long yearIncomeId) {
		this.yearIncomeId = yearIncomeId;
	}

	public String getPhoneOne() {
		return phoneOne;
	}

	public void setPhoneOne(String phoneOne) {
		this.phoneOne = phoneOne;
	}

	public String getPhoneTwo() {
		return phoneTwo;
	}

	public void setPhoneTwo(String phoneTwo) {
		this.phoneTwo = phoneTwo;
	}

	public String getCanTouru() {
		return canTouru;
	}

	public void setCanTouru(String canTouru) {
		this.canTouru = canTouru;
	}


	
}
