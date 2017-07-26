/**
 * 
 */
package com.mapper;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bo.QsVo;
import com.bo.QtSurveyBo;
import com.bo.SelectResultVo;
import com.common.Pager;
import com.entity.QtSurvey;

import tk.mybatis.mapper.common.Mapper;

/**
 * @author	tyb
 * @date	2016年9月17日上午9:27:55
 * @desc	问卷调查
 */
public interface QtSurveyMapper extends Mapper<QtSurvey> {
	
	List<QtSurvey> getList(@Param("pager")Pager<QtSurvey> pager, @Param("bo") QtSurveyBo bo);
	
	List<SelectResultVo> searchQsList(@Param("keyword") String keywod);
	
	Long getLastestQt();
	
	List<QsVo> getQsVo(@Param("qsId") Long id);
	/**
	 * 获取最新的结束日期
	 * @return
	 */
	Date getMaxEndTime(@Param("id") Long id);
}
