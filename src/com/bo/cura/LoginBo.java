/**
 * 
 */
package com.bo.cura;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月1日下午4:33:08
 * @desc	
 */
@Getter
@Setter
public class LoginBo implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String userName;
	private String password;
	private String type;
}
