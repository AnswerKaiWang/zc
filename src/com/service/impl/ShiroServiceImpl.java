package com.service.impl;

import java.text.MessageFormat;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.config.Ini;
import org.apache.shiro.config.Ini.Section;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.util.CollectionUtils;
import org.apache.shiro.web.filter.mgt.DefaultFilterChainManager;
import org.apache.shiro.web.filter.mgt.PathMatchingFilterChainResolver;
import org.apache.shiro.web.servlet.AbstractShiroFilter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.entity.Permission;
import com.mapper.PermissionMapper;
import com.service.ShiroService;


public class ShiroServiceImpl implements ShiroService{
	private Logger logger=LoggerFactory.getLogger(ShiroServiceImpl.class);

	public static final String PREMISSION_STRING="perms[\"{0}\"]";
	
	private String filterChainDefinitions="";
	@Autowired
	private ShiroFilterFactoryBean shiroFilterFactoryBean;
	@Autowired
	private PermissionMapper permissionMapper;
	
	@Override
	public void shiroUpdate() {
		synchronized (shiroFilterFactoryBean) {
			 AbstractShiroFilter shiroFilter = null;  
			  
	            try {  
	                shiroFilter = (AbstractShiroFilter) shiroFilterFactoryBean.getObject();  
	            } catch (Exception e) {  
	            	logger.error(e.getMessage());  
	            }  
	  
	            // 获取过滤管理器  
	            PathMatchingFilterChainResolver filterChainResolver = (PathMatchingFilterChainResolver) shiroFilter  
	                    .getFilterChainResolver();  
	            DefaultFilterChainManager manager = (DefaultFilterChainManager) filterChainResolver.getFilterChainManager();  
	  
	            // 清空初始权限配置  
	            manager.getFilterChains().clear();  
	            shiroFilterFactoryBean.getFilterChainDefinitionMap().clear();
	            shiroFilterFactoryBean.getFilterChainDefinitionMap().putAll(obtainPermission());
	            Map<String, String> chains = shiroFilterFactoryBean.getFilterChainDefinitionMap();  
	            
	            for (Map.Entry<String, String> entry : chains.entrySet()) {  
	                String url = entry.getKey();  
	                String chainDefinition = entry.getValue().trim().replace(" ", "");
	                if(!StringUtils.startsWith(url, "/")){
	        			 url="/"+url;
	        		 }
	                manager.createChain(url, chainDefinition);  
	            } 
        }  
	}
	
	private Section obtainPermission() {
		List<Permission> permissions=permissionMapper.selectAll();
        Ini ini = new Ini();  
        ini.load(filterChainDefinitions); // 加载资源文件节点串  
        Section section = ini.getSection("urls"); // 使用默认节点  
        if (CollectionUtils.isEmpty(section)) {  
            section = ini.getSection(Ini.DEFAULT_SECTION_NAME); // 如不存在默认节点切割,则使用空字符转换  
        }  
        for (Permission permission : permissions) {
        	 if(StringUtils.isNotEmpty(permission.getValue()) && StringUtils.isNotEmpty(permission.getValue())) {
                  section.put(permission.getValue(),  MessageFormat.format(PREMISSION_STRING,permission.getValue()));  
             }  
		}
        section.put("/admin/**", "authc");
        return section;  
    }

	public String getFilterChainDefinitions() {
		return filterChainDefinitions;
	}

	public void setFilterChainDefinitions(String filterChainDefinitions) {
		this.filterChainDefinitions = filterChainDefinitions;
	}

	
	
}
