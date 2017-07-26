/**
 * 
 */
package com.bo;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年8月24日下午7:00:16
 * @desc	
 */
@Getter
@Setter
public class SelectResultVo implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private Long id;
	private String name;
}
