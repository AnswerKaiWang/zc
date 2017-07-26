package com.service;

import java.util.List;

import com.common.Pager;
import com.entity.Help;

public interface HelpService extends BaseService<Help>{

	Pager<Help> getList(Pager<Help> pager, Help help);

	List<String> getTypeByGroup();

	List<Help> getFrontList(String type, Long companyId);
}
