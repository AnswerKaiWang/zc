package com.controller.web;

import java.text.ParseException;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bo.UserBonusVo;
import com.bo.UserCurrentBo;
import com.bo.UserShareCunxuVo;
import com.common.Principal;
import com.controller.WebBaseController;
import com.enums.FundStatus;
import com.github.pagehelper.PageInfo;
import com.service.FundService;
import com.service.UserBonusService;
import com.service.UserShareService;
import com.util.CommonUtils;

@Controller("WebUserController")
@RequestMapping("/user")
public class UserController extends WebBaseController{

	@Resource
	private UserShareService userShareService;
	@Resource
	private UserBonusService userBonusService;
	@Resource
	private FundService fundService;
	
	
	@RequestMapping("/center")
	public String userCenter(HttpServletRequest request,ModelMap modelMap,String fromDate){
		Principal principal=currentPrincipal(request);
		modelMap.put("user",principal);
		Date startDate=null;
		if(CommonUtils.isEmpty(fromDate)){
			startDate=null;
		}else if("1".equals(fromDate)){//最近一天
			Calendar calendar=Calendar.getInstance();
			calendar.set(Calendar.HOUR, 0);
			calendar.set(Calendar.MINUTE, 0);
			calendar.set(Calendar.SECOND, 0);
			calendar.add(Calendar.DATE, -1);
			startDate=calendar.getTime();
		}else if("7".equals(fromDate)){//最近7天
			Calendar calendar=Calendar.getInstance();
			calendar.set(Calendar.HOUR, 0);
			calendar.set(Calendar.MINUTE, 0);
			calendar.set(Calendar.SECOND, 0);
			calendar.add(Calendar.DATE, -7);
			startDate=calendar.getTime();
		}else if ("30".equals(fromDate)) {//最近30天
			Calendar calendar=Calendar.getInstance();
			calendar.set(Calendar.HOUR, 0);
			calendar.set(Calendar.MINUTE, 0);
			calendar.set(Calendar.SECOND, 0);
			calendar.add(Calendar.MONTH, -1);
			startDate=calendar.getTime();
		}else if("90".equals(fromDate)){//最近90天
			Calendar calendar=Calendar.getInstance();
			calendar.set(Calendar.HOUR, 0);
			calendar.set(Calendar.MINUTE, 0);
			calendar.set(Calendar.SECOND, 0);
			calendar.add(Calendar.MONTH, -3);
			startDate=calendar.getTime();
		}else{
			try {
				startDate=DateUtils.parseDate(fromDate, new String[]{"yyyy-MM-dd"});
			} catch (ParseException e) {
				startDate=null;
			}
		}
		UserCurrentBo userCurrentBo=new UserCurrentBo();
		userCurrentBo.setCompanyId(currentCompany(request));
		userCurrentBo.setStartTime(startDate);
		userCurrentBo.setUserId(principal.getId());
		userCurrentBo.setFundStatus(new FundStatus[]{FundStatus.cunxuqi,FundStatus.rengouqi});
		List<UserShareCunxuVo> cunxuVos=userShareService.getCunxuFromDate(userCurrentBo);
		modelMap.put("cunxus", CommonUtils.isEmpty(cunxuVos)?null:cunxuVos);
		modelMap.put("startDate", startDate);
		modelMap.put("fromDate", fromDate);
		Locale locale=request.getLocale();
		Calendar calendar=Calendar.getInstance(locale);
		int hour=calendar.get(Calendar.HOUR_OF_DAY);
		String greeting="";
		if(hour<=6){
		 greeting="现在是凌晨";
		}else if(hour<=9){
		 greeting="早上好";
		}else if(hour<=12){
		 greeting="上午好";
		}else if(hour<=18){
		 greeting="下午好";
		}else if(hour<=24){
		 greeting="晚上好";
		}else{
		 greeting="";
		}
		modelMap.put("welcomeText", greeting);
		return "web/user/center";
	}

	
	@RequestMapping("/current")
	public String current(HttpServletRequest request,ModelMap modelMap,UserCurrentBo userCurrentBo){
		Principal principal=currentPrincipal(request);
		modelMap.put("user",principal);
		Date startDate=null;
		if("1".equals(userCurrentBo.getTimeType())){//全部
			userCurrentBo.setStartTime(null);
			userCurrentBo.setEndTime(null);
		}else if("7".equals(userCurrentBo.getTimeType())){//最近7天
			Calendar calendar=Calendar.getInstance();
			calendar.set(Calendar.HOUR, 0);
			calendar.set(Calendar.MINUTE, 0);
			calendar.set(Calendar.SECOND, 0);
			calendar.add(Calendar.DATE, -7);
			userCurrentBo.setStartTime(calendar.getTime());
			userCurrentBo.setEndTime(new Date());
		}else if ("30".equals(userCurrentBo.getTimeType())) {//最近30天
			Calendar calendar=Calendar.getInstance();
			calendar.set(Calendar.HOUR, 0);
			calendar.set(Calendar.MINUTE, 0);
			calendar.set(Calendar.SECOND, 0);
			calendar.add(Calendar.MONTH, -1);
			userCurrentBo.setStartTime(calendar.getTime());
			userCurrentBo.setEndTime(new Date());
		}else if("90".equals(userCurrentBo.getTimeType())){//最近90天
			Calendar calendar=Calendar.getInstance();
			calendar.set(Calendar.HOUR, 0);
			calendar.set(Calendar.MINUTE, 0);
			calendar.set(Calendar.SECOND, 0);
			calendar.add(Calendar.MONTH, -3);
			startDate=calendar.getTime();
			userCurrentBo.setStartTime(startDate);
			userCurrentBo.setEndTime(new Date());
		}
		userCurrentBo.setCompanyId(currentCompany(request));
		userCurrentBo.setUserId(principal.getId());
		userCurrentBo.setFundStatus(new FundStatus[]{FundStatus.cunxuqi,FundStatus.rengouqi});
		PageInfo<UserShareCunxuVo> cunxuVos=userShareService.getUserCurrent(userCurrentBo);
		modelMap.put("bo", userCurrentBo);
		modelMap.put("info", cunxuVos);
		return "web/user/current";
	}
	@RequestMapping("/history")
	public String history(HttpServletRequest request,ModelMap modelMap,UserCurrentBo userCurrentBo){
		Principal principal=currentPrincipal(request);
		modelMap.put("user",principal);
		Date startDate=null;
		if("1".equals(userCurrentBo.getTimeType())){//全部
			userCurrentBo.setStartTime(null);
			userCurrentBo.setEndTime(null);
		}else if("7".equals(userCurrentBo.getTimeType())){//最近7天
			Calendar calendar=Calendar.getInstance();
			calendar.set(Calendar.HOUR, 0);
			calendar.set(Calendar.MINUTE, 0);
			calendar.set(Calendar.SECOND, 0);
			calendar.add(Calendar.DATE, -7);
			userCurrentBo.setStartTime(calendar.getTime());
			userCurrentBo.setEndTime(new Date());
		}else if ("30".equals(userCurrentBo.getTimeType())) {//最近30天
			Calendar calendar=Calendar.getInstance();
			calendar.set(Calendar.HOUR, 0);
			calendar.set(Calendar.MINUTE, 0);
			calendar.set(Calendar.SECOND, 0);
			calendar.add(Calendar.MONTH, -1);
			userCurrentBo.setStartTime(calendar.getTime());
			userCurrentBo.setEndTime(new Date());
		}else if("90".equals(userCurrentBo.getTimeType())){//最近90天
			Calendar calendar=Calendar.getInstance();
			calendar.set(Calendar.HOUR, 0);
			calendar.set(Calendar.MINUTE, 0);
			calendar.set(Calendar.SECOND, 0);
			calendar.add(Calendar.MONTH, -3);
			startDate=calendar.getTime();
			userCurrentBo.setStartTime(startDate);
			userCurrentBo.setEndTime(new Date());
		}
		userCurrentBo.setCompanyId(currentCompany(request));
		userCurrentBo.setFundStatus(new FundStatus[]{FundStatus.jieshuqi});
		userCurrentBo.setUserId(principal.getId());
		PageInfo<UserShareCunxuVo> cunxuVos=userShareService.getUserCurrent(userCurrentBo);
		modelMap.put("bo", userCurrentBo);
		modelMap.put("info", cunxuVos);
		return "web/user/history";
	}
	
