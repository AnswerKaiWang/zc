package com.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.entity.CompanyAttr;

import tk.mybatis.mapper.common.Mapper;

public interface CompanyAttrMapper extends Mapper<CompanyAttr>{


	CompanyAttr getByName(@Param("companyId")Long companyId,@Param("name")String name);
	
	List<CompanyAttr> getByNames(@Param("companyId")Long companyId,@Param("names")String[] names);
	
	List<CompanyAttr> getLikeName(@Param("companyId")Long companyId,@Param("name")String name);

}
