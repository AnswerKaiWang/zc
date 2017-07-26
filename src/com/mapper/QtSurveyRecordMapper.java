/**
 * 
 */
package com.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bo.QtSurveyBo;
import com.bo.QtSurveyRecordVo;
import com.common.Pager;
import com.entity.QtSurveyRecord;

import tk.mybatis.mapper.common.Mapper;

/**
 * @author	tyb
 * @date	2016年9月17日上午9:27:55
 * @desc	问卷调查-记录
 */
public interface QtSurveyRecordMapper extends Mapper<QtSurveyRecord> {
	
	List<QtSurveyRecordVo> getList(@Param("pager")Pager<QtSurveyRecordVo> pager, @Param("bo") QtSurveyBo bo);
}
