/**
 * 
 */
package com.controller.cura;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bo.UserCurrentBo;
import com.bo.cura.CustBaseBo;
import com.bo.cura.LoginVo;
import com.bo.cura.RespBean;
import com.bo.cura.SurveyBo;
import com.controller.CuraBaseController;
import com.controller.GlobalConstant;
import com.entity.Message;
import com.entity.UserSecond;
import com.entity.UserSecondAttr;
import com.entity.UserSecondCom;
import com.entity.UserSecondContant;
import com.entity.UserSecondPer;
import com.enums.UserType;
import com.service.CompanyAttrService;
import com.service.MailService;
import com.service.MessageService;
import com.service.QtSurveyService;
import com.service.QuestionService;
import com.service.UserApplyService;
import com.service.UserSecondAttrService;
import com.service.UserSecondComService;
import com.service.UserSecondContantService;
import com.service.UserSecondPerService;
import com.service.UserSecondService;
import com.util.SMSUtils;

/**
 * @author	tyb
 * @date	2016年8月28日下午2:44:51
 * @desc	客户中心
 */
@Controller("curaCustCenterController")
@RequestMapping("/cura/cust")
public class CustCenterController extends CuraBaseController {
	
	@Resource
	private UserSecondService userSecondService ;
	@Resource
	private UserSecondPerService userSecondPerService ;
	@Resource
	private UserSecondComService userSecondComService ;
	@Resource
	private UserSecondContantService userSecondConstanceService ;
	@Resource
	private UserSecondAttrService userSecondAttrService ;
	@Resource
	private QuestionService questionService;
	@Resource
	private MessageService messageService;
	@Resource
	private MailService mailService;
	@Resource
	private UserApplyService userApplyService;
	@Resource
	private QtSurveyService qtSurveyService;
	@Resource
	private  CompanyAttrService companyAttrService;
	
	
	@Value("${mail.from}")
	private String from;
	
	private String nickname="中城投资";
	
	@Value("${mail.username}")
	private String username;
	
	@Value("${mail.smtp}")
	private String smtp;
	
	@Value("${mail.password}")
	private String password;
	
	@Value("${mail.port}")
	private Integer port;
	
	private String subject="中城投资修改邮箱验证码";
	
	private String template="<p>您好！&nbsp;</p><p>	本邮件由系统自动发出，请勿回复。&nbsp;若不是您本人操作，请拨打咨询热线：021-38870996。</p><p>	为了保证您的账号安全，该验证码20分钟内有效。</p><p><br></p><p><br></p>";
	
	/**
	 * 个人信息第二不
	 * @param model
	 * @param req
	 * @return
	 */
	@RequestMapping()
	public String grxi(Long productId,ModelMap model,HttpServletRequest req){
		if(!isLogined(req)){
			return "/cura/login";//返回
		}
		LoginVo vo  = get(req, GlobalConstant.LOGIN_SUCCESS_KEY);
		vo.setUnread(messageService.getUnreadCount(vo.getUserSecondId()));
		model.put("productId", productId);
		model.put("titles", questionService.findRiskTitleById(vo.getUserType()));
		model.put("investAmount", userApplyService.curaInvestAmount(vo.getCardNo()));
		if(vo.getUserType().equals("geren")){//个人
			return "/cura/grxi_gr";
		}else{//机构
			return "/cura/grxi_jg";
		}
	}
	
	/**
	 * 基本信息个人，或者机构
	 * @param model
	 * @param req
	 * @return
	 */
	@RequestMapping("/base")
	public String base(Long productId,ModelMap model,HttpServletRequest req){
		if(!isLogined(req)){
			return "/cura/login";//返回
		}
		LoginVo vo  = get(req, GlobalConstant.LOGIN_SUCCESS_KEY);
		vo.setUnread(messageService.getUnreadCount(vo.getUserSecondId()));
		if(productId != null && productId != 0L){
			model.put("productId", productId);
		}
		model.put("titles", questionService.findRiskTitleById(vo.getUserType()));
		model.put("investAmount", userApplyService.curaInvestAmount(vo.getCardNo()));
		if(vo.getUserType().equals("geren")){
			return "/cura/jbxi_gr";
		}else{
			return "/cura/jbxi_jg";
		}
	}
	
	@RequestMapping("/print")
	public String print(Long userScondId,ModelMap model,HttpServletRequest req){
		if(!isLogined(req)){
			return "/cura/login";//返回
		}
		LoginVo vo  = get(req, GlobalConstant.LOGIN_SUCCESS_KEY);
		model.put("titles", questionService.findRiskTitleById(vo.getUserType()));
		model.put("investAmount", userApplyService.curaInvestAmount(vo.getCardNo()));
		return "/cura/print";
	}
	