	@RequestMapping("/bonus")
	public String bonus(HttpServletRequest request,ModelMap modelMap,UserCurrentBo userCurrentBo){
		Principal principal=currentPrincipal(request);
		modelMap.put("user",principal);
		Date startDate=null;
		if("1".equals(userCurrentBo.getTimeType())){//全部
			userCurrentBo.setStartTime(null);
			userCurrentBo.setEndTime(null);
		}else if("7".equals(userCurrentBo.getTimeType())){//最近7天
			Calendar calendar=Calendar.getInstance();
			calendar.set(Calendar.HOUR, 0);
			calendar.set(Calendar.MINUTE, 0);
			calendar.set(Calendar.SECOND, 0);
			calendar.add(Calendar.DATE, -7);
			userCurrentBo.setStartTime(calendar.getTime());
			userCurrentBo.setEndTime(new Date());
		}else if ("30".equals(userCurrentBo.getTimeType())) {//最近30天
			Calendar calendar=Calendar.getInstance();
			calendar.set(Calendar.HOUR, 0);
			calendar.set(Calendar.MINUTE, 0);
			calendar.set(Calendar.SECOND, 0);
			calendar.add(Calendar.MONTH, -1);
			userCurrentBo.setStartTime(calendar.getTime());
			userCurrentBo.setEndTime(new Date());
		}else if("90".equals(userCurrentBo.getTimeType())){//最近90天
			Calendar calendar=Calendar.getInstance();
			calendar.set(Calendar.HOUR, 0);
			calendar.set(Calendar.MINUTE, 0);
			calendar.set(Calendar.SECOND, 0);
			calendar.add(Calendar.MONTH, -3);
			startDate=calendar.getTime();
			userCurrentBo.setStartTime(startDate);
			userCurrentBo.setEndTime(new Date());
		}
		
		if(StringUtils.equals(userCurrentBo.getType(),"history")){
			userCurrentBo.setType("history");
			userCurrentBo.setFundStatus(new FundStatus[]{FundStatus.jieshuqi});
		}else{
			userCurrentBo.setType("current");
			userCurrentBo.setFundStatus(new FundStatus[]{FundStatus.cunxuqi,FundStatus.rengouqi});
		}
		userCurrentBo.setCompanyId(currentCompany(request));
		userCurrentBo.setUserId(principal.getId());
		PageInfo<UserBonusVo> cunxuVos=userBonusService.getUserBonus(userCurrentBo);
		modelMap.put("bo", userCurrentBo);
		modelMap.put("info", cunxuVos);
		modelMap.put("type", userCurrentBo.getType());
		return "web/user/bonus";
	}
	
