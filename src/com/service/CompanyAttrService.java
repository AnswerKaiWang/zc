package com.service;

import java.util.List;

import com.entity.CompanyAttr;

public interface CompanyAttrService extends BaseService<CompanyAttr>{
	
	CompanyAttr getByName(Long companyId,String name);
	
	List<CompanyAttr> getByNames(Long companyId,String[] names);
	
	List<CompanyAttr> getLikeName(Long companyId,String name);
	
	void getDomain();
}