	/**
	 * 我的投资
	 * @param model
	 * @param userCurrentBo
	 * @param req
	 * @return
	 */
	@RequestMapping("/me")
	public String myAccount(ModelMap model,UserCurrentBo userCurrentBo,HttpServletRequest req){
		if(!isLogined(req)){
			return "/cura/login";//返回
		}
		LoginVo vo  = get(req, GlobalConstant.LOGIN_SUCCESS_KEY);
		model.put("titles", questionService.findRiskTitleById(vo.getUserType()));
		model.put("investAmount", userApplyService.curaInvestAmount(vo.getCardNo()));
		return "/cura/ytcp";
	}
	/**
	 * 已投产品
	 * @param model
	 * @return
	 */
	@RequestMapping("/invested")
	public String invested(ModelMap model,HttpServletRequest req){
		if(!isLogined(req)){
			return "/cura/login";//返回
		}
		LoginVo vo  = get(req, GlobalConstant.LOGIN_SUCCESS_KEY);
		model.put("titles", questionService.findRiskTitleById(vo.getUserType()));
		model.put("investAmount", userApplyService.curaInvestAmount(vo.getCardNo()));
		return "/cura/ytcp";
	}
	
	@RequestMapping("/invested/detail")
	public String investedDetail(Long id,ModelMap model,HttpServletRequest req){
		if(!isLogined(req)){
			return "/cura/login";//返回
		}
		LoginVo vo  = get(req, GlobalConstant.LOGIN_SUCCESS_KEY);
		model.put("titles", questionService.findRiskTitleById(vo.getUserType()));
		model.put("investAmount", userApplyService.curaInvestAmount(vo.getCardNo()));
		model.put("fundId", id);
		return "/cura/ytcp_detail";
	}
	
	/**
	 * 分红查询
	 * @param model
	 * @return
	 */
	@RequestMapping("/share")
	public String share(ModelMap model,HttpServletRequest req){
		if(!isLogined(req)){
			return "/cura/login";//返回
		}
		LoginVo vo  = get(req, GlobalConstant.LOGIN_SUCCESS_KEY);
		model.put("titles", questionService.findRiskTitleById(vo.getUserType()));
		model.put("investAmount", userApplyService.curaInvestAmount(vo.getCardNo()));
		return "/cura/fhcx_zc";
	}
	
	@RequestMapping("/share/detail")
	public String shareD(Long id,ModelMap model,HttpServletRequest req){
		if(!isLogined(req)){
			return "/cura/login";//返回
		}
		LoginVo vo  = get(req, GlobalConstant.LOGIN_SUCCESS_KEY);
		model.put("titles", questionService.findRiskTitleById(vo.getUserType()));
		model.put("investAmount", userApplyService.curaInvestAmount(vo.getCardNo()));
		model.put("fundId", id);
		return "/cura/fhcx_detail";
	}
	/**
	 * 预约查询
	 * @param model
	 * @return
	 */
	@RequestMapping("/appointment")
	public String appointment(ModelMap model,HttpServletRequest req){
		if(!isLogined(req)){
			return "/cura/login";//返回
		}
		LoginVo vo  = get(req, GlobalConstant.LOGIN_SUCCESS_KEY);
		model.put("titles", questionService.findRiskTitleById(vo.getUserType()));
		model.put("investAmount", userApplyService.curaInvestAmount(vo.getCardNo()));
		return "/cura/appointment_zc";
	}
	@RequestMapping("/appointment/detail")
	public String appointmentD(Long id,ModelMap model,HttpServletRequest req){
		if(!isLogined(req)){
			return "/cura/login";//返回
		}
		LoginVo vo  = get(req, GlobalConstant.LOGIN_SUCCESS_KEY);
		model.put("titles", questionService.findRiskTitleById(vo.getUserType()));
		model.put("investAmount", userApplyService.curaInvestAmount(vo.getCardNo()));
		model.put("fundId", id);
		return "/cura/appointment_detail";
	}
	/**
	 * 问卷调查
	 * @param model
	 * @param req
	 * @return
	 */
	@RequestMapping("/survey")
	public String suvery(ModelMap model,HttpServletRequest req){
		if(!isLogined(req)){
			return "/cura/login";//返回
		}
		LoginVo vo  = get(req, GlobalConstant.LOGIN_SUCCESS_KEY);
		model.put("titles", questionService.findRiskTitleById(vo.getUserType()));
		model.put("investAmount", userApplyService.curaInvestAmount(vo.getCardNo()));
		
		//问卷调查
		model.put("suveys", qtSurveyService.findLastestQsVo(model));
		return "/cura/questionSurvey";
	}
	
