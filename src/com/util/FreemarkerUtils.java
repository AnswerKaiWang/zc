/*
 * syb
 * syb
 * syb
 */
package com.util;

import java.io.IOException;
import java.io.StringReader;
import java.io.StringWriter;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.commons.beanutils.ConvertUtils;

import freemarker.core.Environment;
import freemarker.template.Configuration;
import freemarker.template.ObjectWrapper;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;
import freemarker.template.TemplateModelException;
import freemarker.template.utility.DeepUnwrap;

public final class FreemarkerUtils {

	private static  Configuration config = new Configuration();

	private FreemarkerUtils() {
	}
	@SuppressWarnings("unchecked")
	public static <T> T getParameter(String name, Class<T> type, Map<String, TemplateModel> params) throws TemplateModelException {
		TemplateModel templateModel = params.get(name);
		if (templateModel == null) {
			return null;
		}
		Object value = DeepUnwrap.unwrap(templateModel);
		return (T) ConvertUtils.convert(value, type);
	}

	public static String process(String template, Map<String, ?> model) throws IOException, TemplateException {
		if (template == null) {
			return null;
		}
		config.setTagSyntax(0);
		StringWriter out = new StringWriter();
		new Template("template", new StringReader(template), config).process(model, out);
		return out.toString();
	}
	public static TemplateModel getVariable(String name, Environment env) throws TemplateModelException {
		return env.getVariable(name);
	}

	public static void setVariable(String name, Object value, Environment env) throws TemplateException {
		if (value instanceof TemplateModel) {
			env.setVariable(name, (TemplateModel) value);
		} else {
			env.setVariable(name, ObjectWrapper.BEANS_WRAPPER.wrap(value));
		}
	}

	public static void setVariables(Map<String, Object> variables, Environment env) throws TemplateException {
		for (Entry<String, Object> entry : variables.entrySet()) {
			String name = entry.getKey();
			Object value = entry.getValue();
			if (value instanceof TemplateModel) {
				env.setVariable(name, (TemplateModel) value);
			} else {
				env.setVariable(name, ObjectWrapper.BEANS_WRAPPER.wrap(value));
			}
		}
	}

}