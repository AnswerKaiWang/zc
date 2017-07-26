package com.entity;

public class CompanyAttr extends BaseEntity{

	private static final long serialVersionUID = 7521680041298457027L;

	private String name;
	
	private String contant;
	
	private Long companyId;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	
	public String getContant() {
		return contant;
	}

	public void setContant(String contant) {
		this.contant = contant;
	}

	public Long getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Long companyId) {
		this.companyId = companyId;
	}
	
	
}
