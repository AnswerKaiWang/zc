package com.entity;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserSecondPic extends BaseEntity{

	private static final long serialVersionUID = -7055880320962438064L;
	private Long custId;//客户id
	private Long cardTypeId;//证照类型
	private String picName;
	private String picYouxiaoqi;
	private Date picCreateTime;
	private String picPath;//表示集合
	private String remark;
}
