/**
 * 
 */
package com.entity;

/**
 * @author	tyb
 * @date	2016年8月24日上午10:25:36
 * @desc	
 */
public class UserSecondPics extends BaseEntity {
	private static final long serialVersionUID = 7378043568245575309L;
	private Long picId;
	private String picPath;
	
	public Long getPicId() {
		return picId;
	}
	public void setPicId(Long picId) {
		this.picId = picId;
	}
	public String getPicPath() {
		return picPath;
	}
	public void setPicPath(String picPath) {
		this.picPath = picPath;
	}
}
