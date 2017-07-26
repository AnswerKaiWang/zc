package com.service;

import java.util.List;

import com.bo.SysLogBo;
import com.common.LogConfig;
import com.common.Pager;
import com.entity.SysLog;

public interface SysLogService extends BaseService<SysLog>{

	List<LogConfig> getAll();

	Pager<SysLog> getList(Pager<SysLog> pager, SysLogBo sysLogBo);

}