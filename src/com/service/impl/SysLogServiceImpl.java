package com.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.dom4j.Document;
import org.dom4j.io.SAXReader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;

import com.bo.SysLogBo;
import com.common.LogConfig;
import com.common.Pager;
import com.entity.SysLog;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mapper.SysLogMapper;
import com.service.SysLogService;

@Service("sysLogServiceImpl")
public class SysLogServiceImpl extends BaseServiceImpl<SysLog> implements SysLogService {
	
	@Autowired
	private SysLogMapper sysLogMapper;
	
	@SuppressWarnings("unchecked")
	@Cacheable("logConfig")
	public List<LogConfig> getAll() {
		try {
			File shopxxXmlFile = new ClassPathResource("/erp.xml").getFile();
			Document document = new SAXReader().read(shopxxXmlFile);
			List<org.dom4j.Element> elements = document.selectNodes("/erp/logConfig");
			List<LogConfig> logConfigs = new ArrayList<LogConfig>();
			for (org.dom4j.Element element : elements) {
				String operation = element.attributeValue("name");
				String urlPattern = element.attributeValue("urlPattern");
				LogConfig logConfig = new LogConfig();
				logConfig.setName(operation);
				logConfig.setUrlPattern(urlPattern);
				logConfigs.add(logConfig);
			}
			return logConfigs;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public Pager<SysLog> getList(Pager<SysLog> pager, SysLogBo sysLogBo) {
		if(pager.getUsePager()){
			PageHelper.offsetPage(pager.getOffset(), pager.getLimit());
		}
		List<SysLog> sysMemberVos=sysLogMapper.getList(sysLogBo,pager);
		pager.setRows(sysMemberVos);
		PageInfo<SysLog> pageInfo=new PageInfo<SysLog>(sysMemberVos);
		pager.setTotal(pageInfo.getTotal());
		return pager;
	}

}