/**
 * 
 */
package com.bo.cura;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月3日下午4:20:47
 * @desc	风险测评提交
 */
@Getter
@Setter
public class RiskEvaluationBo implements Serializable {

	private static final long serialVersionUID = 1L;
	private Long userSecondId = null;
	private String custName;
	private String cardType;
	private String cardNo;
	private String linkWay;
	private String evalTime;
	//题目：qid_qaId
	private String topic1;
	private String topic2;
	private String topic3;
	private String topic4;
	private String topic5;
	private String topic6;
	private String topic7;
	private String topic8;
	private String topic9;
	private String topic10;
	private String topic11;
	private String topic12;
	private String topic13;
	private String topic14;
	private String topic15;
	private String topic16;
	private String topic17;
}
