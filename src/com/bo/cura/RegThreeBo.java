/**
 * 
 */
package com.bo.cura;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月1日下午1:13:16
 * @desc	
 */
@Getter
@Setter
public class RegThreeBo implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String name;
	private Integer age;
	private Integer gender;
	private Integer city;
	private String address;
	private String birth;
	private String email;
}
