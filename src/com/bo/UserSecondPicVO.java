/**
 * 
 */
package com.bo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年8月24日下午8:12:28
 * @desc	
 */
@Getter
@Setter
public class UserSecondPicVO implements Serializable {
	private static final long serialVersionUID = -1395349282674153254L;
	private Long id;
	private Long custId;//客户id
	private String custName;
	private Long cardTypeId;//证照类型
	private String picName;
	private String picYouxiaoqi;
	private Date picCreateTime;
	private String picPath;
	private String remark;
	private List<UserSecondPicPathVo> files = new ArrayList<>();
}
