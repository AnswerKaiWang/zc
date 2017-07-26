/**
 * 
 */
package com.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月18日上午8:52:23
 * @desc	
 */
@Getter
@Setter
public class LectureFavor implements Serializable {
	
	private static final long serialVersionUID = 4849299903121202534L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	private Long lectureId;
	private Long userSecondId;
	private Date createTime;
}
