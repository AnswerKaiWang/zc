/**
 * 
 */
package com.entity;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月9日下午4:48:28
 * @desc	活动管理
 */
@Getter
@Setter
public class Activity extends BaseEntity {

	private static final long serialVersionUID = 1L;
	//当前活动元素
	private String title;//标题
	private String subhead;//副标题
	private String  content;//内容
	private String lightspot;//亮点
	private String agenda;//议程
	private String cover;//封面
	private String startTime;
	private String endTime;
	private String  lnt;//坐标
	private String lat;//坐标
	private Integer maxNum;//最大人数
	private Integer limitNum;//限制人数
	private Integer type;//活动类型
	private String liveReport;//现场报道
	private Integer actStatus;
	//往期活动元素
	private String agoTitle;
	private String agoDate;
	private String agoCover;
	private String agoContent;
	
}
