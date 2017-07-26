/**
 * 
 */
package com.bo.cura;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月8日下午7:29:41
 * @desc	
 */
@Getter
@Setter
public class ProfitVo implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Long fundId;
	private String fundName;
	private String buyUserName;
}
