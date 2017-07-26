package com.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.ConstraintViolation;
import javax.validation.Validator;

import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bo.cura.RegBo;
import com.bo.cura.RespBean;
import com.bo.cura.RespListBean;
import com.common.Principal;
import com.entity.Dictionary;
import com.entity.User;
import com.service.UserService;
import com.util.DateEditor;
import com.util.IntCleanEditor;
import com.util.JsonUtils;
import com.util.LongCleanEditor;
import com.util.SpringUtils;

public abstract class CuraBaseController {

//	private Logger logger=LoggerFactory.getLogger(getClass());
	@Resource(name = "validator")
	private Validator validator;
	@Resource
	private UserService userService;
	
	private static final SimpleDateFormat SDF = new SimpleDateFormat("yyyy-MM-dd");
	
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
	
	protected RespBean success(){
		return new RespBean("00","success");
	}
	protected RespBean success(Object data){
		return new RespBean("00","success",data);
	}
	protected RespBean failure(String message){
		return new RespBean("01",message);
	}
	/**
	 * 返回带分页的
	 * @param counts
	 * @param pages
	 * @param data
	 * @return
	 */
	protected RespListBean success(int counts, int pages, Object data){
		return new RespListBean(counts,pages,data);
	}
	
	protected String getDictionaryName(List<Dictionary> dics, Long id) {
		if(dics != null){
			for(Dictionary d: dics){
				if(d.getId() == id){
					return d.getName();
				}
			}
		}
		return "";
	}
	
	@SuppressWarnings("unchecked")
	protected <T> T get(HttpServletRequest req, String key){
		HttpSession hs = req.getSession(false);
		if(hs == null){
			return null;
		}
		return (T)hs.getAttribute(key);
	}
	
	protected <T> void set(HttpServletRequest req, String key, T data){
		HttpSession hs = req.getSession(false);
		if(hs != null){
			hs.setAttribute(key, data);
		}else{
			req.getSession(true).setAttribute(key, data);
		}
	}
	
	protected <T> void remove(HttpServletRequest req, String key){
		HttpSession hs = req.getSession(false);
		if(hs != null){
			hs.removeAttribute(key);
		}
	}
	
	protected boolean isLogined(HttpServletRequest req) {
		HttpSession hs = req.getSession(false);
		if(hs == null){
			return false;
		}
		Object ob =  hs.getAttribute(GlobalConstant.LOGIN_SUCCESS_KEY);
		return ob != null;
	}
	
	/**
	 * 日期偏移
	 * @param date
	 * @param offset
	 * @param unit
	 * @return
	 */
	protected Date moveDate(Date date, int offset, int unit){
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.add(unit, offset);
		return c.getTime();
	}
	/**
	 * 默认格式 yyyy-MM-dd
	 * @param dateStr
	 * @return
	 */
	protected Date fmtStrToDate(String dateStr){
		try {
			return SDF.parse(dateStr);
		} catch (ParseException e) {
			return null;
		}
	}
	
	protected String getYear(int field,int amount) {
		Calendar c = Calendar.getInstance();
		c.setTime(new Date());
		c.add(field, amount);
		return c.get(Calendar.YEAR)+"";
		
	}
}
