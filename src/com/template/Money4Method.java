package com.template;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;

import com.util.CommonUtils;

import freemarker.template.SimpleScalar;
import freemarker.template.TemplateMethodModel;
import freemarker.template.TemplateModelException;

@SuppressWarnings("deprecation")
@Component("money4Method")
public class Money4Method implements TemplateMethodModel {

	@SuppressWarnings("rawtypes")
	public Object exec(List arguments) throws TemplateModelException {
		if (arguments != null && !arguments.isEmpty() && arguments.get(0) != null && StringUtils.isNotEmpty(arguments.get(0).toString())) {
			String code = arguments.get(0).toString();
			return new SimpleScalar(CommonUtils.money4(Long.parseLong(code)));
		}
		return null;
	}

}