package com.controller.cura;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bo.cura.LoginBo;
import com.bo.cura.LoginVo;
import com.bo.cura.RespBean;
import com.controller.CuraBaseController;
import com.controller.GlobalConstant;
import com.service.MessageService;
import com.service.NoticeService;
import com.service.UserSecondService;

@Controller("curaLoginController")
@RequestMapping("/cura")
public class LoginController extends CuraBaseController{
	
	@Autowired
	private UserSecondService userSecondService;
	
	@Autowired
	private MessageService messageService;
	
	@Autowired
	private NoticeService noticeService;
	
	@RequestMapping("/login")
	public String login(ModelMap model){
		model.put("notices", noticeService.getLatest());
		return "cura/login";
	}
	
	@RequestMapping("/loginCheck")
	@ResponseBody
	public RespBean loginCheck(LoginBo bo, HttpServletRequest req){
		if(StringUtils.isBlank(bo.getUserName())){
			return failure("请输入用户名!");
		}
		if(StringUtils.isBlank(bo.getPassword())){
			return failure("请输入密码!");
		}
		//手机或者证件号
		LoginVo vo = userSecondService.findUserSecondByPhoneOrCardNo(bo);
		if(StringUtils.isNotBlank(vo.getMessage())){
			return failure(vo.getMessage());
		}
		if(!DigestUtils.md5Hex(bo.getPassword()).equals(vo.getPassword())){
			return failure("密码错误");
		}
		if(req.getSession(false) == null){
			req.getSession(true);
		}
		vo.setUnread(messageService.getUnreadCount(vo.getUserSecondId()));
		set(req,GlobalConstant.LOGIN_SUCCESS_KEY, vo);
		set(req,"name", vo.getName());
		return success();
	}
	/**
	 * 校验登录状态
	 * @param req
	 * @return
	 */
	@RequestMapping("/isLogin")
	@ResponseBody
	public RespBean isLogin(HttpServletRequest req){
		Object obj = get(req,GlobalConstant.LOGIN_SUCCESS_KEY);
		if(obj == null){
			return failure("未登陆");
		}
		return success();
	}
	/**
	 * 登出
	 * @param req
	 * @return
	 */
	@RequestMapping("/logout")
	public String logout(HttpServletRequest req){
		if(req !=null && req.getSession(false) != null){
			remove(req,GlobalConstant.LOGIN_SUCCESS_KEY);
			remove(req,"name");
		}
		return "cura/index";
	}
}
