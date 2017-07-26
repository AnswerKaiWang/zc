package com.controller.admin;

import java.io.File;
import java.io.OutputStream;
import java.net.URLEncoder;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.math.NumberUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bo.ActivityBo;
import com.bo.ExpireVo;
import com.common.Pager;
import com.controller.AdminBaseController;
import com.entity.Activity;
import com.service.MemberService;
import com.service.PermissionService;
import com.service.SysConfigService;
import com.service.UserSecondService;

@Controller("adminMainController")
@RequestMapping("/admin/main")
public class MainController extends AdminBaseController{

	@Resource
	private PermissionService permissionService;
	@Resource
	private MemberService memberService;
	@Resource
	private UserSecondService userSecondService;
	@Resource
	private SysConfigService sysConfigService;//系统
	
	@RequestMapping("")
	public String main(ModelMap modelMap){
		modelMap.put("permission", permissionService.getNav());
		modelMap.put("name",memberService.getCurrent().getRealName());
		//到期提醒
		return "cms/page";
	}
	/**
	 * 首页
	 * @return
	 */
	@RequestMapping("/welcome")
	public String welcome(ModelMap model){
		String exp = sysConfigService.getCtx("expire_days");
		if(!NumberUtils.isDigits(exp)){
			exp = "5";
		}
		model.put("expireDays", Integer.valueOf(exp));
		//到期提醒
		return "cms/welcome";
	}
	/**
	 * 到期提醒
	 * @param pager
	 * @param bo
	 * @return
	 */
	@RequestMapping("/welcome/list")
	@ResponseBody
	public Object list(Pager<Activity> pager,ActivityBo bo){
		return null;
	}
	
	/**
	 * 证件到期
	 * @param pager
	 * @param bo
	 * @return
	 */
	@RequestMapping("/welcome/cert/list")
	@ResponseBody
	public Object custCert(Pager<ExpireVo> pager,Integer expireDays){
		return userSecondService.getExpriedList(pager, expireDays);
	}
	/**
	 * 风险测评到期提醒
	 * @param pager
	 * @param bo
	 * @return
	 */
	@RequestMapping("/welcome/risk/list")
	@ResponseBody
	public Object riskEvaluation(Pager<ExpireVo> pager,Integer expireDays){
		return userSecondService.getRiskExpriedList(pager,expireDays);
	}
	/**
	 * 产品纪要到期提醒
	 * @param pager
	 * @param expireDays
	 * @return
	 */
	@RequestMapping("/welcome/fund/list")
	@ResponseBody
	public Object fundRecord(Pager<ExpireVo> pager,Integer expireDays){
		return userSecondService.getFundRecordExpriedList(pager, expireDays);
	}
	
	
	 @RequestMapping(value = "/export")
	 public void export(String name,ModelMap modelMap,HttpServletResponse response) {
		    try {
		    	response.setContentType("application/octet-stream");
				response.setHeader("Content-Disposition","attachment;filename=" + URLEncoder.encode(name, "UTF-8"));
				OutputStream outputStream=response.getOutputStream();
				FileUtils.copyFile(new File(getExportPath(name)), outputStream);
				outputStream.flush();
				outputStream.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		   
	 }
	
}
