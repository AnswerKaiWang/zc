/**
 * 
 */
package com.bo.cura;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月6日下午9:21:35
 * @desc	预约查询
 */
@Getter
@Setter
public class AppointmentQueryBo implements Serializable {
	private static final long serialVersionUID = 1L;
	private Integer pageSize;//每页大小
	private Integer start;//开始页
	private Long type;
	private Long lawWay;
	private Long duration;
	private Long userSecondId;
	private String cardNo;
	private Long fundId;
}