	@RequestMapping("/survey/add")
	@ResponseBody
	public RespBean survey(SurveyBo bo,HttpServletRequest req){
		if(!isLogined(req)){
			return failure("未登陆");//返回
		}
		LoginVo vo  = get(req, GlobalConstant.LOGIN_SUCCESS_KEY);
		qtSurveyService.addQsRecord(bo, vo.getUserSecondId());
		return success();
	}
	
	/**
	 * 我的消息
	 * @param model
	 * @param req
	 * @return
	 */
	@RequestMapping("/message")
	public String message(ModelMap model,HttpServletRequest req){
		if(!isLogined(req)){
			return "/cura/login";//返回
		}
		LoginVo vo  = get(req, GlobalConstant.LOGIN_SUCCESS_KEY);
		model.put("titles", questionService.findRiskTitleById(vo.getUserType()));
		model.put("investAmount", userApplyService.curaInvestAmount(vo.getCardNo()));
		return "/cura/message";
	}
	/**
	 * 消息列表
	 * @param req
	 * @return
	 */
	@RequestMapping("/message/list")
	@ResponseBody
	public List<Message> messageLst(Integer pageSize,Integer start,HttpServletRequest req){
		LoginVo vo = get(req, GlobalConstant.LOGIN_SUCCESS_KEY);
		if(vo == null){
			return new ArrayList<Message>();
		}
		vo.setUnread(messageService.getUnreadCount(vo.getUserSecondId()));
		List<Message> list = messageService.curaMessageList(pageSize,start,vo.getUserSecondId());
		return list;
	}
	@RequestMapping("/message/read")
	@ResponseBody
	public RespBean read(Long id,ModelMap model){
		Message msg = messageService.get(id);
		if(msg != null){
			msg.setReaded(1);
			msg.setUpdateTime(new Date());
			messageService.update(msg);
		}
		return success();
	}
	/**
	 * 
	 * @param model
	 * @param req
	 * @return
	 */
	@RequestMapping("/account")
	public String account(ModelMap model,HttpServletRequest req){
		if(!isLogined(req)){
			return "/cura/login";//返回
		}
		LoginVo vo  = get(req, GlobalConstant.LOGIN_SUCCESS_KEY);
		model.put("titles", questionService.findRiskTitleById(vo.getUserType()));
		model.put("investAmount", userApplyService.curaInvestAmount(vo.getCardNo()));
		return "/cura/account";
	}
	/**
	 * 重置密码
	 * @param newPwd
	 * @param ackPwd
	 * @param req
	 * @return
	 */
	@RequestMapping("/account/resetPwd")
	@ResponseBody
	public RespBean resetPwd(String newPwd,String ackPwd,HttpServletRequest req){
		if(StringUtils.isBlank(newPwd)){
			return failure("新密码必填");
		}
		if(StringUtils.isBlank(ackPwd)){
			return failure("确认密码必填");
		}
		if(!newPwd.equals(ackPwd)){
			return failure("新密码与确认密码不一致");
		}
		LoginVo vo = get(req, GlobalConstant.LOGIN_SUCCESS_KEY);
		if(vo == null){
			return failure("请重新登录");
		}
		userSecondService.resetPwd(vo.getUserSecondId(), DigestUtils.md5Hex(newPwd));
		return success();
	}
	/**
	 * 重置手机
	 * @param phone
	 * @param smsCode
	 * @param req
	 * @return
	 */
	@RequestMapping("/account/resetPhone")
	@ResponseBody
	public RespBean resetPhone(String phone,String smsCode,HttpServletRequest req){
		LoginVo vo = get(req, GlobalConstant.LOGIN_SUCCESS_KEY);
		if(vo == null){
			return failure("请重新登录");
		}
		if(StringUtils.isBlank(phone)){
			return failure("电话必填");
		}
		if(StringUtils.isBlank(smsCode)){
			return failure("验证码必填");
		}
		String sysCode = get(req, GlobalConstant.RESET_SMS_KEY);
		if(StringUtils.isBlank(sysCode)){
			return failure("请发送验证码");
		}
		if(!smsCode.equals(sysCode)){
			return failure("验证码错误");
		}
		//手机是否重复
		if(userSecondService.hadExist(vo.getUserSecondId(), phone)){
			return failure("手机号重复");
		}
		remove(req, GlobalConstant.RESET_SMS_KEY);
		
		userSecondService.resetPhone(vo.getUserSecondId(), phone);
		return success();
	}
	
