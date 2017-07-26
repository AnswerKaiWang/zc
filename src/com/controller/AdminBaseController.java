package com.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.ConstraintViolation;
import javax.validation.Validator;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.core.io.ClassPathResource;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.entity.Member;
import com.entity.SysLog;
import com.service.MemberService;
import com.util.CommonUtils;
import com.util.DateEditor;
import com.util.IntCleanEditor;
import com.util.JsonUtils;
import com.util.LongCleanEditor;
import com.util.SpringUtils;

public abstract class AdminBaseController {
	
	@Resource(name = "validator")
	private Validator validator;
	@Resource
	private MemberService memberService;
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
	public Long currentCompany(){
		Long s=memberService.getPrincipal().getCompanyId();
		return s==null?0:s;
	}
	public boolean isPermission(String s){
		Subject subject = SecurityUtils.getSubject();
		return subject.isPermitted(s);
	}
	
	 @SuppressWarnings("unchecked")
	public void addLog(String name,String contant){
		 HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		 Object o=request.getAttribute(SysLog.SYS_LOGS);
		 List<SysLog> sysLogs=null;
		 if(o==null){
			 sysLogs=new ArrayList<>();
		 }else{
			 sysLogs=(List<SysLog>)o;
		 }
		 sysLogs.add(new SysLog(name, contant));
		 request.setAttribute(SysLog.SYS_LOGS, sysLogs);
	 }
	 
	 public String getExportPath(String fileName){
		 if(CommonUtils.isEmpty(fileName)){
			 fileName="";
		 }else{
			 fileName="/"+fileName;
		 }
		 String path=null;
		try {
			path = new ClassPathResource("../export"+fileName).getFile().getAbsolutePath();
		} catch (Exception e) {
			e.printStackTrace();
		}
		 return path;
	 }
	 
	 
	 public Member getCurrentMember(){
		return memberService.getCurrent();
	 }
	 
	 
	 protected Map<String,Object> success(){
		 Map<String,Object> map = new HashMap<>();
		 map.put("error", "00");
		 return map;
	 }
	 
	 protected Map<String,Object> error(String msg){
		 Map<String,Object> map = new HashMap<>();
		 map.put("error", msg);
		 return map;
	 }
}
