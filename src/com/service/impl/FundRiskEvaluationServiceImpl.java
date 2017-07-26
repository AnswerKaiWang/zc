/**
 * 
 */
package com.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bo.FundRiskEvaluationBo;
import com.common.Pager;
import com.entity.FundRiskEvaluation;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mapper.FundRiskEvaluationMapper;
import com.service.FundRiskEvaluationService;

/**
 * @author	tyb
 * @date	2016年9月3日上午10:20:19
 * @desc	
 */
@Service("fundRiskEvaluationService")
public class FundRiskEvaluationServiceImpl extends BaseServiceImpl<FundRiskEvaluation> implements FundRiskEvaluationService {

	@Autowired
	private FundRiskEvaluationMapper fundRiskEvaluationMapper;

	@Override
	public Pager<FundRiskEvaluation> getList(Pager<FundRiskEvaluation> pager, FundRiskEvaluationBo bo) {
		if(pager.getUsePager()){
			PageHelper.offsetPage(pager.getOffset(), pager.getLimit());
		}
		List<FundRiskEvaluation> members=fundRiskEvaluationMapper.getList(pager,bo);
		pager.setRows(members);
		PageInfo<FundRiskEvaluation> pageInfo=new PageInfo<FundRiskEvaluation>(members);
		pager.setTotal(pageInfo.getTotal());
		return pager;
	}
	
	
}
