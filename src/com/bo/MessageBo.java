/**
 * 
 */
package com.bo;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月11日上午7:59:57
 * @desc	
 */
@Getter
@Setter
public class MessageBo extends BaseBo {
	
	private String name;
	private Integer type;
	private Long memberId;
	private Integer userLevel;
	private String cardNo;
	private String phone;
	private  Long fundId;
}
