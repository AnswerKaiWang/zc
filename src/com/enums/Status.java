package com.enums;

public enum Status {
	
	use,finish;
	
    private String description;


	public String getDescription() {
		if(this.equals(Status.use)){
			return "启用";
		}
		if(this.equals(Status.finish)){
			return "禁用";
		}
		return "";
	}
}

