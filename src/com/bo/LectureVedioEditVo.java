/**
 * 
 */
package com.bo;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月19日上午10:22:11
 * @desc	
 */
@Getter
@Setter
public class LectureVedioEditVo implements Serializable {

	private static final long serialVersionUID = -4811936903828154233L;
	
	private Long id;
	private String name;
	private String path;
}
