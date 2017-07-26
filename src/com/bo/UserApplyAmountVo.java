/**
 * 
 */
package com.bo;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年8月27日上午10:35:50
 * @desc	
 */
@Getter
@Setter
public class UserApplyAmountVo implements Serializable {
	private static final long serialVersionUID = 1L;
	private Long total;
	private Long remain;
}
