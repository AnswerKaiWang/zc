/**
 * 
 */
package com.bo;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月26日下午3:37:12
 * @desc	到期提醒
 */
@Getter
@Setter
public class ExpireVo implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String name;//证件类型什么滴
	private String owner;//拥有者
	private String expDate;//到期日期
	
}
