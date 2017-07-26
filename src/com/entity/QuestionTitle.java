package com.entity;

public class QuestionTitle extends BaseEntity{
	
	private static final long serialVersionUID = 40335091487386104L;

	private String minTitle;//小标题

    private String title;

    private Integer score;//得分

    private String type="0";//0:单选项 1:多选项 2:天空 

    private Long questionId;
    
	public String getMinTitle() {
		return minTitle;
	}

	public void setMinTitle(String minTitle) {
		this.minTitle = minTitle;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Integer getScore() {
		return score;
	}

	public void setScore(Integer score) {
		this.score = score;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Long getQuestionId() {
		return questionId;
	}

	public void setQuestionId(Long questionId) {
		this.questionId = questionId;
	}

   
}