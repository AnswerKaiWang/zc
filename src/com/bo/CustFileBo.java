/**
 * 
 */
package com.bo;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年8月24日下午3:09:17
 * @desc	
 */
@Getter
@Setter
public class CustFileBo extends BaseBo {
	private Long userSecondId;
	private String cardNo;
	private Long cardType;
	private String fileName;
}
