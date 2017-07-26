package com.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.common.Pager;
import com.entity.Company;
import com.entity.CompanyAttr;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mapper.CompanyAttrMapper;
import com.mapper.CompanyMapper;
import com.service.CompanyService;
import com.util.CommonUtils;

import tk.mybatis.mapper.entity.Example;

@Service("companyServiceImpl")
public class CompanyServiceImpl extends BaseServiceImpl<Company> implements CompanyService{

	@Autowired
	private CompanyMapper companyMapper;
	@Autowired
	private CompanyAttrMapper companyAttrMapper;

	@Override
	public Pager<Company> getList(Pager<Company> pager, Company company) {
		if(pager.getUsePager()){
			PageHelper.offsetPage(pager.getOffset(), pager.getLimit());
		}
		List<Company> members=companyMapper.getList(pager,company);
		pager.setRows(members);
		PageInfo<Company> pageInfo=new PageInfo<Company>(members);
		pager.setTotal(pageInfo.getTotal());
		return pager;
	}

	@Override
	@Transactional
	public void save(Company company, Map<String, String> attr) {
		companyMapper.insert(company);
		if(attr!=null&&!attr.isEmpty()){
			Set<String> keys=attr.keySet();
			for (String string : keys) {
				CompanyAttr companyAttr=new CompanyAttr();
				companyAttr.setCreateTime(new Date());
				companyAttr.setUpdateTime(new Date());
				companyAttr.setCompanyId(company.getId());
				companyAttr.setName(StringUtils.trim(string));
				companyAttr.setContant(StringUtils.trim(attr.get(string)));
				companyAttrMapper.insert(companyAttr);
			}
		}
	}

	@Override
	@Transactional
	public void update(Company persistent, Map<String, String> attr) {
		companyMapper.updateByPrimaryKey(persistent);
		if(attr!=null&&!attr.isEmpty()){
			Set<String> keys=attr.keySet();
			for (String string : keys) {
				Example example=new Example(CompanyAttr.class);
				example.createCriteria().andEqualTo("companyId", persistent.getId()).andEqualTo("name",StringUtils.trim(string));
				companyAttrMapper.deleteByExample(example);
				CompanyAttr companyAttr=new CompanyAttr();
				companyAttr.setCreateTime(new Date());
				companyAttr.setUpdateTime(new Date());
				companyAttr.setCompanyId(persistent.getId());
				companyAttr.setName(StringUtils.trim(string));
				companyAttr.setContant(StringUtils.trim(attr.get(string)));
				companyAttrMapper.insert(companyAttr);
			}
		}
	}

	@Override
	@Transactional
	public void update(Company persistent, String companySecurityCon1, String companySecurityCon2,
			String companySecurityCon3) {
		for (int i = 1; i < 4; i++) {
			Example example=new Example(CompanyAttr.class);
			example.createCriteria().andEqualTo("companyId", persistent.getId()).andEqualTo("name", "companySecurityCon"+i);
			companyAttrMapper.deleteByExample(example);
			CompanyAttr companyAttr=new CompanyAttr();
			companyAttr.setCreateTime(new Date());
			companyAttr.setUpdateTime(new Date());
			companyAttr.setCompanyId(persistent.getId());
			companyAttr.setName("companySecurityCon"+i);
			if(i==1){
				companyAttr.setContant(companySecurityCon1);
			}
			if(i==2){
				companyAttr.setContant(companySecurityCon2);
			}
			if(i==3){
				companyAttr.setContant(companySecurityCon3);
			}
			companyAttrMapper.insert(companyAttr);
		}
		
	}

	@Override
	public Company getByCompanyNo(String companyNo) {
		if(CommonUtils.isEmpty(companyNo)){
			return null;
		}
		Example example=new Example(Company.class);
		example.createCriteria().andEqualTo("companyNo",companyNo);
		List<Company> companies=companyMapper.selectByExample(example);
		return CommonUtils.isEmpty(companies)?null:companies.get(0);
	}


	
	
}
