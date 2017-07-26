package com.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.common.Pager;
import com.entity.Help;

import tk.mybatis.mapper.common.Mapper;

public interface HelpMapper extends Mapper<Help>{
	
	List<Help> getList(@Param("pager")Pager<Help> pager, @Param("bo")Help help);
	
	List<String> getTypeByGroup();

	List<Help> getFrontList(@Param("type")String type,@Param("companyId")Long companyId);
}
