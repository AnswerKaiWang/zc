/**
 * 
 */
package com.bo.cura;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年8月28日下午5:07:31
 * @desc	
 */
@Getter
@Setter
public class ProductBo  extends PageBo {

	private static final long serialVersionUID = 1L;
	private String productName;//产品名
	private String seriesName;//系列名
	private Integer fundType;
	private Integer deadline;
	private Long userSecondId;
}
