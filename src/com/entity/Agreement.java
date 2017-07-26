/**
 * 
 */
package com.entity;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年8月29日上午11:28:23
 * @desc	合同
 */
@Getter
@Setter
public class Agreement extends BaseEntity{

	private static final long serialVersionUID = 1L;
	
	private Long fundId;
	private Long userSecondId;
	private String ano;
	private Integer astatus;
	private String remark;
	private String attach;//附件
}
