package com.bo;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class QuestionBo extends BaseBo implements Serializable{
	private static final long serialVersionUID = 1L;
	private String name;
	private Long qtId;
}
