package com.controller.web;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bo.SmsCodeBo;
import com.controller.WebBaseController;
import com.entity.CompanyAttr;
import com.entity.SmsCode;
import com.entity.User;
import com.enums.SmsType;
import com.service.CompanyAttrService;
import com.service.MailService;
import com.service.SmsCodeService;
import com.service.UserService;
import com.util.CommonUtils;

@Controller("WebProtcetController")
@RequestMapping("/user")
public class ProtcetController extends WebBaseController{

	@Resource
	private UserService userService;
	@Resource
	private SmsCodeService smsCodeService;
	@Resource
	private  MailService mailService;
	@Resource
	private  CompanyAttrService companyAttrService;
	
	@RequestMapping("/info")
	public String info(HttpServletRequest request,ModelMap modelMap){
		User user=currentUser(request);
		String cardNo=user.getCardNo();
		if(CommonUtils.isNotEmpty(cardNo)){
		user.setCardNo(StringUtils.substring(cardNo, 0, 3)+"************"+StringUtils.substring(cardNo, cardNo.length()-3, cardNo.length()));
		}
		modelMap.put("user", user);
		return "web/user/info";
	}
	@RequestMapping("/update")
	@ResponseBody
	public Object update(HttpServletRequest request,ModelMap modelMap,String tel,String address,String zip){
		User user=currentUser(request);
		Map<String, Object> map=new HashMap<>();
		user.setAddress(address);
		user.setZip(zip);
		user.setTel(tel);
		user.setUpdateTime(new Date());
		userService.update(user);
		map.put("status", "00");
		return map;
	}
	@RequestMapping("/protect")
	public String protect(HttpServletRequest request,ModelMap modelMap){
		User user=currentUser(request);
		String cardNo=user.getCardNo();
		if(CommonUtils.isNotEmpty(cardNo)){
		user.setCardNo(StringUtils.substring(cardNo, 0, 3)+"************"+StringUtils.substring(cardNo, cardNo.length()-3, cardNo.length()));
		}
		String name=user.getName();
		if(CommonUtils.isNotEmpty(name)){
			user.setName(StringUtils.substring(name, 0, 1)+"**");
		}
		String phone=user.getPhone();
		if(CommonUtils.isNotEmpty(phone)){
			user.setPhone(StringUtils.substring(phone, 0, 3)+"*****"+StringUtils.substring(phone, phone.length()-1, phone.length()));
		}
		String email=user.getEmail();
		if(CommonUtils.isNotEmpty(email)){
			user.setEmail(StringUtils.substring(email, 0, 3)+"*****"+StringUtils.substring(email, email.indexOf("@"), email.length()>20?20:email.length())+(email.length()>20?"...":""));
		}
		modelMap.put("user", user);
		return "web/user/protect";
	}
	
	@RequestMapping("/loginout")
	public String loginout(HttpServletRequest request,ModelMap modelMap){
		request.getSession().setAttribute(User.SESSION_USER, null);
		return "redirect:/index.htm";
	}
	
	@RequestMapping("/password")
	public String password(HttpServletRequest request,ModelMap modelMap){
		return "web/user/password";
	}
	
	@RequestMapping("/updatePassword")
	@ResponseBody
	public Object updatePassword(HttpServletRequest request,ModelMap modelMap,String oldPassword,String newPassword,String newRePassword){
		Map<String, Object> map=new HashMap<>();
		if(CommonUtils.isEmpty(newPassword)||CommonUtils.isEmpty(newRePassword)){
			map.put("status", "新密码不能为空");
			return map;
		}
		if(newPassword.length()<6||newPassword.length()>15){
			map.put("status", "密码长度6到15位之间");
			return map;
		}
		if(!StringUtils.equals(newPassword, newRePassword)){
			map.put("status", "两次密码输入不一致");
			return map;
		}
		if(CommonUtils.isEmpty(oldPassword)){
			map.put("status", "请输入原密码");
			return map;
		}
		User user=currentUser(request);
		if(!StringUtils.equals(user.getPassword(), DigestUtils.md5Hex(oldPassword))){
			map.put("status", "原密码验证失败");
			return map;
		}
		user.setPassword(DigestUtils.md5Hex(newPassword));
		user.setUpdateTime(new Date());
		userService.update(user);
		map.put("status", "00");
		return map;
	}
	
