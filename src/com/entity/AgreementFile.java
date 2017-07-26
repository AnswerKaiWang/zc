/**
 * 
 */
package com.entity;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年8月29日上午11:29:09
 * @desc	
 */
@Getter
@Setter
public class AgreementFile extends BaseEntity {
	private static final long serialVersionUID = 1L;
	private Long aid;
	private String name;
	private String filePath;
}
