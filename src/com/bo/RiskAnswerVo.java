/**
 * 
 */
package com.bo;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月3日下午2:47:40
 * @desc	测评答案
 */
@Getter
@Setter
public class RiskAnswerVo implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private Integer qaId;//答案的ID
	private String prefix;
	private String answer;
	private Integer score;
	private Integer checked;
}
