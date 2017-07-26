/**
 * 
 */
package com.bo;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年8月29日下午8:01:56
 * @desc	
 */
@Getter
@Setter
public class AgreementBo extends BaseBo {
	private Long userSecondId;
	private String custNo;//客户证件号
	private String memberId;
	private String ano;
	private Long fundId;
}
