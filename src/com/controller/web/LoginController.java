package com.controller.web;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.common.Principal;
import com.controller.WebBaseController;
import com.entity.Company;
import com.entity.User;
import com.enums.Status;
import com.service.CompanyService;
import com.service.UserService;
import com.util.CommonUtils;

@Controller("WebLoginController")
public class LoginController extends WebBaseController{

	@Resource
	private UserService userService;
	@Resource
	private CompanyService companyService;
	
	@RequestMapping("login")
	@ResponseBody
	public Map<String, Object> login(String cardNo,String password,String validate,HttpServletRequest httpServletRequest){
		Map<String, Object> map=new HashMap<>();
		if(cardNo==null){
			map.put("error", "证件号码不能为空");
			return map;
		}
		if(!StringUtils.equals(validate,(String)httpServletRequest.getSession().getAttribute("loginImage"))){
			map.put("error", "验证码错误");
			return map;
		}
		User user=userService.getByCardNo(cardNo, currentCompany(httpServletRequest));
		if(user==null||CommonUtils.isEmpty(password)||!StringUtils.equals(DigestUtils.md5Hex(password), user.getPassword())){
			map.put("error", "证件号码或密码错误");
			return map;
		}
		if(Status.finish.equals(user.getStatus())){
			map.put("error", "证件号码或密码错误");
			return map;
		}
		Company company=null;
		if(user.getCompanyId()!=null){
			company=companyService.get(user.getCompanyId());
		}
		Principal principal=new Principal(user.getId(), user.getCardNo(), user.getName(), null, user.getCompanyId(),company==null?null:company.getName());
		principal.setLastLoginTime(user.getLastLoginTime());
		httpServletRequest.getSession().setAttribute(User.SESSION_USER, principal);
		user.setLastLoginTime(new Date());
		userService.update(user);
		map.put("error", "00");
		return map;
	}
}
