package com.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bo.SysLogBo;
import com.common.Pager;
import com.entity.SysLog;

import tk.mybatis.mapper.common.Mapper;

public interface SysLogMapper extends Mapper<SysLog>{

	List<SysLog> getList(@Param("bo")SysLogBo sysLogBo, @Param("pager")Pager<SysLog> pager);
	
}