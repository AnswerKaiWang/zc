package com.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.common.Pager;
import com.entity.Help;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mapper.HelpMapper;
import com.service.HelpService;

@Service("helpServiceImpl")
public class HelpServiceImpl extends BaseServiceImpl<Help> implements HelpService{

	@Autowired
	private HelpMapper helpMapper;

	@Override
	public List<String> getTypeByGroup() {
		return helpMapper.getTypeByGroup();
	}
	@Override
	public Pager<Help> getList(Pager<Help> pager, Help help) {
		if(pager.getUsePager()){
			PageHelper.offsetPage(pager.getOffset(), pager.getLimit());
		}
		List<Help> members=helpMapper.getList(pager,help);
		pager.setRows(members);
		PageInfo<Help> pageInfo=new PageInfo<Help>(members);
		pager.setTotal(pageInfo.getTotal());
		return pager;
	}
	@Override
	public List<Help> getFrontList(String type,Long companyId) {
		return helpMapper.getFrontList(type,companyId);
	}

	
	
}
