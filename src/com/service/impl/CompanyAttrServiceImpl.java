package com.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.common.Constant;
import com.entity.CompanyAttr;
import com.mapper.CompanyAttrMapper;
import com.service.CompanyAttrService;
import com.util.CommonUtils;

import tk.mybatis.mapper.entity.Example;

@Service("companyAttrServiceImpl")
public class CompanyAttrServiceImpl extends BaseServiceImpl<CompanyAttr> implements CompanyAttrService{

	@Autowired
	private CompanyAttrMapper companyAttrMapper;

	@Override
	public CompanyAttr getByName(Long companyId, String name) {
		return companyAttrMapper.getByName(companyId, name);
	}

	@Override
	public List<CompanyAttr> getByNames(Long companyId, String[] names) {
		return companyAttrMapper.getByNames(companyId, names);
	}

	
	public void getDomain(){
		Example example=new Example(CompanyAttr.class);
		example.createCriteria().andEqualTo("name", "domain");
		List<CompanyAttr> attrs=companyAttrMapper.selectByExample(example);
		Map<String, CompanyAttr> map=new HashMap<>();
		for (CompanyAttr companyAttr : attrs) {
			if(CommonUtils.isNotEmpty(companyAttr.getContant())){
				map.put(companyAttr.getContant(), companyAttr);
			}
		}
		Constant.COMPANY=map;
	}

	@Override
	public List<CompanyAttr> getLikeName(Long companyId, String name) {
		return companyAttrMapper.getLikeName(companyId, name);
	}
	


	
	
}
