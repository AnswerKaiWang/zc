/**
 * 
 */
package com.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bo.QuestionUserBo;
import com.bo.QuestionUserVo;
import com.bo.cura.RiskEvaluationResultVo;
import com.common.Pager;
import com.entity.QuestionUserRecord;

import tk.mybatis.mapper.common.Mapper;

/**
 * @author	tyb
 * @date	2016年8月27日下午9:54:57
 * @desc	
 */
public interface QuestionUserRecordMapper extends Mapper<QuestionUserRecord> {
	
	List<QuestionUserVo> getList(@Param("pager") Pager<QuestionUserVo> pager, @Param("bo") QuestionUserBo bo);
	
	
	Integer getEvaluationScore(@Param("quId") Long quId);
	
	RiskEvaluationResultVo getEvaluationResult(@Param("score") Integer score);
}
