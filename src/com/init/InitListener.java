/*
 * syb
 * syb
 * syb
 */
package com.init;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Component;
import org.springframework.web.context.ServletContextAware;

import com.common.Constant;
import com.entity.Permission;
import com.service.CompanyAttrService;
import com.service.DictionaryService;
import com.service.PermissionService;
import com.service.ShiroService;
import com.util.CommonUtils;

@Component("initListener")
public class InitListener implements ServletContextAware, ApplicationListener<ContextRefreshedEvent> {


	private static final Logger logger = LoggerFactory.getLogger(InitListener.class);

	private ServletContext servletContext;
	@Autowired
	private PermissionService permissionService;
	@Resource(name = "shiroServiceImpl")
	private ShiroService shiroService;
	@Resource
	private CompanyAttrService companyAttrService;
	@Resource
	private DictionaryService dictionaryService;
	
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
	}

	@Override
	public void onApplicationEvent(ContextRefreshedEvent contextRefreshedEvent) {
		if (servletContext != null && contextRefreshedEvent.getApplicationContext().getParent() == null) {
			initNav();//左边树
			shiroService.shiroUpdate();
			companyAttrService.getDomain();
			dictionaryService.initDictionary();
		}
		
	}


	private void initNav() {
		logger.info("----加载基础左边树开始----" );
		List<Permission> list=permissionService.getNav();
		if(CommonUtils.isNotEmpty(list)) Constant.BASIC_NAV_LIST=list;
		logger.info("----加载基础左边树结束----" );
	}
	
}