/**
 * 
 */
package com.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bo.ActivityBo;
import com.bo.ActivitySaveBo;
import com.bo.ActivityVo;
import com.bo.cura.ActivityWebDetailVo;
import com.common.Pager;
import com.entity.Activity;

import tk.mybatis.mapper.common.Mapper;

/**
 * @author	tyb
 * @date	2016年8月29日上午11:28:05
 * @desc	
 */
public interface ActivityMapper extends Mapper<Activity> {
	
	List<Activity> getList(@Param("pager")Pager<Activity> pager, @Param("bo") ActivityBo bo);
	
	void delManagersByActId(@Param("id") Long id);
	
	void delGuestByActId(@Param("id") Long id);
	
	void delFileByActId(@Param("id") Long id);
	
	ActivitySaveBo getActivitySaveBo(@Param("id") Long id);
	
	/**历史活动
	 * 
	 * @param keyword
	 * @param year
	 * @param start
	 * @param pageSize
	 * @param mf
	 * @return
	 */
	List<ActivityVo> curaList(@Param("keyword")String keyword,@Param("year")String year,
			@Param("start")Integer start,@Param("pageSize")Integer pageSize,@Param("mf") int mf);
	
	int curaCount(@Param("keyword")String keyword,@Param("year")String year,
			@Param("start")Integer start,@Param("pageSize")Integer pageSize,@Param("mf") int mf);
	/**
	 * 当前活动
	 * @return
	 */
	List<ActivityVo> curaNowList();
	
	ActivityWebDetailVo curaDetailById(@Param("id") Long id);
}
