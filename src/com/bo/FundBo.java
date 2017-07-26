package com.bo;

import com.enums.FundType;

public class FundBo extends BaseBo{


	private Long companyId;
	
	private String name;//名字
	
	private String no;//产品代码
	
	private String bei;//产品备案号
	
	private FundType type;//产品类型
	
	private String status;//产品状态

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNo() {
		return no;
	}

	public void setNo(String no) {
		this.no = no;
	}

	public String getBei() {
		return bei;
	}

	public void setBei(String bei) {
		this.bei = bei;
	}

	public FundType getType() {
		return type;
	}

	public void setType(FundType type) {
		this.type = type;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Long getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Long companyId) {
		this.companyId = companyId;
	}
	
	
	
}
