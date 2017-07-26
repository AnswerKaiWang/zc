/**
 * 
 */
package com.bo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.entity.ActivityFundManager;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月13日下午5:39:56
 * @desc	
 */
@Getter
@Setter
public class ActivityVo implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8397446588363762295L;
	
	private Long id;
	private String title;//标题
	private String subhead;//副标题
	private String  content;//内容
	private String cover;//封面
	private String startTime;
	private String endTime;
	private String  lnt;//坐标
	private String lat;//坐标
	private Integer maxNum;//最大人数
	private Integer limitNum;//限制人数
	private Integer type;//活动类型
	private String lightspot;//亮点
	private String agenda;//议程
	private String liveReport;//现场报道
	private Date createTime;
	private Integer actStatus;
	private List<ActivityFundManager> managers = new ArrayList<>();
	
	//往期活动元素
	private String agoTitle;
	private String agoDate;
	private String agoCover;
	private String agoContent;
}
