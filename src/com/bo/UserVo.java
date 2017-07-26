package com.bo;

import com.entity.User;

public class UserVo extends User{
	private static final long serialVersionUID = 7437302770700184930L;
	
	
	private String companyName;


	public String getCompanyName() {
		return companyName;
	}


	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	
	
	
}
