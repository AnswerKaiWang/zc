package com.bo;

import com.entity.FundAccount;

public class FundAccountVo extends FundAccount{

	private static final long serialVersionUID = -1261394687547434250L;
	
	private String no;
	
	private String fundName;//基金名称

	public String getFundName() {
		return fundName;
	}

	public void setFundName(String fundName) {
		this.fundName = fundName;
	}

	public String getNo() {
		return no;
	}

	public void setNo(String no) {
		this.no = no;
	}
	
	
	
}
