package com.controller.admin;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bo.AgreementAddBo;
import com.bo.AgreementBo;
import com.bo.AgreementVo;
import com.common.Pager;
import com.controller.AdminBaseController;
import com.service.AgreementService;
import com.service.CompanyService;

@Controller("adminAgreementController")
@RequestMapping("/admin/agreement")
public class AgreementController extends AdminBaseController{

	@Resource
	private AgreementService agreementService;
	@Resource
	private CompanyService companyService;
	
	@RequestMapping("/toList")
	public String toList(ModelMap modelMap){
		modelMap.put("companys",companyService.getAllList());
		return "/cms/agreement/list";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public Object list(Pager<AgreementVo> pager,AgreementBo bo){
		return agreementService.getList(pager, bo);
	}
	
	@RequestMapping("/add")
	public String add(ModelMap modelMap){
		return "/cms/agreement/add";
	}
	
	@RequestMapping("/save")
	@ResponseBody
	public Map<String, Object> save(AgreementAddBo bo, ModelMap modelMap){
		Map<String, Object> map=new HashMap<>();
		agreementService.saveAgreement(bo);
		map.put("error","00");
		return map;
	}
	
	@RequestMapping("/edit")
	public String edit(Long id, ModelMap modelMap){
		modelMap.put("agreement", agreementService.findDetailById(id));
		return "/cms/agreement/edit";
	}
	
	@RequestMapping("/update")
	@ResponseBody
	public Map<String, Object> update(AgreementAddBo bo, ModelMap modelMap){
		Map<String, Object> map=new HashMap<>();
		agreementService.updateAgreement(bo);
		map.put("error","00");
		return map;
	}
}
