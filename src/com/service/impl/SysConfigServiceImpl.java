/**
 * 
 */
package com.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bo.SysConfigBo;
import com.common.Pager;
import com.entity.SysConfig;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mapper.SysConfigMapper;
import com.service.SysConfigService;

import tk.mybatis.mapper.entity.Example;

/**
 * @author	tyb
 * @date	2016年9月6日下午12:08:32
 * @desc	
 */
@Service("sysConfigService")
public class SysConfigServiceImpl extends BaseServiceImpl<SysConfig> implements SysConfigService {
	
	@Autowired
	private SysConfigMapper sysConfigMapper;

	@Override
	public Pager<SysConfig> getList(Pager<SysConfig> pager, SysConfigBo bo) {
		if(pager.getUsePager()){
			PageHelper.offsetPage(pager.getOffset(), pager.getLimit());
		}
		List<SysConfig> members=sysConfigMapper.getList(pager,bo);
		pager.setRows(members);
		PageInfo<SysConfig> pageInfo=new PageInfo<SysConfig>(members);
		pager.setTotal(pageInfo.getTotal());
		return pager;
	}

	@Override
	public String getCtx(String key) {
		Example ex = new Example(SysConfig.class);
		ex.createCriteria().andEqualTo("sysKey", key);
		List<SysConfig> cfgs = sysConfigMapper.selectByExample(ex);
		if(cfgs != null && cfgs.size()>0){
			return cfgs.get(0).getSysValue();
		}
		return "/";
	}
}
