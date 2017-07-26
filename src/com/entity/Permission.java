package com.entity;

/**
 * 基础权限
 * @author syblike
 *
 */

public class Permission extends BaseEntity{

	private static final long serialVersionUID = -7134675321398789692L;
	
	private String name;//权限名称		
	
	private String value;//权限值
	
	private String iconCls;//图标
	
	private String groups;//类型 nav:菜单 button:普通
	
	private Long parentId;//父类权限


	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getIconCls() {
		return iconCls;
	}

	public void setIconCls(String iconCls) {
		this.iconCls = iconCls;
	}


	public String getGroups() {
		return groups;
	}

	public void setGroups(String groups) {
		this.groups = groups;
	}

	public Long getParentId() {
		return parentId;
	}

	public void setParentId(Long parentId) {
		this.parentId = parentId;
	}

}
