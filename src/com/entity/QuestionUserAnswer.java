/**
 * 
 */
package com.entity;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年8月27日下午9:39:15
 * @desc	
 */
@Getter
@Setter
public class QuestionUserAnswer implements Serializable {
	private static final long serialVersionUID = 1L;
	private Long quId;//questionUserId
	private Long questionId;
	private Long questionAnswerId;
}
