/**
 * 
 */
package com.bo.cura;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月18日下午4:50:47
 * @desc	
 */
@Getter
@Setter
public class LectureVedioVo implements Serializable {

	private static final long serialVersionUID = 1L;
	private Long id;
	private String name;
	private String path;
	private Integer playNum;
	private Integer favorNum;
	private Integer shareNum;
	private String createTime;
}
