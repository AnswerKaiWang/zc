package com.entity;

public class Company extends BaseEntity{

	private static final long serialVersionUID = 6788846744861380327L;

	private String companyNo;
	
	private String name;
	
	private String companyAbbr;//简称
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCompanyNo() {
		return companyNo;
	}

	public void setCompanyNo(String companyNo) {
		this.companyNo = companyNo;
	}
	public String getCompanyAbbr() {
		return companyAbbr;
	}

	public void setCompanyAbbr(String companyAbbr) {
		this.companyAbbr = companyAbbr;
	}
}
