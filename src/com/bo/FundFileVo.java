package com.bo;

import com.entity.FundFile;

public class FundFileVo extends FundFile{

	private static final long serialVersionUID = -3061534514458897165L;
	
	private String fundName;//基金名称

	public String getFundName() {
		return fundName;
	}

	public void setFundName(String fundName) {
		this.fundName = fundName;
	}
	
	
	
}
