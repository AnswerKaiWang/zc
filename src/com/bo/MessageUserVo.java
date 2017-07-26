/**
 * 
 */
package com.bo;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月12日上午10:46:28
 * @desc	
 */
@Getter
@Setter
public class MessageUserVo implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private Long id;
	private String name;
	private String userType;
	private Long memberId;
	private String memberName;
	private Long userLevelId;
	private String userLevel;
	private Long cardType;
	private String cardTypeStr;
	private String cardNo;
	private String phone;
	
}
