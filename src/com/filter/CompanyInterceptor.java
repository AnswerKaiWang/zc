package com.filter;

import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.common.Constant;
import com.entity.CompanyAttr;


public class CompanyInterceptor extends HandlerInterceptorAdapter {

	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		String url = request.getRequestURL().toString();
		String uri = request.getRequestURI(); 
		String domain =null;
		if(!"/".equals(uri)){
			domain = url.replace(uri,"");
		}else{
			domain=url;
		}
		Set<String> set=Constant.COMPANY.keySet();
		Long companyId=null;
		for (String string : set) {
			if(StringUtils.containsIgnoreCase(string, domain)){
				CompanyAttr companyAttr=Constant.COMPANY.get(string);
				companyId=companyAttr.getCompanyId();
			}
		}
		if(companyId==null){
			response.sendRedirect(request.getContextPath() + "/common/error.htm");
			return false;
		}
		return true;
	}

}