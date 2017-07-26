package com.controller.admin;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.common.Pager;
import com.controller.AdminBaseController;
import com.entity.Help;
import com.enums.FundStatus;
import com.service.CompanyService;
import com.service.HelpService;

@Controller("adminHelpController")
@RequestMapping("/admin/help")
public class HelpController extends AdminBaseController{
	
	@Resource
	private HelpService helpService;
	@Resource
	private CompanyService companyService;
	
	@RequestMapping("/toList")
	public String toList(ModelMap map){
		map.put("status", FundStatus.values());
		List<String> types=helpService.getTypeByGroup();
		map.put("types",types );
		map.put("companys",companyService.getAllList());
		return "/cms/help/list";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public Object list(Pager<Help> pager,Help help){
		pager=helpService.getList(pager,help);
		return pager;
	}
	
	@RequestMapping("/add")
	public String add(ModelMap modelMap){
		modelMap.put("companys",companyService.getAllList());
		return "/cms/help/add";
	}
	
	
	@RequestMapping("/save")
	@ResponseBody
	public Map<String, Object> save(Help help){
		Map<String, Object> map=new HashMap<>();
		help.setCreateTime(new Date());
		help.setUpdateTime(help.getCreateTime());
		helpService.save(help);
		map.put("error","00");
		return map;
	}
	
	@RequestMapping("/edit")
	public String edit(Long id,ModelMap modelMap){
		Help help=helpService.get(id);
		modelMap.put("help",help);
		modelMap.put("companys",companyService.getAllList());
		return "cms/help/edit";
	}
	
	@RequestMapping("/update")
	@ResponseBody
	public Map<String, Object> update(Help help,ModelMap modelMap){
		Map<String, Object> map=new HashMap<>();
		Help persistent=helpService.get(help.getId());
		help.setUpdateTime(new Date());
		BeanUtils.copyProperties(help, persistent, new String[]{"createTime"});
		helpService.update(persistent);
		map.put("error","00");
		return map;
	}
}
