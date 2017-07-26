/**
 * 
 */
package com.bo.cura;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月4日下午4:36:52
 * @desc	
 */
@Getter
@Setter
public class RiskEvaluationResultVo implements Serializable {
	/**
	 * '
	 */
	private static final long serialVersionUID = 1L;
	private String riskBear;
	private String riskLevel;
	private String riskNotification;
	private String suitInvestor;
}
