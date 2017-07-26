/**
 * 
 */
package com.service;

import java.util.List;

import com.bo.ActivityApplyQueryBo;
import com.bo.ActivityBo;
import com.bo.ActivitySaveBo;
import com.bo.ActivityVo;
import com.bo.cura.ActivityWebDetailVo;
import com.common.Pager;
import com.entity.Activity;
import com.entity.ActivityApply;

/**
 * @author	tyb
 * @date	2016年8月29日下午3:01:23
 * @desc	
 */
public interface ActivityService extends BaseService<Activity>{
	
	Pager<Activity> getList(Pager<Activity> pager, ActivityBo bo);
	/**
	 * 新增活动
	 * @param bo
	 */
	void save(ActivitySaveBo bo);
	/**
	 * 更新活动
	 * @param bo
	 */
	void update(ActivitySaveBo bo);
	
	ActivitySaveBo getActivitySaveBo(Long id);
	
	
	List<ActivityVo> curaList(String keyword,String year,Integer start,Integer pageSize,int mf);
	
	int  curaCount(String keyword,String year,Integer start,Integer pageSize,int mf);
	
	List<ActivityVo> curaNowList();
	
	ActivityWebDetailVo curaDetailById(Long id);
	
	
	Pager<ActivityApply> getList(Pager<ActivityApply> pager, ActivityApplyQueryBo bo);
	
	void saveApply(ActivityApply entity);
}
