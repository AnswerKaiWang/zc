/**
 * 
 */
package com.entity;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年8月26日下午8:54:54
 * @desc	
 */
@Getter
@Setter
public class FundRecord extends BaseEntity {
	private static final long serialVersionUID = -4234238511837981638L;
	private String name;
	private String startTime;
	private String endTime;
	private Integer storeDays;
	private String totalMoney;
	private String remark;
	private Long fundId;
}
