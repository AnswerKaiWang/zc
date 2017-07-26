package com.entity;

public class QuestionTitleChoose extends BaseEntity{

	private static final long serialVersionUID = -6874353055869009460L;

	private Long titleId;
	
	private String minChoose;//选项小标题

    private String choose;//选择描述

	public String getMinChoose() {
		return minChoose;
	}

	public void setMinChoose(String minChoose) {
		this.minChoose = minChoose;
	}

	public String getChoose() {
		return choose;
	}

	public void setChoose(String choose) {
		this.choose = choose;
	}

	public Long getTitleId() {
		return titleId;
	}

	public void setTitleId(Long titleId) {
		this.titleId = titleId;
	}


  
}