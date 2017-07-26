/**
 * 
 */
package com.bo.cura;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月18日下午3:52:39
 * @desc	
 */
@Getter
@Setter
public class LectureWebVo implements Serializable {

	private static final long serialVersionUID = 6359561569003927681L;
	
	private Long id;
	private String title;
	private String cover;
	private String brief;
	
	//文件个数
	private String fileNum;
}
