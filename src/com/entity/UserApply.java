package com.entity;


import java.util.Date;

import lombok.Getter;
import lombok.Setter;

/**
 * 用户预约
 *
 */
@Getter
@Setter
public class UserApply extends BaseEntity{
	private static final long serialVersionUID = -8257551445127942077L;
	private Long fundId;//基金编号
	private Long userSecondId;//申请人
	private String applyStatus;//是否取消
	private Long applyMoney;
	private Long confirMoney;
	private Integer applyWay;
	private String note;//备注
	private Long confirUserId;//确认人
	private Date confirDate;
}
