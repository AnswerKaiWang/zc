package com.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.bo.QstVo;
import com.bo.QuestionAddBo;
import com.bo.QuestionBo;
import com.bo.QuestionEditVo;
import com.bo.QuestionTimeBo;
import com.bo.RiskTitleVo;
import com.bo.SelectResultVo;
import com.bo.cura.LoginVo;
import com.bo.cura.RiskEvaluationBo;
import com.common.Pager;
import com.entity.Question;
import com.entity.QuestionTime;

public interface QuestionService extends BaseService<Question>{

	Pager<Question> getList(Pager<Question> pager, QuestionBo questionBo);
	
	
	void saveQuestion(QuestionAddBo bo);
	
	void updateQuestion(QuestionAddBo bo);
	
	QuestionEditVo findDetailById(Long id);
	
	Pager<QuestionTime> getTList(Pager<QuestionTime> pager,QuestionTimeBo bo);
	
	void addQuestionTime(QuestionTime qt);
	
	void editQuestionTime(QuestionTime qt);
	
	QuestionTime getQT(Long id);
	
	List<SelectResultVo> searchQuestionList(@Param("keyword") String keyword);
	/**
	 * 获得测评题目
	 * @param type
	 * @return
	 */
	List<RiskTitleVo> findRiskTitleById(String type);
	
	void addRiskEvaluation(RiskEvaluationBo bo, LoginVo vo,final Map<String,String> rt);
	
	List<QstVo> findQsts();
	
	List<RiskTitleVo> getQHis(Long quId);
}
