package com.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bo.FundAccountBo;
import com.bo.FundAccountVo;
import com.common.Pager;
import com.entity.FundAccount;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mapper.FundAccountMapper;
import com.service.FundAccountService;

@Service("fundAccountServiceImpl")
public class FundAccountServiceImpl extends BaseServiceImpl<FundAccount> implements FundAccountService{

	@Autowired
	private FundAccountMapper fundAccountMapper;

	@Override
	public Pager<FundAccountVo> getList(Pager<FundAccountVo> pager, FundAccountBo fundAccountBo) {
		if(pager.getUsePager()){
			PageHelper.offsetPage(pager.getOffset(), pager.getLimit());
		}
		List<FundAccountVo> members=fundAccountMapper.getList(pager,fundAccountBo);
		pager.setRows(members);
		PageInfo<FundAccountVo> pageInfo=new PageInfo<FundAccountVo>(members);
		pager.setTotal(pageInfo.getTotal());
		return pager;
	}

	@Override
	@Transactional
	public void saveList(List<FundAccount> funds) {
		for (FundAccount fundAccount : funds) {
			fundAccountMapper.insert(fundAccount);
		}
	}

	@Override
	public List<FundAccount> getFrontList(Long id) {
		return fundAccountMapper.getFrontList(id);
	}

	
	
}
