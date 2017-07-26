/**
 * 
 */
package com.bo.cura;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月8日下午7:26:57
 * @desc	
 */
@Getter
@Setter
public class InvestedVo implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private Long fundId;
	private String seriesName;
	private Long consultId;//专属顾问ID
	private String consultName;//专属顾问
	private String buyUserName;
	private String buyBankName;
	private String buyAccount;
}
