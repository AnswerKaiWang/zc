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
 * @date	2016年8月24日下午3:03:13
 * @desc	
 */
@Getter
@Setter
public class CustFileVo implements Serializable {
	private static final long serialVersionUID = 5581632461067654995L;
	private Long id;
	private Long custId;
	private String custName;
	private String custNo;
	private Long cardTypeId;
	private String cardTypeName;
	private String picName;
	private String validateTime;//证件有效期
	private String createTime;
	private List<CustFilePathVo> files = new ArrayList<>();
}
