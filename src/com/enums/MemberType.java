package com.enums;

public enum MemberType {

		caifuguwen;
	
		private String description;


		public String getDescription() {
			if(this.equals(MemberType.caifuguwen)){
				return "财富顾问";
			}
			return "";
		}
		public MemberType get(String description){
			MemberType[] cardTypes=MemberType.values();
			for (MemberType cardType : cardTypes) {
				if(cardType.getDescription().equals(description)){
					return cardType;
				}
			}
			return null;
		}
}
