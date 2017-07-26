/**
 * 
 */
package com.service;

import com.bo.FundRiskEvaluationBo;
import com.common.Pager;
import com.entity.FundRiskEvaluation;

/**
 * @author	tyb
 * @date	2016年9月3日上午10:17:51
 * @desc	
 */
public interface FundRiskEvaluationService extends BaseService<FundRiskEvaluation> {
	
	Pager<FundRiskEvaluation> getList(Pager<FundRiskEvaluation> pager,FundRiskEvaluationBo bo);
}
