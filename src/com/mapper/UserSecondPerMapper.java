package com.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bo.CustFileBo;
import com.bo.CustFileVo;
import com.common.Pager;
import com.entity.UserSecondPer;

import tk.mybatis.mapper.common.Mapper;

public interface UserSecondPerMapper extends Mapper<UserSecondPer>{
	List<CustFileVo> getList(@Param("pager")Pager<CustFileVo> pager, @Param("bo")CustFileBo bo);
}