	@RequestMapping("/email/code")
	public String emailCode(HttpServletRequest request,ModelMap modelMap){
		return "web/user/email";
	}
	@RequestMapping("/email/canGetCode")
	public String canGetCode(HttpServletRequest request,ModelMap modelMap){
		User user=currentUser(request);
		if(CommonUtils.isEmpty(user.getEmail())){
			modelMap.put("info", "暂无绑定邮箱");
			return "web/user/email";
		}
		String email=user.getEmail();
		user.setEmail(StringUtils.substring(email, 0, 3)+"*****"+StringUtils.substring(email, email.indexOf("@"), email.length()));
		modelMap.put("user", user);
		return "web/user/canGetCode";
	}
	
	@RequestMapping("/email/getCode")
	@ResponseBody
	public Object getCode(HttpServletRequest request,SmsType smsType,String email){
		//if(smsType==null){
			smsType=SmsType.bindEmail;
		//}
		Map<String, Object> modelMap=new HashMap<>();
		if(!smsType.equals(SmsType.bindEmail)&&!smsType.equals(SmsType.unBindEmail)){
			modelMap.put("status", "验证码类型错误");
			return modelMap;
		}
		User user=currentUser(request);
		if(smsType.equals(SmsType.unBindEmail)&&CommonUtils.isEmpty(user.getEmail())){
			modelMap.put("status", "暂无绑定邮箱");
			return modelMap;
		}
		//if(smsType.equals(SmsType.bindEmail)&&CommonUtils.isNotEmpty(user.getEmail())){
		//	modelMap.put("status", "请先解绑原邮箱");
		//	return modelMap;
		//}
		if(smsType.equals(SmsType.bindEmail)){
			if(CommonUtils.isEmpty(email)){
				modelMap.put("status", "请输入正确邮箱");
				return modelMap;
			}
			User user2=userService.getByEmail(email, user.getCompanyId());
			if(user2!=null){
				modelMap.put("status", "邮箱已绑定,请换个邮箱试试吧");
				return modelMap;
			}
		}else{
			email=user.getEmail();
		}
		SmsCodeBo smsCodeBo=new SmsCodeBo();
		smsCodeBo.setSmsType(smsType);
		smsCodeBo.setUserId(user.getId());
		smsCodeBo.setToNumber(email);
		smsCodeBo.setCreateTime(DateUtils.addMinutes(new Date(), -20));
		smsCodeBo.setUseStatus(0);
		List<SmsCode> smsCodes=smsCodeService.getByBo(smsCodeBo);
		if(CommonUtils.isNotEmpty(smsCodes)){
			modelMap.put("status", "请查看邮箱,20分钟后可以重新发送");
			return modelMap;
		}
		
		Date date=new Date();
		SmsCode smsCode =new SmsCode();
		smsCode.setCode(CommonUtils.createRandomForSms(8));
		smsCode.setCompanyId(user.getCompanyId());
		smsCode.setCreateTime(date);
		smsCode.setSmsType(smsType);
		smsCode.setToNumber(email);
		smsCode.setUpdateTime(date);
		smsCode.setUseStatus(0);
		smsCode.setUserId(user.getId());
		try {
			CompanyAttr smtpnickname=companyAttrService.getByName(user.getCompanyId(), "companySendEmailNickName");
			CompanyAttr smtpUsername=companyAttrService.getByName(user.getCompanyId(), "companySendEmailUserName");
			CompanyAttr smtpHost=companyAttrService.getByName(user.getCompanyId(), "companySendEmailSmtp");
			CompanyAttr smtpFromMail=companyAttrService.getByName(user.getCompanyId(), "companySendEmail");
			CompanyAttr smtpPort=companyAttrService.getByName(user.getCompanyId(), "companySendEmailPort");
			CompanyAttr smtpPassword=companyAttrService.getByName(user.getCompanyId(), "companySendEmailPassword");
			CompanyAttr subject=null;
			CompanyAttr templatePath=null;
			if(smsType.equals(SmsType.unBindEmail)){
				subject=companyAttrService.getByName(user.getCompanyId(), "companySendEmailUnBindSub");
				templatePath=companyAttrService.getByName(user.getCompanyId(), "companySendEmailUnBindContant");
			}
			if(smsType.equals(SmsType.bindEmail)){
				subject=companyAttrService.getByName(user.getCompanyId(), "companySendEmailBindSub");
				templatePath=companyAttrService.getByName(user.getCompanyId(), "companySendEmailBindContant");
			}
			String template=templatePath.getContant();
			template+="<div>你的验证码为:"+smsCode.getCode()+"</div>";
			int i=mailService.send(smtpFromMail.getContant(), smtpHost.getContant(), new Integer(smtpPort.getContant()), smtpUsername.getContant(),smtpnickname.getContant(),
					smtpPassword.getContant(),email,subject.getContant(), template, null, false);
			if(i==0){
				smsCodeService.saveAndUpdate(smsCode);
				modelMap.put("status", "00");
				return modelMap;
			}else{
				modelMap.put("status", "发送失败请重试");
				return modelMap;
			}
		} catch (Exception e) {
			modelMap.put("status", "发送失败请重试");
			return modelMap;
		}
	}
	
