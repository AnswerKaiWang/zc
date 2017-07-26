/**
 * 
 */
package com.entity;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月18日上午8:48:57
 * @desc	
 */
@Getter
@Setter
public class LectureVedio extends BaseEntity {
	private static final long serialVersionUID = -3609464590397685291L;
	private Long lectureId;
	private String name;
	private String path;
	private Integer playNum;//播放次数
	private Integer favorNum;//喜爱次数，一个人只能喜欢一次
	private Integer shareNum;//分享次数
}
