/**
 * 
 */
package com.bo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import com.entity.ActivityFile;
import com.entity.ActivityFundManager;
import com.entity.ActivityGuest;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月13日下午9:55:56
 * @desc	
 */
@Getter
@Setter
public class ActivitySaveBo implements Serializable {
	
	private static final long serialVersionUID = -8564881813387643524L;
	private Long id;
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
	private List<ActivityFile> files = new ArrayList<>();
	private List<ActivityFundManager> managers = new ArrayList<>();
	private List<ActivityGuest> guests = new ArrayList<>();
	
	//往期活动元素
	private String agoTitle;
	private String agoDate;
	private String agoCover;
	private String agoContent;

}
