/**
 * 
 */
package com.entity;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年8月27日下午9:38:24
 * @desc	
 */
@Getter
@Setter
public class QuestionUserRecord extends BaseEntity {
	private static final long serialVersionUID = 1L;
	private Long userSecondId;
	private Integer score;
	private String custName;//客户姓名
	private Integer cardType;//证件类型
	private String cardNo;//证件号
	private String linkWay;//联系方式
	private String evalTime;
	private String riskLevel;
}
