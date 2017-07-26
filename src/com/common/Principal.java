package com.common;

import java.io.Serializable;
import java.util.Date;

public class Principal implements Serializable {

	private static final long serialVersionUID = 5798882004228239559L;

	private Long id;

	private String username;
	
	private String name;

	private String ip;
	
	private Long companyId;
	
	private String companyName;
	
	private Date lastLoginTime;
	
	public Principal(Long id, String username,String name,String ip,Long companyId,String companyName) {
		this.id = id;
		this.username = username;
		this.name = name;
		this.ip = ip;
		this.companyId = companyId;
		this.companyName = companyName;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	@Override
	public String toString() {
		return username;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public Long getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Long companyId) {
		this.companyId = companyId;
	}

	public Date getLastLoginTime() {
		return lastLoginTime;
	}

	public void setLastLoginTime(Date lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	
	

}