package com.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bo.QuestionBo;
import com.bo.QuestionEditVo;
import com.bo.RiskTitleVo;
import com.bo.SelectResultVo;
import com.common.Pager;
import com.entity.Question;

import tk.mybatis.mapper.common.Mapper;

public interface QuestionMapper extends Mapper<Question>{

	List<Question> getList(@Param("pager")Pager<Question> pager, @Param("bo")QuestionBo questionBo);
   
	
	QuestionEditVo findDetailById(@Param("id") Long id);
	
	
	List<SelectResultVo> searchQuestionList(@Param("keyword") String keyword);
	
	/**
	 * 通过question_time.id获得具体的测评题目
	 * @param qtId
	 * @return
	 */
	List<RiskTitleVo> findRiskTitleById(@Param("qtId") Long qtId);
	/**
	 * 
	 * @param quId
	 * @return
	 */
	List<RiskTitleVo> getQHis(@Param("quId") Long quId);
	
	Long getLastestId(@Param("type") String type);
}