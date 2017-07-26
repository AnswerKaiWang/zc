/**
 * 
 */
package com.controller.cura;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bo.cura.LoginBo;
import com.bo.cura.LoginVo;
import com.bo.cura.RegBo;
import com.bo.cura.RegThreeBo;
import com.bo.cura.RespBean;
import com.controller.CuraBaseController;
import com.controller.GlobalConstant;
import com.entity.UserSecondPer;
import com.service.UserSecondPerService;
import com.service.UserSecondService;
import com.util.CaptchaUtils;
import com.util.SMSUtils;

/**
 * @author	tyb
 * @date	2016年8月28日下午10:36:59
 * @desc	注册
 */
@Controller("curaRegController")
@RequestMapping("/cura/reg")
public class RegController extends CuraBaseController {
	
	@Autowired
	private UserSecondPerService userSecondPerService;
	
	@Autowired
	private UserSecondService userSecondService;
	
	/**
	 * 注册，分步注册
	 * @param model
	 * @return
	 */
	@RequestMapping
	public String reg(ModelMap model,HttpServletRequest req){
		RegBo bo = new RegBo();
		set(req,GlobalConstant.REG_KEY, bo);
		return "/cura/register";
	}
	/**
	 * 第二部，添加用户登录基础信息
	 * @param reqBo
	 * @param model
	 * @param req
	 * @return
	 */
	@RequestMapping("/two")
	public String two(RegBo reqBo, ModelMap model,HttpServletRequest req){
		Object obj = get(req,GlobalConstant.REG_KEY);
		if(obj == null){
			RegBo bo = new RegBo();
			set(req,GlobalConstant.REG_KEY, bo);
		}
		return "/cura/register2";
	}
	
	@RequestMapping("/checkTwo")
	@ResponseBody
	public RespBean checkTwo(RegBo reqBo, ModelMap model,HttpServletRequest req, HttpServletResponse resp){
		Object obj = get(req,GlobalConstant.REG_KEY);
		RegBo bo = null;
		if(obj == null){
			bo = new RegBo();
			set(req,GlobalConstant.REG_KEY, bo);
		}else{
			bo = (RegBo)obj;
		}
		if(StringUtils.isBlank(reqBo.getPhone())){
			//手机号必填
			return failure("手机号必填");
		}
		//是否已注册
		UserSecondPer usp = userSecondPerService.getByPhone(reqBo.getPhone());
		if(usp != null){
			return failure("手机号已注册");
		}
		if(StringUtils.isBlank(reqBo.getPassword())){
			return failure("请输入密码");
		}
		if(StringUtils.isBlank(reqBo.getAckPwd())){
			return failure("请输入确认码");
		}
		if(!reqBo.getPassword().equals(reqBo.getAckPwd())){
			return failure("密码与确认码不一致");
		}
		if(StringUtils.isBlank(reqBo.getCaptcha()) || !reqBo.getCaptcha().toUpperCase().equals(bo.getCaptchaSys())){
			return failure("图片验证码输入错误");
		}
		if(!GlobalConstant.DEF_SMS.equals(reqBo.getSmsCode())){
			if(StringUtils.isBlank(reqBo.getSmsCode())){
				return failure("短信验证码必填");
			}
			if(StringUtils.isBlank(bo.getSmsCodeSys()) || !bo.getSmsCodeSys().equals(reqBo.getSmsCode())){
				return failure("短信验证码错误");
			}
		}
		BeanUtils.copyProperties(reqBo, bo);
		return success();
	}
	
	@RequestMapping("/checkThree")
	@ResponseBody
	public RespBean checkThree(RegThreeBo reqBo, ModelMap model,HttpServletRequest req, HttpServletResponse resp){
//		if(StringUtils.isBlank(reqBo.getName())){
//			return failure("姓名必填");
//		}
		Object obj = get(req,GlobalConstant.REG_KEY);
		RegBo bo = null;
		if(obj == null){
			bo = new RegBo();
			set(req,GlobalConstant.REG_KEY, bo);
		}else{
			bo = (RegBo)obj;
		}
		BeanUtils.copyProperties(reqBo, bo);
		bo.setUserNo(userSecondService.genNextNo("geren"));
		userSecondPerService.curaRegUser(bo);
		remove(req,GlobalConstant.REG_KEY);
		LoginBo lbo = new LoginBo();
		lbo.setUserName(bo.getPhone());
		lbo.setType("geren");
		LoginVo vo = userSecondService.findUserSecondByPhoneOrCardNo(lbo);
		if(req.getSession() == null){
			req.getSession(true);
		}
		vo.setPhone(bo.getPhone());
		set(req,GlobalConstant.LOGIN_SUCCESS_KEY, vo);
		set(req,"name", vo.getName());
		return success();
	}
	
	/**
	 * 完成注册
	 * @param reqBo
	 * @param model
	 * @param req
	 * @return
	 */
	@RequestMapping("/three")
	public String three(RegBo reqBo, ModelMap model,HttpServletRequest req){
		return "/cura/register3";
	}
	
	@RequestMapping("/captach")
	public void genCaptacha(ModelMap model,HttpServletRequest req, HttpServletResponse resp) throws IOException{//生成验证码
		resp.setHeader("Cache-Control", "no-store");
		resp.setDateHeader("Expires", 0);
		resp.setContentType("image/jpeg");
		String captcha = CaptchaUtils.genDefaultCode();
		Object obj = get(req,GlobalConstant.REG_KEY);
		RegBo bo = null;
		if(obj == null){
			bo = new RegBo();
			set(req,GlobalConstant.REG_KEY, bo);
		}else{
			bo = (RegBo)obj;
		}
		bo.setCaptchaSys(captcha);
		CaptchaUtils.gen(112, 37, resp.getOutputStream(),captcha);
		//更新验证码
		resp.getOutputStream().flush();
		resp.getOutputStream().close();
	}
	/**
	 * 
	 * @param reqBo
	 * @param model
	 * @param req
	 * @param resp
	 * @return
	 */
	@RequestMapping("/sendMsg")
	@ResponseBody
	public RespBean sendMessage(RegBo reqBo, ModelMap model,HttpServletRequest req, HttpServletResponse resp){
		Object obj = get(req,GlobalConstant.REG_KEY);
		RegBo bo = null;
		if(obj == null){
			bo = new RegBo();
			set(req,GlobalConstant.REG_KEY, bo);
		}else{
			bo = (RegBo)obj;
		}
		String code = SMSUtils.rndCode();
		bo.setSmsCodeSys(code);
		SMSUtils.send(reqBo.getPhone(), code);
		return success();
	}
}
