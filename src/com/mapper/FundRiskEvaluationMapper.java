/**
 * 
 */
package com.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bo.FundRiskEvaluationBo;
import com.common.Pager;
import com.entity.FundRiskEvaluation;

import tk.mybatis.mapper.common.Mapper;

/**
 * @author	tyb
 * @date	2016年9月3日上午10:14:50
 * @desc	
 */
public interface FundRiskEvaluationMapper extends Mapper<FundRiskEvaluation> {
	
	List<FundRiskEvaluation> getList(@Param("pager")Pager<FundRiskEvaluation> pager, @Param("bo") FundRiskEvaluationBo bo);
}
