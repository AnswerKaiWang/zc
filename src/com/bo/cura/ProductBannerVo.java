/**
 * 
 */
package com.bo.cura;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月4日下午1:34:12
 * @desc	产品列表banner显示
 */
@Getter
@Setter
public class ProductBannerVo implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private Long id;
	private String seriesName;//系列名
	private String deadline;//产品期限
	private Integer fundStatus;
	private String statusName;
}
