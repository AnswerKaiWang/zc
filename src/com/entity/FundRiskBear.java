/**
 * 
 */
package com.entity;

import javax.persistence.Transient;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月3日上午10:08:27
 * @desc	
 */
@Getter
@Setter
public class FundRiskBear extends BaseEntity {
	private static final long serialVersionUID = 1L;
	private Integer scoreMin;
	private Integer scoreMax;
	private String riskBear;//风险承受能力型
	private String riskNotification;
	private Long riskId;
	private String suitRiskArea;
	
	@Transient
	private String riskLevel;
}
