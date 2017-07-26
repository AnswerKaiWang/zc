/**
 * 
 */
package com.bo.cura;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @param <T>
 * @date	2016年9月1日下午12:18:08
 * @desc	响应
 */
@Getter
@Setter
@AllArgsConstructor
public class RespBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String code;
	private String message;
	private Object data;
	
	public RespBean(String code,String message){
		this(code, message, null);
	}
}
