package com.enums;

public enum UserType {
	
	qiye,geren;
	
	 private String description;


		public String getDescription() {
			if(this.equals(UserType.qiye)){
				return "机构";
			}
			if(this.equals(UserType.geren)){
				return "个人";
			}
			return "";
		}
		
		public UserType get(String description){
			UserType[] cardTypes=UserType.values();
			for (UserType cardType : cardTypes) {
				if(cardType.getDescription().equals(description)){
					return cardType;
				}
			}
			return null;
		}
}
