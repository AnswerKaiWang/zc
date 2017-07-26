/**
 * 
 */
package com.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bo.SysConfigBo;
import com.common.Pager;
import com.entity.SysConfig;

import tk.mybatis.mapper.common.Mapper;

/**
 * @author	tyb
 * @date	2016年9月6日上午11:33:45
 * @desc	系统常用配置属性
 */
public interface SysConfigMapper extends Mapper<SysConfig> {
	
	List<SysConfig> getList(@Param("pager")Pager<SysConfig> pager, @Param("bo") SysConfigBo bo);
}
