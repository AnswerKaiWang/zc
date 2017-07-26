/**
 * 
 */
package com.mapper;

import org.apache.ibatis.annotations.Param;

import com.entity.QuestionAnswer;

import tk.mybatis.mapper.common.BaseMapper;

/**
 * @author	tyb
 * @date	2016年8月26日下午9:01:52
 * @desc	
 */
public interface QuestionAnswerMapper extends BaseMapper<QuestionAnswer> {
	
	void delByQuestionId(@Param("id") Long id);
}
