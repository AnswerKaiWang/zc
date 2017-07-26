/**
 * 
 */
package com.service;

import com.bo.SysConfigBo;
import com.common.Pager;
import com.entity.SysConfig;

/**
 * @author	tyb
 * @date	2016年9月6日上午11:34:24
 * @desc	
 */
public interface SysConfigService extends BaseService<SysConfig> {
	Pager<SysConfig> getList(Pager<SysConfig> pager, SysConfigBo bo);
	
	String getCtx(String key);
}
