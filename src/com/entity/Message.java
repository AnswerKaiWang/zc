/**
 * 
 */
package com.entity;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月9日下午4:45:23
 * @desc	
 */
@Getter
@Setter
public class Message extends BaseEntity {

	private static final long serialVersionUID = 1L;
	
	private Long fromUid;//发送人
	private Long toUid;//接收人
	private String content;//内容
	private Integer readed;
}
