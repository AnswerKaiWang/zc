/**
 * 
 */
package com.bo.cura;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月3日下午4:31:32
 * @desc	
 */
@Getter
@Setter
public class CuraFundFileVo implements Serializable {

	private static final long serialVersionUID = 1L;
	private String path;
	private String suffix;
	private String name;
}
