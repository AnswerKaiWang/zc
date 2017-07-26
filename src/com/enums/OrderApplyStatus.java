package com.enums;

public enum OrderApplyStatus {

	ok,cancel,create;
	
    private String description;


	public String getDescription() {
		if(this.equals(OrderApplyStatus.ok)){
			return "已确认";
		}
		if(this.equals(OrderApplyStatus.create)){
			return "申请中";
		}
		if(this.equals(OrderApplyStatus.cancel)){
			return "已取消";
		}
		return "";
	}
}
