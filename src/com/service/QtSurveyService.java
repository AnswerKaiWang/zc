/**
 * 
 */
package com.service;

import java.util.List;

import org.springframework.ui.ModelMap;

import com.bo.QsVo;
import com.bo.QtSurveyBo;
import com.bo.QtSurveyRecordVo;
import com.bo.QtSurveyTopicSaveBo;
import com.bo.QtSurveyTopicVo;
import com.bo.SelectResultVo;
import com.bo.cura.SurveyBo;
import com.common.Pager;
import com.entity.QtSurvey;
import com.entity.QtSurveyTopic;

/**
 * @author	tyb
 * @date	2016年9月17日上午9:48:42
 * @desc	
 */
public interface QtSurveyService extends BaseService<QtSurvey> {
	/**
	 * 问卷调查-名目列表
	 * @param pager
	 * @param bo
	 * @return
	 */
	Pager<QtSurvey> getList(Pager<QtSurvey> pager, QtSurveyBo bo);
	
	/**
	 * 问卷调查-题目列表
	 * @param pager
	 * @param bo
	 * @return
	 */
	Pager<QtSurveyTopic> getTopicList(Pager<QtSurveyTopic> pager, QtSurveyBo bo);
	/**
	 * 判断是否重复
	 * @param entity
	 * @return
	 */
	boolean repeated(QtSurvey entity);
	
	/**
	 * 问卷调查-添加题目
	 * @param bo
	 */
	void addTopic(QtSurveyTopicSaveBo bo);
	/**
	 * 问卷调查-题目详情
	 * @param id
	 * @return
	 */
	QtSurveyTopicVo findDetaiById(Long id);
	/**
	 * 问卷调查-编辑题目
	 * @param bo
	 */
	void editTopic(QtSurveyTopicSaveBo bo);
	
	/**
	 * 问卷调查-记录查询
	 * @param pager
	 * @param bo
	 * @return
	 */
	Pager<QtSurveyRecordVo> getQtRecordList(Pager<QtSurveyRecordVo> pager, QtSurveyBo bo);
	
	
	List<SelectResultVo> searchQsList(String keyword);
	/**
	 * 问卷调查-最新的题目
	 * @return
	 */
	List<QsVo> findLastestQsVo(ModelMap model);
	/**
	 * 问卷调查，查看
	 * @param bo
	 */
	void addQsRecord(SurveyBo bo, Long userSecondId);
}
