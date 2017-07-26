package com.bo;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

/**
 * 产品预约查询
 * @author	tyb
 * @date	2016年8月27日上午9:44:59
 * @desc
 */
@Getter
@Setter
public class UserApplyBo implements Serializable{
	private static final long serialVersionUID = 1L;
	private Long fundId;//
	private String fundName;
	private Integer status;
	private String startTime;
	private String endTime;
	private String custName;
	private String custNo;
	private String phone;
	private Long memberId = 0L;
}
