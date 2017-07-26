/**
 * 
 */
package com.bo;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月12日上午10:51:46
 * @desc	
 */
@Getter
@Setter
public class MessageUserBo extends BaseBo {
	private String name;
	private Long userType;
	private Long memberId;
	private Long userLevel;
	private String cardNo;
	private String phone;
	private  Long fundId;
}
