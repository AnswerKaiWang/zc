package com.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.entity.FundApply;
import com.mapper.FundApplyMapper;
import com.service.FundApplyService;

@Service("fundApplyServiceImpl")
public class FundApplyServiceImpl extends BaseServiceImpl<FundApply> implements FundApplyService{

	@Autowired
	private FundApplyMapper fundApplyMapper;

	

	
	
}