	@RequestMapping("/collect")
	public String collect(HttpServletRequest request,ModelMap modelMap,String fromDate,String type){
		Principal principal=currentPrincipal(request);
		modelMap.put("user",principal);
		Date startDate=null;
		if(CommonUtils.isEmpty(fromDate)){
			startDate=null;
		}else if("1".equals(fromDate)){//最近一天
			Calendar calendar=Calendar.getInstance();
			calendar.set(Calendar.HOUR, 0);
			calendar.set(Calendar.MINUTE, 0);
			calendar.set(Calendar.SECOND, 0);
			calendar.add(Calendar.DATE, -1);
			startDate=calendar.getTime();
		}else if("7".equals(fromDate)){//最近7天
			Calendar calendar=Calendar.getInstance();
			calendar.set(Calendar.HOUR, 0);
			calendar.set(Calendar.MINUTE, 0);
			calendar.set(Calendar.SECOND, 0);
			calendar.add(Calendar.DATE, -7);
			startDate=calendar.getTime();
		}else if ("30".equals(fromDate)) {//最近30天
			Calendar calendar=Calendar.getInstance();
			calendar.set(Calendar.HOUR, 0);
			calendar.set(Calendar.MINUTE, 0);
			calendar.set(Calendar.SECOND, 0);
			calendar.add(Calendar.MONTH, -1);
			startDate=calendar.getTime();
		}else if("90".equals(fromDate)){//最近90天
			Calendar calendar=Calendar.getInstance();
			calendar.set(Calendar.HOUR, 0);
			calendar.set(Calendar.MINUTE, 0);
			calendar.set(Calendar.SECOND, 0);
			calendar.add(Calendar.MONTH, -3);
			startDate=calendar.getTime();
		}else{
			try {
				startDate=DateUtils.parseDate(fromDate, new String[]{"yyyy-MM-dd"});
			} catch (ParseException e) {
				startDate=null;
			}
		}
		UserCurrentBo userCurrentBo=new UserCurrentBo();
		userCurrentBo.setCompanyId(currentCompany(request));
		userCurrentBo.setStartTime(startDate);
		userCurrentBo.setUserId(principal.getId());
		if(StringUtils.equals(type,"history")){
			userCurrentBo.setType("history");
			userCurrentBo.setFundStatus(new FundStatus[]{FundStatus.jieshuqi});
		}else{
			userCurrentBo.setType("current");
			userCurrentBo.setFundStatus(new FundStatus[]{FundStatus.cunxuqi,FundStatus.rengouqi});
		}
		List<UserShareCunxuVo> cunxuVos=userShareService.getCunxuFromDate(userCurrentBo);
		modelMap.put("cunxus", CommonUtils.isEmpty(cunxuVos)?null:cunxuVos);
		modelMap.put("startDate", startDate);
		modelMap.put("fromDate", fromDate);
		modelMap.put("type", userCurrentBo.getType());
		return "web/user/collect";
	}
}
