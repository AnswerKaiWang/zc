package com.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.common.Pager;
import com.entity.Company;

import tk.mybatis.mapper.common.Mapper;

public interface CompanyMapper extends Mapper<Company>{

	List<Company> getList(@Param("pager")Pager<Company> pager, @Param("bo")Company company);



}
