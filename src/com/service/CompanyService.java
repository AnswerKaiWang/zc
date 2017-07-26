package com.service;

import java.util.Map;

import com.common.Pager;
import com.entity.Company;

public interface CompanyService extends BaseService<Company>{

	Pager<Company> getList(Pager<Company> pager, Company company);

	void save(Company company, Map<String, String> attr);

	void update(Company persistent, Map<String, String> attr);

	void update(Company persistent, String companySecurityCon1, String companySecurityCon2, String companySecurityCon3);

	Company getByCompanyNo(String companyNo);
}
