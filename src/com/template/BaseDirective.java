/*
 * syb
 * syb
 * syb
 */
package com.template;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import com.util.FreemarkerUtils;

import freemarker.core.Environment;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

public abstract class BaseDirective implements TemplateDirectiveModel {



	
	protected void setLocalVariable(String name, Object value, Environment env, TemplateDirectiveBody body) throws TemplateException, IOException {
		TemplateModel sourceVariable = FreemarkerUtils.getVariable(name, env);
		FreemarkerUtils.setVariable(name, value, env);
		body.render(env.getOut());
		FreemarkerUtils.setVariable(name, sourceVariable, env);
	}

	protected void setLocalVariables(Map<String, Object> variables, Environment env, TemplateDirectiveBody body) throws TemplateException, IOException {
		Map<String, Object> sourceVariables = new HashMap<String, Object>();
		for (String name : variables.keySet()) {
			TemplateModel sourceVariable = FreemarkerUtils.getVariable(name, env);
			sourceVariables.put(name, sourceVariable);
		}
		FreemarkerUtils.setVariables(variables, env);
		body.render(env.getOut());
		FreemarkerUtils.setVariables(sourceVariables, env);
	}

}