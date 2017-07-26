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
 * @date	2016年9月17日下午5:03:02
 * @desc	
 */
@Getter
@Setter
public class QsVo implements Serializable {

	private static final long serialVersionUID = 6201444862792828231L;
	
	private String index;
	private String qsType;
	private String qsTypeName;
	private Long qsId;//问卷调查Id
	private List<QstVo> topics = new ArrayList<>();
}
