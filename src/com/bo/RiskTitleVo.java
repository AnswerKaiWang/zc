/**
 * 
 */
package com.bo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月3日下午2:42:27
 * @desc	评测题目大类
 */
@Getter
@Setter
public class RiskTitleVo implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer type;
	private String title;
	private String index;
	private List<RiskSubjectVo> subjects = new ArrayList<>();
}