	@RequestMapping("/account/send")
	@ResponseBody
	public RespBean send(String phone,HttpServletRequest req){
		LoginVo vo = get(req, GlobalConstant.LOGIN_SUCCESS_KEY);
		if(vo == null){
			return failure("请重新登录");
		}
		if(StringUtils.isBlank(phone)){
			return failure("电话必填");
		}
		String code = SMSUtils.rndCode();
		SMSUtils.send(phone, code);
		set(req, GlobalConstant.RESET_SMS_KEY, code);
		return success();
	}
	
	/**
	 * 实名认证
	 * @param realName
	 * @param cardNo
	 * @param req
	 * @return
	 */
	@RequestMapping("/account/realName")
	@ResponseBody
	public RespBean realName(String realName,String cardNo,HttpServletRequest req){
		
		return success();
	}
	/**
	 * 重置邮箱
	 * @param email
	 * @param code
	 * @param req
	 * @return
	 */
	@RequestMapping("/account/resetEmail")
	@ResponseBody
	public RespBean resetEmail(String email,String code,HttpServletRequest req){
		LoginVo vo = get(req, GlobalConstant.LOGIN_SUCCESS_KEY);
		if(vo == null){
			return failure("请重新登录");
		}
		if(StringUtils.isBlank(email)){
			return failure("邮箱必填");
		}
		if(StringUtils.isBlank(code)){
			return failure("验证码必填");
		}
		String sysCode = get(req,GlobalConstant.RESTE_EMAIL_KEY);
		if(StringUtils.isBlank(sysCode)){
			return failure("请先获取邮件验证码");
		}
		if(!code.equals(sysCode)){
			return failure("验证码错误");
		}
		userSecondService.resetEmail(vo.getUserSecondId(), email);
		vo.setEmail(email);
		remove(req, GlobalConstant.RESTE_EMAIL_KEY);
		return success();
	}
	
	@RequestMapping("/account/sendEmail")
	@ResponseBody
	public RespBean sendEmail(String email,HttpServletRequest req){
		LoginVo vo = get(req, GlobalConstant.LOGIN_SUCCESS_KEY);
		if(vo == null){
			return failure("请重新登录");
		}
		if(StringUtils.isBlank(email)){
			return failure("邮箱必填");
		}
		String code = SMSUtils.rndEmailCode();
		template+="<div>你的验证码为:"+code+"</div>";
		int i=mailService.send(from, 
				smtp, 
				port, 
				username,
				nickname,
				password,
				email,
				subject, 
				template, null, false);
		if(i!=0){
			failure("发送验证码失败");
		}
		set(req,GlobalConstant.RESTE_EMAIL_KEY,code);
		return success();
	}
	