	@RequestMapping("/email/unbind")
	@ResponseBody
	public Object unbind(String code,HttpServletRequest request){
		User user=currentUser(request);
		Map<String, Object> modelMap=new HashMap<>();
		if(CommonUtils.isEmpty(user.getEmail())){
			modelMap.put("status", "暂无绑定邮箱");
			return modelMap;
		}
		SmsCodeBo smsCodeBo=new SmsCodeBo();
		smsCodeBo.setSmsType(SmsType.unBindEmail);
		smsCodeBo.setUserId(user.getId());
		smsCodeBo.setToNumber(user.getEmail());
		smsCodeBo.setCreateTime(DateUtils.addMinutes(new Date(), -20));
		smsCodeBo.setUseStatus(0);
		List<SmsCode> smsCodes=smsCodeService.getByBo(smsCodeBo);
		if(CommonUtils.isEmpty(smsCodes)){
			modelMap.put("status", "请输入正确的验证码");
			return modelMap;
		}
		SmsCode smsCode=smsCodes.get(0);
		if(!StringUtils.equals(smsCode.getCode(),code)){
			modelMap.put("status", "请输入正确的验证码");
			return modelMap;
		}
		Date date=new Date();
		user.setEmail(null);
		user.setUpdateTime(date);
		userService.update(user);
		smsCode.setUseStatus(1);
		smsCode.setUpdateTime(date);
		smsCodeService.update(smsCode);
		modelMap.put("status", "00");
		return modelMap;
	}
	
	@RequestMapping("/email/toBind")
	public String toBind(HttpServletRequest request,ModelMap modelMap){
		//User user=currentUser(request);
		//if(CommonUtils.isNotEmpty(user.getEmail())){
		//	modelMap.put("info", "请先解绑原邮箱");
		//}
		return "web/user/toEmailBind";
	}
	
	@RequestMapping("/email/bind")
	@ResponseBody
	public Object bind(String email,String code,HttpServletRequest request){
		User user=currentUser(request);
		Map<String, Object> modelMap=new HashMap<>();
		//if(CommonUtils.isNotEmpty(user.getEmail())){
		//	modelMap.put("status", "请先解绑原邮箱");
		//	return modelMap;
		//}
		if(CommonUtils.isEmpty(email)){
			modelMap.put("status", "请输入正确绑定邮箱");
			return modelMap;
		}
		User user2=userService.getByEmail(email, user.getCompanyId());
		if(user2!=null){
			modelMap.put("status", "邮箱已绑定,请换个邮箱试试吧");
			return modelMap;
		}
		SmsCodeBo smsCodeBo=new SmsCodeBo();
		smsCodeBo.setSmsType(SmsType.bindEmail);
		smsCodeBo.setUserId(user.getId());
		smsCodeBo.setToNumber(email);
		smsCodeBo.setCreateTime(DateUtils.addMinutes(new Date(), -20));
		smsCodeBo.setUseStatus(0);
		List<SmsCode> smsCodes=smsCodeService.getByBo(smsCodeBo);
		if(CommonUtils.isEmpty(smsCodes)){
			modelMap.put("status", "请输入正确的验证码");
			return modelMap;
		}
		SmsCode smsCode=smsCodes.get(0);
		if(!StringUtils.equals(smsCode.getCode(),code)){
			modelMap.put("status", "请输入正确的验证码");
			return modelMap;
		}
		Date date=new Date();
		user.setEmail(email);
		user.setUpdateTime(date);
		userService.update(user);
		smsCode.setUseStatus(1);
		smsCode.setUpdateTime(date);
		smsCodeService.update(smsCode);
		modelMap.put("status", "00");
		return modelMap;
	}
	
