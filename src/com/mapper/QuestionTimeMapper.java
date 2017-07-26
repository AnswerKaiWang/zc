package com.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bo.QuestionTimeBo;
import com.common.Pager;
import com.entity.QuestionTime;

import tk.mybatis.mapper.common.Mapper;

public interface QuestionTimeMapper extends Mapper<QuestionTime>{
	List<QuestionTime> getList(@Param("pager")Pager<QuestionTime> pager, @Param("bo")QuestionTimeBo bo);
}