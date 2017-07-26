/**
 * 
 */
package com.controller.cura;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bo.UserApplyVo;
import com.bo.UserShareCunxuVo;
import com.bo.cura.AppointmentBo;
import com.bo.cura.AppointmentQueryBo;
import com.bo.cura.AppointmentQueryVo;
import com.bo.cura.InvestedVo;
import com.bo.cura.LoginVo;
import com.bo.cura.RespBean;
import com.controller.CuraBaseController;
import com.controller.GlobalConstant;
import com.entity.Appointment;
import com.entity.UserBonus;
import com.service.AppointmentService;
import com.service.MessageService;
import com.service.UserApplyService;
import com.service.UserBonusService;
import com.service.UserShareService;
import com.util.CaptchaUtils;

/**
 * @author	tyb
 * @date	2016年9月5日上午11:05:27
 * @desc	预约
 */
@Controller("curaAppointmentController")
@RequestMapping("/cura/appointment")
public class AppointmentController extends CuraBaseController {
	
	@Autowired
	private AppointmentService appointmentService;
	
	@Autowired
	private UserApplyService userApplyService;
	
	@Autowired
	private MessageService messageService;
	
	@Autowired
	private UserShareService userShareService;
	
	@Autowired
	private UserBonusService userBonusService;
	
	@RequestMapping("/add")
	@ResponseBody
	public RespBean add(Appointment bo, ModelMap model,HttpServletRequest req, HttpServletResponse resp){
		
		return success();
	}
	
	/**
	 * 前台申请预约
	 * @param bo
	 * @param req
	 * @return
	 */
	@RequestMapping("/apply")
	@ResponseBody
	public RespBean add(AppointmentBo bo,HttpServletRequest req){
		if(StringUtils.isBlank(bo.getName())){
			return failure("姓名必填!");
		}
		if(StringUtils.isBlank(bo.getPhone())){
			return failure("手机号必填!");
		}
		if(StringUtils.isBlank(bo.getCaptcha())){
			return failure("验证码必填!");
		}
		AppointmentBo sys = get(req, GlobalConstant.APPOINTMENT_KEY);
		if(sys != null && StringUtils.isNotBlank(sys.getCaptchaSys())){
			if(StringUtils.isBlank(bo.getCaptcha())){
				return failure("验证码必填!");
			}
			if(!bo.getCaptcha().toUpperCase().equals(sys.getCaptchaSys())){
				return failure("验证码错误!");
			}
		}
		Appointment entity = new Appointment();
		BeanUtils.copyProperties(bo, entity);
		Date now = new Date();
		entity.setCreateTime(now);
		entity.setUpdateTime(now);
		entity.setStartTime(now);
		entity.setCallbackStatus(0);
		appointmentService.save(entity);
		return success();
	}
	
	
	@RequestMapping("/captach")
	public void genCaptacha(ModelMap model,HttpServletRequest req, HttpServletResponse resp) throws IOException{//生成验证码
		resp.setHeader("Cache-Control", "no-store");
		resp.setDateHeader("Expires", 0);
		resp.setContentType("image/jpeg");
		String captcha = CaptchaUtils.genDefaultCode();
		AppointmentBo obj = get(req,GlobalConstant.APPOINTMENT_KEY);
		AppointmentBo bo = null;
		if(obj == null){
			bo = new AppointmentBo();
			set(req,GlobalConstant.APPOINTMENT_KEY, bo);
		}else{
			bo = obj;
		}
		bo.setCaptchaSys(captcha);
		CaptchaUtils.gen(112, 37, resp.getOutputStream(),captcha);
		//更新验证码
		resp.getOutputStream().flush();
		resp.getOutputStream().close();
	}
	
	/**
	 * 预约查询
	 * @param bo
	 * @return
	 */
	@RequestMapping("/list")
	@ResponseBody
	public List<AppointmentQueryVo> productJson(AppointmentQueryBo bo,HttpServletRequest req){
		LoginVo vo = get(req, GlobalConstant.LOGIN_SUCCESS_KEY);
		if(vo == null){
			return new ArrayList<AppointmentQueryVo>();
		}
		vo.setUnread(messageService.getUnreadCount(vo.getUserSecondId()));
		bo.setUserSecondId(vo.getUserSecondId());
		List<AppointmentQueryVo> list = userApplyService.curaList(bo);
		return list;
	}
	/**
	 * 预约明细查询
	 * @param bo
	 * @param req
	 * @return
	 */
	@RequestMapping("/detail")
	@ResponseBody
	public List<UserApplyVo> detail(AppointmentQueryBo bo,HttpServletRequest req){
		LoginVo vo = get(req, GlobalConstant.LOGIN_SUCCESS_KEY);
		if(vo == null){
			return new ArrayList<UserApplyVo>();
		}
		vo.setUnread(messageService.getUnreadCount(vo.getUserSecondId()));
		bo.setCardNo(vo.getCardNo());//根据证件号查询
		bo.setUserSecondId(vo.getUserSecondId());
		return userApplyService.curaDetailList(bo);
	}
	/**
	 * 已投产品
	 * @param bo
	 * @param req
	 * @return
	 */
	@RequestMapping("/invested")
	@ResponseBody
	public List<InvestedVo> invested(AppointmentQueryBo bo,HttpServletRequest req){
		LoginVo vo = get(req, GlobalConstant.LOGIN_SUCCESS_KEY);
		if(vo == null){
			return new ArrayList<InvestedVo>();
		}
		vo.setUnread(messageService.getUnreadCount(vo.getUserSecondId()));
		bo.setCardNo(vo.getCardNo());//根据证件号查询
		List<InvestedVo> list = userApplyService.curaInvestedList(bo);
		return list;
	}
	/**
	 * 已投产品明细
	 * @param bo
	 * @param req
	 * @return
	 */
	@RequestMapping("/invested/detail")
	@ResponseBody
	public List<UserShareCunxuVo> investedDetail(AppointmentQueryBo bo,HttpServletRequest req){
		LoginVo vo = get(req, GlobalConstant.LOGIN_SUCCESS_KEY);
		if(vo == null){
			return new ArrayList<UserShareCunxuVo>();
		}
		bo.setCardNo(vo.getCardNo());
		return userShareService.getFundShare(bo);
	}
	
	/**
	 * 分红查询
	 * @param bo
	 * @param req
	 * @return
	 */
	@RequestMapping("/profit")
	@ResponseBody
	public List<UserBonus> profit(AppointmentQueryBo bo,HttpServletRequest req){
		LoginVo vo = get(req, GlobalConstant.LOGIN_SUCCESS_KEY);
		if(vo == null){
			return new ArrayList<UserBonus>();
		}
		vo.setUnread(messageService.getUnreadCount(vo.getUserSecondId()));
		bo.setCardNo(vo.getCardNo());//根据证件号查询
		return userBonusService.getCuraList(bo);
	}
}
