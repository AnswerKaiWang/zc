/**
 * 
 */
package com.bo.cura;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年8月28日下午4:04:38
 * @desc	基金产品列表
 */
@Getter
@Setter
public class ProductVo implements Serializable {
	
	private static final long serialVersionUID = -7101388501459542240L;
	private Long fundId;
	private String title;//标题
	private String deadline;//期限
	private Integer fundStatus;//状态
	private String statusName;//
	private String fundNature;//特点
	private Integer riskLevel;
	private Integer disabled;
	private Integer buyed;//是否购买；大于0位购买了
	private String cover;
}
