package com.entity;

import com.enums.Status;
/**
 * 角色表
 * @author syblike
 *
 */
public class Role extends BaseEntity{

	private static final long serialVersionUID = -5682758630591931651L;

	private String name;//角色名称
	
	private String description;//角色分组

	private Status status;
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Status getStatus() {
		return status;
	}

	public void setStatus(Status status) {
		this.status = status;
	}

	
	

	
}
