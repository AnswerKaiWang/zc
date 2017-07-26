package com.controller.admin;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bo.SysLogBo;
import com.common.Pager;
import com.controller.AdminBaseController;
import com.entity.SysLog;
import com.service.CompanyService;
import com.service.SysLogService;

@Controller("adminSysLogController")
@RequestMapping("/admin/sysLog")
public class SysLogController extends AdminBaseController{

	@Resource
	private SysLogService sysLogService;
	@Resource
	private CompanyService companyService;
	
	@RequestMapping("/toList")
	public String toList(ModelMap map){
		map.put("companys",companyService.getAllList());
		return "cms/log/list";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public Object list(Pager<SysLog> pager,SysLogBo sysLogBo){
		if(!isPermission("canSeeCompany")){
			sysLogBo.setCompanyId(currentCompany());
		}
		pager=sysLogService.getList(pager,sysLogBo);
		return pager;
	}
}
