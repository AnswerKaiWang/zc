/**
 * 
 */
package com.bo.cura;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月18日下午4:49:09
 * @desc	
 */
@Getter
@Setter
public class LectureWebDetailVo implements Serializable {
	
	private static final long serialVersionUID = 7876205453982852564L;
	private Long id;
	private String title;
	private String cover;
	private String brief;
	private String lastestTime;
	private List<LectureVedioVo> vedios = new ArrayList<>();
}
