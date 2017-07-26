/**
 * 
 */
package com.bo.cura;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import com.entity.ActivityFile;
import com.entity.ActivityGuest;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月19日下午3:17:24
 * @desc	
 */
@Getter
@Setter
public class ActivityWebDetailVo implements Serializable {

	private static final long serialVersionUID = 1L;
	private Long id;
	//当前活动
	private String title;//标题
	private String subhead;//副标题
	private String  content;//内容
	private String lightspot;//亮点
	private String agenda;//议程
	
	private Integer actStatus;//活动状态
	private List<ActivityGuest> guests = new ArrayList<>();
	//历史活动
	private String liveReport;//现场报道
	private List<ActivityFile> liveFiles = new ArrayList<>();//现场集锦
	
	private List<ActivityFile> leftFiles = new ArrayList<>();//现场集锦-左边
	private List<ActivityFile> rightFiles = new ArrayList<>();//现场集锦-右边
	
	private List<ActivityFile> videos = new ArrayList<>();//视频
	private List<ActivityFile> files = new ArrayList<>();//文件分享
	
	//往期活动元素
	private String agoTitle;
	private String agoDate;
	private String agoCover;
	private String agoContent;
}
