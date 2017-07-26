/*
 * syb
 * syb
 * syb
 */
package com.template;

import java.io.IOException;
import java.io.Writer;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.common.Constant;
import com.entity.CompanyAttr;
import com.service.CompanyAttrService;
import com.util.CommonUtils;
import com.util.FreemarkerUtils;

import freemarker.core.Environment;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component("companyAttrDirective")
public class CompanyAttrDirective extends BaseDirective {

	private static final String VARIABLE_NAME = "companyAttr";

	
	@Resource
	private CompanyAttrService companyAttrService;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest(); 
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
		if(companyId==null) return;
			String name=FreemarkerUtils.getParameter("name", String.class, params);
			String type=FreemarkerUtils.getParameter("type", String.class, params);
			if(type==null){
				CompanyAttr companyAttrs=companyAttrService.getByName(companyId, name);
				if(body==null&&companyAttrs!=null){
					Writer out = env.getOut();
					out.write(StringUtils.trimToEmpty(companyAttrs.getContant()));
				}else{
					if(body!=null){
					setLocalVariable(VARIABLE_NAME, companyAttrs, env, body);
					}
				}
			}else if("like".equals(type)){
				List<CompanyAttr> companyAttrs=companyAttrService.getLikeName(companyId, name);
				if(body==null&&CommonUtils.isNotEmpty(companyAttrs)&&companyAttrs.get(0)!=null){
					Writer out = env.getOut();
					out.write(StringUtils.trimToEmpty(companyAttrs.get(0).getContant()));
				}else{
					if(body!=null){
						setLocalVariable(VARIABLE_NAME, companyAttrs, env, body);
					}
				}
			}else{
				List<CompanyAttr> companyAttrs=companyAttrService.getByNames(companyId, StringUtils.split(name,","));
				if(body==null&&CommonUtils.isNotEmpty(companyAttrs)&&companyAttrs.get(0)!=null){
					Writer out = env.getOut();
					out.write(StringUtils.trimToEmpty(companyAttrs.get(0).getContant()));
				}else{
					if(body!=null){
					setLocalVariable(VARIABLE_NAME, companyAttrs, env, body);
					}
				}
			}
	}

}