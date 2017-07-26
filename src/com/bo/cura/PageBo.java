/**
 * 
 */
package com.bo.cura;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月18日下午3:45:11
 * @desc	
 */
@Getter
@Setter
public class PageBo implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer start;//当前页
	private Integer pageSize;//分页大小
	
}
