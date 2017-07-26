package com.enums;

public enum  CardType {
 
	shenfenzheng,huzhao,yingyezhizhao,qitazhengzhao;
	
	 private String description;


		public String getDescription() {
			if(this.equals(CardType.shenfenzheng)){
				return "身份证";
			}
			if(this.equals(CardType.huzhao)){
				return "护照";
			}
			if(this.equals(CardType.yingyezhizhao)){
				return "营业执照";
			}
			if(this.equals(CardType.qitazhengzhao)){
				return "其他证照";
			}
			return "";
		}
		public CardType get(String description){
			CardType[] cardTypes=CardType.values();
			for (CardType cardType : cardTypes) {
				if(cardType.getDescription().equals(description)){
					return cardType;
				}
			}
			return null;
		}
}
