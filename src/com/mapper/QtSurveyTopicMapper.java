/**
 * 
 */
package com.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bo.QtSurveyBo;
import com.bo.QtSurveyTopicVo;
import com.common.Pager;
import com.entity.QtSurveyTopic;

import tk.mybatis.mapper.common.Mapper;

/**
 * @author	tyb
 * @date	2016年9月17日上午9:27:55
 * @desc	问卷调查-题目
 */
public interface QtSurveyTopicMapper extends Mapper<QtSurveyTopic> {
	
	List<QtSurveyTopic> getList(@Param("pager")Pager<QtSurveyTopic> pager, @Param("bo") QtSurveyBo bo);
	
	QtSurveyTopicVo findDetailById(@Param("id") Long id);
	
	void delByQstId(@Param("qstId") Long id);
}
