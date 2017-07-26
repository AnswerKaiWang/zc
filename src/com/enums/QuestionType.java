package com.enums;

public enum QuestionType {

	ceping,wenjuan;
	
	
	public String getDescription() {
		if(this.equals(QuestionType.ceping)){
			return "测评";
		}
		if(this.equals(QuestionType.wenjuan)){
			return "问卷";
		}
		return "";
	}
	public QuestionType get(String description){
		QuestionType[] cardTypes=QuestionType.values();
		for (QuestionType cardType : cardTypes) {
			if(cardType.getDescription().equals(description)){
				return cardType;
			}
		}
		return null;
	}
}
