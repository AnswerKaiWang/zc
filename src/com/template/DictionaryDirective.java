/*
 * syb
 * syb
 * syb
 */
package com.template;

import java.io.IOException;
import java.util.Map;

import org.springframework.stereotype.Component;

import com.common.Constant;
import com.enums.DictionaryType;
import com.util.FreemarkerUtils;

import freemarker.core.Environment;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component("dictionaryDirective")
public class DictionaryDirective extends BaseDirective {

	private static final String VARIABLE_NAME = "dictList";
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		String name=FreemarkerUtils.getParameter("name", String.class, params);
		setLocalVariable(VARIABLE_NAME, Constant.DICTIONARY_TYPE_MAP.get(DictionaryType.valueOf(name)), env, body);
	}

}