	/**
	 * 用户补全信息第一步 jbxr gr/机构
	 * @param model
	 * @return
	 */
	@RequestMapping("/info1")
	@ResponseBody
	public RespBean info(CustBaseBo bo, HttpServletRequest req){
		LoginVo vo = get(req, GlobalConstant.LOGIN_SUCCESS_KEY);
		if(vo == null){
			return failure("请重新登录");
		}
		if(bo == null){
			bo = new CustBaseBo();
		}
		if(bo.getId() == null || bo.getId() ==0){
			return failure("请重新登录!");
		}
		if(bo.getId() == null){
			return failure("请重新登录!");
		}
		if(StringUtils.isBlank(bo.getName())){
			return failure("客户姓名必填!");
		}
		if(UserType.geren.toString().equals(vo.getType())){//个人
			if(bo.getSex() == null){
				return failure("性别必填!");
			}
			if(StringUtils.isBlank(bo.getConEmail())){
				//return failure("电子邮箱必填!");
			}
			if(StringUtils.isBlank(bo.getCity())){
				return failure("所在城市必填!");
			}
			if(StringUtils.isBlank(bo.getCardType())){
				return failure("证件类型必填!");
			}
			if(StringUtils.isBlank(bo.getCardNo())){
				return failure("证件号必填!");
			}
			if(userSecondService.isRepeat(bo.getCardNo(),bo.getId())){
				return failure("证件号已存在!");
			}
		}else{//
			if(StringUtils.isBlank(bo.getCardNo())){
				return failure("公司营业执照必填!");
			}
			if(userSecondService.isRepeat(bo.getCardNo(),bo.getId())){
				return failure("公司营业执照已存在!");
			}
		}
		set(req,GlobalConstant.INFO_DATA, bo);
		return success();
	}
	/**
	 * 个人
	 * @param bo
	 * @param req
	 * @return
	 */
	@RequestMapping("/info2")
	@ResponseBody
	public RespBean info2(CustBaseBo bo, HttpServletRequest req){
		LoginVo vo = get(req, GlobalConstant.LOGIN_SUCCESS_KEY);
		if(vo == null){
			return failure("请重新登录");
		}
		if(bo == null){
			bo = new CustBaseBo();
		}
		CustBaseBo step1 = get(req, GlobalConstant.INFO_DATA);
		if(step1 == null){
			return failure("请从第一步开始!");
		}
		if(StringUtils.isBlank(step1.getName())){
			return failure("客户姓名必填!");
		}
		if("geren".equals(vo.getUserType())){
			if(step1.getSex() == null){
				return failure("性别必填!");
			}
			if(StringUtils.isBlank(step1.getName())){
				return failure("电子邮箱必填!");
			}
			if(StringUtils.isBlank(step1.getCity())){
				return failure("所在城市必填!");
			}
			if(StringUtils.isBlank(step1.getCardType())){
				return failure("证件类型必填!");
			}
		}else{//企业
			
		}
		UserSecond us = userSecondService.get(step1.getId());
		if(us == null){
			return failure("请重新登录!");
		}
		us.setName(step1.getName());
		us.setWelcomeCode(step1.getWelcomeCode());
		us.setUpdateTime(new Date());
		userSecondService.update(us);
		if(vo.getUserType().equals("geren")){
			//更新个信息
			UserSecondPer per = userSecondPerService.get(step1.getId());
			if(per != null){
				per.setPerSex(step1.getSex());
				per.setPerTel(step1.getConTel());
				per.setPerEmail(step1.getConEmail());
				per.setPerCityId(Long.valueOf(step1.getCity()));
				per.setGongzuoZhiwei(bo.getDuty());
				per.setPerZip(step1.getConZip());
				per.setPerAddr(step1.getConAddr());
				per.setPerCardTypeId(Long.valueOf(step1.getCardType()));
				per.setPerCardNo(step1.getCardNo());
				per.setPerQixian(step1.getValiateTime());
				per.setPerJiguan(step1.getFzCompany());
				if(StringUtils.isNotBlank(step1.getBirth())){
					per.setPerBirthday(fmtStrToDate(step1.getBirth()));
				}
				//第二步
				if(StringUtils.isNotBlank(bo.getJobId()))
					per.setPerZhiyeId(Long.valueOf(bo.getJobId()));
				if(StringUtils.isNotBlank(bo.getIndustryId()))
					per.setPerHangyeId(Long.valueOf(bo.getIndustryId()));
				per.setGongzuoCompany(bo.getCompany());
				if(StringUtils.isNotBlank(bo.getCountry()))
					per.setPerCountryId(Long.valueOf(bo.getCountry()));
				if(StringUtils.isNotBlank(bo.getEducation()))
					per.setPerXueliId(Long.valueOf(bo.getEducation()));
				userSecondPerService.update(per);
			}
			UserSecondAttr attr  = userSecondAttrService.get(step1.getId());
			if(attr != null){
				if(StringUtils.isNotBlank(bo.getIncome()))
					attr.setYearIncomeId(Long.valueOf(bo.getIncome()));
				attr.setCanTouru(bo.getCanInvestAmount());
				userSecondAttrService.update(attr);
			}else{
				attr = new UserSecondAttr();
				attr.setId(per.getId());
				if(StringUtils.isNotBlank(bo.getIncome()))
					attr.setYearIncomeId(Long.valueOf(bo.getIncome()));
				attr.setCanTouru(bo.getCanInvestAmount());
				userSecondAttrService.save(attr);
			}
			UserSecondContant contant = userSecondConstanceService.get(step1.getId());
			if(contant != null){
				contant.setConName(bo.getTruster());
				contant.setConPhone(bo.getTrusterPhone());
				userSecondConstanceService.update(contant);
			}else{
				contant = new UserSecondContant();
				contant.setId(per.getId());
				contant.setConName(bo.getTruster());
				contant.setConPhone(bo.getTrusterPhone());
				userSecondConstanceService.save(contant);
			}
			vo.setUnread(messageService.getUnreadCount(vo.getUserSecondId()));
			vo.setCardNo(step1.getCardNo());
			vo.setPhone(per.getPerPhone());
			vo.setEmail(per.getPerEmail());
			vo.setCardTypeId(per.getPerCardTypeId());
			vo.setName(per.getPerName());
			//更新用户信息
		}else{
			UserSecondCom com = userSecondComService.get(vo.getUserSecondId());
			if(com != null){
				
			}
		}
		//刷新用户基本信息
		
		return success();
	}
}
