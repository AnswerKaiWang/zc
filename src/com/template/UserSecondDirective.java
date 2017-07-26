package com.template;

import java.io.IOException;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.bo.cura.LoginVo;
import com.controller.GlobalConstant;
import com.entity.UserSecond;
import com.service.UserSecondService;

import freemarker.core.Environment;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component("currentSecondUserDirective")
public class UserSecondDirective extends BaseDirective{

	private static final String VARIABLE_NAME = "user";

	@Resource
	private UserSecondService userSecondService;
	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest(); 
		LoginVo vo = (LoginVo) request.getSession().getAttribute(GlobalConstant.LOGIN_SUCCESS_KEY);
		if(vo != null){
			UserSecond userSecond=userSecondService.get(vo.getUserSecondId());
			setLocalVariable(VARIABLE_NAME, userSecond, env, body);
		}
	}
}
