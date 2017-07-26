/**
 * 
 */
package com.bo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月19日上午10:21:15
 * @desc	
 */
@Getter
@Setter
public class LectureEditVo implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Long id;
	private String title;
	private String cover;
	private String brief;
	private String lastestTime;
	private List<LectureVedioEditVo> vedios = new ArrayList<>();
}
