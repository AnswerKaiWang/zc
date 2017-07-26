package com.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.ConstraintViolation;
import javax.validation.Validator;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bo.cura.RegBo;
import com.bo.cura.RespBean;
import com.common.Constant;
import com.common.Principal;
import com.entity.CompanyAttr;
import com.entity.User;
import com.service.UserService;
import com.util.DateEditor;
import com.util.IntCleanEditor;
import com.util.JsonUtils;
import com.util.LongCleanEditor;
import com.util.SpringUtils;

public abstract class WebBaseController {
	
	private Logger logger=LoggerFactory.getLogger(getClass());
	@Resource(name = "validator")
	private Validator validator;
	@Resource
	private UserService userService;
	
	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		 binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
	        binder.registerCustomEditor(long.class, new LongCleanEditor());
	        binder.registerCustomEditor(int.class, new IntCleanEditor());
	        binder.registerCustomEditor(Date.class, new DateEditor(true));
	}
	
	protected String message(String code, Object... args) {
		return SpringUtils.getMessage(code, args);
	}
	
	protected void addFlashMessage(RedirectAttributes redirectAttributes, String message) {
		if (redirectAttributes != null && message != null) {
			redirectAttributes.addFlashAttribute("falsh.sss", message);
		}
	}
	/**
	 * 根据Map输出JSON,返回null  
	 * @param response
	 * @param object 需要序列化的对象
	 * @param objectAndPropertys 为需要序列化的属性
	 * @return
	 */
	public String ajaxJson(Object object,Map<String, String[]> objectAndPropertys) {
		return JsonUtils.toJsonWithSerializePropertys(object, objectAndPropertys);
	}
	public String ajaxJson(Object object) {
		return JsonUtils.toJson(object);
	}
	
	public List<String> valid(Object target, Class<?>... groups) {
		Set<ConstraintViolation<Object>> constraintViolations = validator.validate(target, groups);
		if (constraintViolations.isEmpty()) {
			return null;
		} else {
			List<String> strings=new ArrayList<String>();
			for (ConstraintViolation<Object> constraintViolation : constraintViolations) {
				strings.add(constraintViolation.getMessage());
			}
			return strings;
		}
	}
	
	public Long currentCompany(HttpServletRequest httpServletRequest) {
		String url = httpServletRequest.getRequestURL().toString();
		logger.info("url:"+url);
		String uri = httpServletRequest.getRequestURI(); 
		logger.info("uri:"+uri);
		String domain =null;
		if(!"/".equals(uri)){
			domain = url.replace(uri,"");
		}else{
			domain=url;
		}
		logger.info("获取当前域名:"+domain);
		Set<String> set=Constant.COMPANY.keySet();
		logger.info("当前所有配置域名:"+set);
		for (String string : set) {
			if(StringUtils.containsIgnoreCase(string, domain)){
				CompanyAttr companyAttr=Constant.COMPANY.get(string);
				return companyAttr.getCompanyId();
			}
		}
		throw new NullPointerException("找不到公司");
	}
	
	public User currentUser(HttpServletRequest httpServletRequest) {
		Principal principal=(Principal)httpServletRequest.getSession().getAttribute(User.SESSION_USER);
		if(principal!=null){
			return userService.get(principal.getId());
		}
		return null;
	}
	public Principal currentPrincipal(HttpServletRequest httpServletRequest) {
		return (Principal)httpServletRequest.getSession().getAttribute(User.SESSION_USER);
	}
	
	
	protected RespBean success(){
		return new RespBean("00","success");
	}
	protected RespBean failure(String message){
		return new RespBean("01",message);
	}
	/**
	 * 前端登录用户的ID
	 * @param req
	 * @return
	 */
	protected Long getCurUser(HttpServletRequest req){
		RegBo bo=(RegBo)req.getSession().getAttribute(GlobalConstant.LOGIN_SUCCESS_KEY);
		if(bo!=null){
			return bo.getUserId();
		}
		return null;
	}
	
	
	@SuppressWarnings("unchecked")
	protected <T> T get(HttpServletRequest req, String key){
		return (T)req.getSession().getAttribute(key);
	}
}
