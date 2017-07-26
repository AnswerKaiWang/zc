/**
 * 
 */
package com.entity;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月3日上午10:08:37
 * @desc	
 */
@Getter
@Setter
public class FundRiskEvaluation extends BaseEntity {
	private static final long serialVersionUID = 1L;
	
	private String riskLevel;//风险等级
	private String riskNature;
	private String riskIntroduce;
	private String suitInvestor;
}
