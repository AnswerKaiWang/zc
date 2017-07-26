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
 * @date	2016年9月17日下午4:15:54
 * @desc	问卷调查题目列表
 */
@Getter
@Setter
public class QstVo implements Serializable {

	private static final long serialVersionUID = 6778457566409068879L;
	private Long id;
	private String title;
	private Integer sort;
	private Integer type;
	private List<QsaVo> answers = new ArrayList<>();
}
