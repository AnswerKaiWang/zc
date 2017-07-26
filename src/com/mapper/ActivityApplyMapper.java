/**
 * 
 */
package com.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bo.ActivityApplyQueryBo;
import com.common.Pager;
import com.entity.ActivityApply;

import tk.mybatis.mapper.common.Mapper;

/**
 * @author	tyb
 * @date	2016年8月29日上午11:28:05
 * @desc	
 */
public interface ActivityApplyMapper extends Mapper<ActivityApply> {
	
	List<ActivityApply> getList(@Param("pager")Pager<ActivityApply> pager, @Param("bo") ActivityApplyQueryBo bo);
}
