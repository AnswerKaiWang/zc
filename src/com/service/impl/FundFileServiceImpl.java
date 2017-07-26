package com.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bo.FundFileBo;
import com.bo.FundFileVo;
import com.common.Pager;
import com.entity.FundFile;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mapper.FundFileMapper;
import com.service.FundFileService;

@Service("fundFileServiceImpl")
public class FundFileServiceImpl extends BaseServiceImpl<FundFile> implements FundFileService{

	@Autowired
	private FundFileMapper fundFileMapper;

	@Override
	public Pager<FundFileVo> getList(Pager<FundFileVo> pager, FundFileBo fundFileBo) {
		if(pager.getUsePager()){
			PageHelper.offsetPage(pager.getOffset(), pager.getLimit());
		}
		List<FundFileVo> members=fundFileMapper.getList(pager,fundFileBo);
		pager.setRows(members);
		PageInfo<FundFileVo> pageInfo=new PageInfo<FundFileVo>(members);
		pager.setTotal(pageInfo.getTotal());
		return pager;
	}

	@Override
	public List<FundFile> getFrontList(Long id) {
		return fundFileMapper.getFrontList(id);
	}


	
	
}
