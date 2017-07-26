/**
 * 
 */
package com.bo.cura;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月6日下午9:24:42
 * @desc	
 */
@Getter
@Setter
public class AppointmentQueryVo implements Serializable {
	private static final long serialVersionUID = 1L;
	private Long fundId;
	private String seriesName;
	private String fundName;
	private Long userSecondId;
	private String consultName;
	private String custName;
	private Long companyId;
	private String companyName;
}
