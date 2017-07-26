package com.enums;

public enum FundFileType {

	mujiwenjian,hetong,piluwenjian;
	
	public String getDescription() {
		if(this.equals(FundFileType.mujiwenjian)){
			return "募集文件";
		}
		if(this.equals(FundFileType.hetong)){
			return "合同";
		}
		if(this.equals(FundFileType.piluwenjian)){
			return "披露文件";
		}
		return "";
	}
}
