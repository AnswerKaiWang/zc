/**
 * 
 */
package com.template;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.service.SysConfigService;

import freemarker.template.TemplateMethodModel;
import freemarker.template.TemplateModelException;

/**
 * @author	tyb
 * @date	2016年9月13日上午7:35:21
 * @desc	获取系统配置属性的方法
 */
@SuppressWarnings("deprecation")
@Component("sysConfigTag")
public final class SysConfigTag implements TemplateMethodModel {
	
	@Autowired
	private SysConfigService sysConfigService;

	@SuppressWarnings("rawtypes")
	@Override
	public Object exec(List arguments) throws TemplateModelException {
		if (arguments != null && !arguments.isEmpty() && arguments.get(0) != null && StringUtils.isNotEmpty(arguments.get(0).toString())) {
			String key = arguments.get(0).toString();
			return sysConfigService.getCtx(key);
		}
		return "/";
	}
}
