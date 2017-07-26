/**
 * 
 */
package com.bo;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月17日下午4:17:48
 * @desc	
 */
@Getter
@Setter
public class QsaVo implements Serializable {

	private static final long serialVersionUID = -3356516802080636538L;
	
	private Long id;
	private String answer;
	private String prefix;
	private String text;
}
