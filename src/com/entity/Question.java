package com.entity;

import java.util.Date;

import javax.persistence.Transient;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Question extends BaseEntity{
	private static final long serialVersionUID = -9219952357108140793L;
	private String name;
    private Integer type;
    private Date startTime;
    private Date endTime;
    private Integer sort;
    private Long qtId;//questionTime.id，表示某个日期，下的题目
    @Transient
    private String qtName;
}