package com.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.common.Pager;
import com.entity.Dictionary;

import tk.mybatis.mapper.common.Mapper;

public interface DictionaryMapper extends Mapper<Dictionary>{

	List<Dictionary> getList(@Param("pager")Pager<Dictionary> pager, @Param("bo")Dictionary dictionary);
	
	Long getIdByTypeAndName(@Param("type") String type, @Param("name") String name);
	
}
