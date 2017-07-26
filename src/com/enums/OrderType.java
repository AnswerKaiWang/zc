package com.enums;

public enum OrderType {

	ok,add,back;
	
    private String description;


	public String getDescription() {
		if(this.equals(OrderType.ok)){
			return "认购";
		}
		if(this.equals(OrderType.add)){
			return "申购";
		}
		if(this.equals(OrderType.back)){
			return "赎回";
		}
		return "";
	}
	
	public OrderType get(String description){
		OrderType[] cardTypes=OrderType.values();
		for (OrderType cardType : cardTypes) {
			if(cardType.getDescription().equals(description)){
				return cardType;
			}
		}
		return null;
	}
}