	@RequestMapping("/phone/toUnBind")
	public String toUnBindPhone(HttpServletRequest request,ModelMap modelMap){
		User user=currentUser(request);
		if(CommonUtils.isEmpty(user.getEmail())){
			modelMap.put("info", "请先绑定手机");
			return "web/user/bindPhone";
		}else{
			String phone=user.getPhone();
			user.setPhone(StringUtils.substring(phone, 0, 3)+"*****"+StringUtils.substring(phone, phone.length()-1, phone.length()));
			modelMap.put("user", user);
			return "web/user/unBindPhone";
		}
	}
	
	@RequestMapping("/phone/getCode")
	@ResponseBody
	public Object getPhoneCode(HttpServletRequest request,SmsType smsType,String phone){
		if(smsType==null){
			smsType=SmsType.unbindPhone;
		}
		Map<String, Object> modelMap=new HashMap<>();
		if(!smsType.equals(SmsType.bindPhone)&&!smsType.equals(SmsType.unbindPhone)){
			modelMap.put("status", "验证码类型错误");
			return modelMap;
		}
		User user=currentUser(request);
		if(smsType.equals(SmsType.unbindPhone)&&CommonUtils.isEmpty(user.getPhone())){
			modelMap.put("status", "暂无绑定手机");
			return modelMap;
		}
		if(smsType.equals(SmsType.bindPhone)&&CommonUtils.isNotEmpty(user.getPhone())){
			modelMap.put("status", "请先解绑原手机");
			return modelMap;
		}
		if(smsType.equals(SmsType.bindPhone)){
			if(CommonUtils.isEmpty(phone)){
				modelMap.put("status", "请输入正确电话号码");
				return modelMap;
			}
			User user2=userService.getByPhone(phone, user.getCompanyId());
			if(user2!=null){
				modelMap.put("status", "手机号码已绑定,请换个手机试试吧");
				return modelMap;
			}
		}else{
			phone=user.getPhone();
		}
		SmsCodeBo smsCodeBo=new SmsCodeBo();
		smsCodeBo.setSmsType(smsType);
		smsCodeBo.setUserId(user.getId());
		smsCodeBo.setToNumber(phone);
		smsCodeBo.setCreateTime(DateUtils.addMinutes(new Date(), -1));
		smsCodeBo.setUseStatus(0);
		List<SmsCode> smsCodes=smsCodeService.getByBo(smsCodeBo);
		if(CommonUtils.isNotEmpty(smsCodes)){
			modelMap.put("status", "请查看手机短信,1分钟后可以重新发送");
			return modelMap;
		}
		
		Date date=new Date();
		SmsCode smsCode =new SmsCode();
		smsCode.setCode(CommonUtils.createRandomForSms(6));
		smsCode.setCompanyId(user.getCompanyId());
		smsCode.setCreateTime(date);
		smsCode.setSmsType(smsType);
		smsCode.setToNumber(phone);
		smsCode.setUpdateTime(date);
		smsCode.setUseStatus(0);
		smsCode.setUserId(user.getId());
		try {
			String contant="你的验证码是 : "+smsCode.getCode()+"，切勿转告他人。验证码过期时间为10分钟";
			int i=mailService.sendPhone(phone, contant);
			if(i==0){
				smsCodeService.saveAndUpdate(smsCode);
				modelMap.put("status", "00");
				return modelMap;
			}else{
				modelMap.put("status", "发送失败请重试");
				return modelMap;
			}
		} catch (Exception e) {
			modelMap.put("status", "发送失败请重试");
			return modelMap;
		}
	}
	@RequestMapping("/phone/unBind")
	@ResponseBody
	public Object unBindPhone(String code,HttpServletRequest request){
		User user=currentUser(request);
		Map<String, Object> modelMap=new HashMap<>();
		if(CommonUtils.isEmpty(user.getPhone())){
			modelMap.put("status", "暂无绑定电话呢");
			return modelMap;
		}
		SmsCodeBo smsCodeBo=new SmsCodeBo();
		smsCodeBo.setSmsType(SmsType.unbindPhone);
		smsCodeBo.setUserId(user.getId());
		smsCodeBo.setToNumber(user.getPhone());
		smsCodeBo.setCreateTime(DateUtils.addMinutes(new Date(), -10));
		smsCodeBo.setUseStatus(0);
		List<SmsCode> smsCodes=smsCodeService.getByBo(smsCodeBo);
		if(CommonUtils.isEmpty(smsCodes)){
			modelMap.put("status", "请输入正确的验证码");
			return modelMap;
		}
		SmsCode smsCode=smsCodes.get(0);
		if(!StringUtils.equals(smsCode.getCode(),code)){
			modelMap.put("status", "请输入正确的验证码");
			return modelMap;
		}
		Date date=new Date();
		user.setPhone(null);;
		user.setUpdateTime(date);
		userService.update(user);
		smsCode.setUseStatus(1);
		smsCode.setUpdateTime(date);
		smsCodeService.update(smsCode);
		modelMap.put("status", "00");
		return modelMap;
	}
	
