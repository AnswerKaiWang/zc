/**
 * 
 */
package com.bo;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月17日上午9:51:26
 * @desc	
 */
@Getter
@Setter
public class QtSurveyBo implements Serializable {

	private static final long serialVersionUID = 1L;
	private Long qsId;
	private String name;
}
