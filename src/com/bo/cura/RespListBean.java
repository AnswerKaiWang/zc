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
 * @param <T>
 * @date	2016年9月4日上午9:31:08
 * @desc	
 */
@Getter
@Setter
@AllArgsConstructor
public class RespListBean implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer totalCounts;//总数
	private Integer totalPages;//总页数
	private Object data;//数据
}