	@RequestMapping("/phone/toBind")
	public String toBindPhone(HttpServletRequest request,ModelMap modelMap){
		User user=currentUser(request);
		if(CommonUtils.isNotEmpty(user.getPhone())){
			modelMap.put("info", "请先在此页面解绑原手机");
			String phone=user.getPhone();
			user.setPhone(StringUtils.substring(phone, 0, 3)+"*****"+StringUtils.substring(phone, phone.length()-1, phone.length()));
			modelMap.put("user", user);
			return "web/user/unBindPhone";
		}
		return "web/user/bindPhone";
	}
	
	@RequestMapping("/phone/bind")
	@ResponseBody
	public Object bindPhone(String phone,String code,String validate,HttpServletRequest request){
		User user=currentUser(request);
		Map<String, Object> modelMap=new HashMap<>();
		if(CommonUtils.isNotEmpty(user.getPhone())){
			modelMap.put("status", "请先解绑原手机号码");
			return modelMap;
		}
		if(CommonUtils.isEmpty(phone)){
			modelMap.put("status", "请输入正确绑定手机号码");
			return modelMap;
		}
		SmsCodeBo smsCodeBo=new SmsCodeBo();
		smsCodeBo.setSmsType(SmsType.bindPhone);
		smsCodeBo.setUserId(user.getId());
		smsCodeBo.setToNumber(phone);
		smsCodeBo.setCreateTime(DateUtils.addMinutes(new Date(), -10));
		smsCodeBo.setUseStatus(0);
		List<SmsCode> smsCodes=smsCodeService.getByBo(smsCodeBo);
		if(CommonUtils.isEmpty(smsCodes)){
			modelMap.put("status", "请输入正确的验证码");
			return modelMap;
		}
		SmsCode smsCode=smsCodes.get(0);
		if(!StringUtils.equals(smsCode.getCode(),code)){
			modelMap.put("status", "请输入正确的验证码");
			return modelMap;
		}
		User user2=userService.getByPhone(phone, user.getCompanyId());
		if(user2!=null){
			modelMap.put("status", "手机号码已绑定,请换个手机试试吧");
			return modelMap;
		}
		Date date=new Date();
		user.setPhone(phone);
		user.setUpdateTime(date);
		userService.update(user);
		smsCode.setUseStatus(1);
		smsCode.setUpdateTime(date);
		smsCodeService.update(smsCode);
		modelMap.put("status", "00");
		return modelMap;
	}
	
}
