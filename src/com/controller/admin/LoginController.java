package com.controller.admin;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.DisabledAccountException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.common.AuthenticationToken;
import com.controller.AdminBaseController;
import com.util.IpUtil;

@Controller("adminLoginController")
@RequestMapping("/admin/login")
public class LoginController extends AdminBaseController{

	@RequestMapping()
	public String login(){
		Subject currentUser = SecurityUtils.getSubject();
		//验证是否成功登录的方法
		if(currentUser.isAuthenticated()){
			return "redirect:/admin/main.htm";
		} 
		return "cms/login";
	}
	
	@RequestMapping("/up")
	@ResponseBody
	public Object up(String username,String password,String kaptcha,HttpServletRequest request){
		Map<String, String> map=new HashMap<>();
		if(StringUtils.isBlank(username)){
			map.put("info", "用户名不存在系统");
			return map;
		}
		if(StringUtils.isBlank(password)){
			map.put("info", "密码错误");
			return map;
		}
//		if(StringUtils.isBlank(kaptcha)){
//			modelMap.put("info", "验证码为空");
//			return "login";
//		}
//		if(!StringUtils.equals(kaptcha, (String)request.getSession().getAttribute(Constants.KAPTCHA_SESSION_KEY))){
//			modelMap.put("info", "验证码错误");
//			return "login";
//		}
		Subject currentUser = SecurityUtils.getSubject();
		AuthenticationToken authenticationToken=new AuthenticationToken(username,password, null,null, false,IpUtil.getIpAddr(request));
		try {
			  currentUser.login(authenticationToken);
			} catch (UnknownAccountException uae ) { 
				map.put("info", "用户名不存在系统");
				return map;
			} catch (IncorrectCredentialsException ice ) { 
				map.put("info", "密码错误");
				return map;
			} catch (DisabledAccountException lae ) { 
				map.put("info", "用户被禁用");
				return map;
			} 
			//验证是否成功登录的方法
			if(currentUser.isAuthenticated()){
				addLog("用户登录", "登录用户:"+username);
				map.put("info", "00");
				return map;
			}else{
				map.put("info", "系统异常");
				return map;
			}   
	}
	
	@RequestMapping(value="/logout")
	public String logout(ModelMap modelMap) {
		Subject subject = SecurityUtils.getSubject();
		if (subject.isAuthenticated()) {
			subject.logout(); // session 会销毁，在SessionListener监听session销毁，清理权限缓存
			return "redirect:/admin/login.htm";
		}
		return "redirect:/admin/login.htm";
	}
}
