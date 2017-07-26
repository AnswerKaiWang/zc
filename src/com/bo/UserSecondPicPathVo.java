/**
 * 
 */
package com.bo;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年8月24日下午8:13:47
 * @desc	
 */
@Getter
@Setter
public class UserSecondPicPathVo implements Serializable {
	private static final long serialVersionUID = -4710796585771395841L;
	private Long id;
	private String picPath;
}
