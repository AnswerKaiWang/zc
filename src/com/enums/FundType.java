package com.enums;

public enum FundType {

	zhengquan,guquan,chuangye,qita;
	
	 private String description;


		public String getDescription() {
			if(this.equals(FundType.zhengquan)){
				return "证券投资基金";
			}
			if(this.equals(FundType.guquan)){
				return "股权投资基金";
			}
			if(this.equals(FundType.chuangye)){
				return "创业投资基金";
			}
			if(this.equals(FundType.qita)){
				return "其他投资基金";
			}
			return "";
		}
		
		public FundType get(String description){
			FundType[] cardTypes=FundType.values();
			for (FundType cardType : cardTypes) {
				if(cardType.getDescription().equals(description)){
					return cardType;
				}
			}
			return null;
		}
}
