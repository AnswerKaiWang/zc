/**
 * 
 */
package com.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bo.FundRiskBearBo;
import com.common.Pager;
import com.entity.FundRiskBear;
import com.entity.FundRiskEvaluation;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mapper.FundRiskBearMapper;
import com.mapper.FundRiskEvaluationMapper;
import com.service.FundRiskBearService;

/**
 * @author	tyb
 * @date	2016年9月3日上午10:18:27
 * @desc	
 */
@Service("fundRiskBearService")
public class FundRiskBearServiceImpl extends BaseServiceImpl<FundRiskBear> implements FundRiskBearService {
	
	@Autowired
	private FundRiskBearMapper fundRiskBearMapper;
	@Autowired
	private FundRiskEvaluationMapper fundRiskEvaluationMapper;

	@Override
	public Pager<FundRiskBear> getList(Pager<FundRiskBear> pager, FundRiskBearBo bo) {
		if(pager.getUsePager()){
			PageHelper.offsetPage(pager.getOffset(), pager.getLimit());
		}
		List<FundRiskBear> members=fundRiskBearMapper.getList(pager,bo);
		if(members !=null){
			for(FundRiskBear bear: members){
				FundRiskEvaluation old = fundRiskEvaluationMapper.selectByPrimaryKey(bear.getRiskId());
				if(old !=null)
				bear.setRiskLevel(old.getRiskNature());
			}
		}
		pager.setRows(members);
		PageInfo<FundRiskBear> pageInfo=new PageInfo<FundRiskBear>(members);
		pager.setTotal(pageInfo.getTotal());
		return pager;
	}
	
	
}
