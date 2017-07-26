package com.enums;

public enum  SmsType {
 
	bindEmail,unBindEmail,bindPhone,unbindPhone;
	
	 private String description;


		public String getDescription() {
			if(this.equals(SmsType.bindEmail)){
				return "绑定email";
			}
			if(this.equals(SmsType.unBindEmail)){
				return "解绑email";
			}
			if(this.equals(SmsType.bindPhone)){
				return "绑定手机";
			}
			if(this.equals(SmsType.unbindPhone)){
				return "解绑手机";
			}
			return "";
		}
		public SmsType get(String description){
			SmsType[] cardTypes=SmsType.values();
			for (SmsType cardType : cardTypes) {
				if(cardType.getDescription().equals(description)){
					return cardType;
				}
			}
			return null;
		}
}
