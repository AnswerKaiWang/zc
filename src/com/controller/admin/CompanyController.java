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

import com.bo.CompanyAttrBo;
import com.common.Pager;
import com.controller.AdminBaseController;
import com.entity.Company;
import com.entity.CompanyAttr;
import com.service.CompanyAttrService;
import com.service.CompanyService;
import com.util.CommonUtils;

@Controller("adminCompanyController")
@RequestMapping("/admin/company")
public class CompanyController extends AdminBaseController{
	
	@Resource
	private CompanyService companyService;
	@Resource
	private CompanyAttrService companyAttrService;
	
	@RequestMapping("/toList")
	public String toList(ModelMap map){
		
		return "/cms/company/list";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public Object list(Pager<Company> pager,Company company){
		pager=companyService.getList(pager,company);
		return pager;
	}
	
	
	@RequestMapping("/add")
	public String add(ModelMap modelMap){
		return "/cms/company/add";
	}
	
	
	@RequestMapping("/save")
	@ResponseBody
	public Map<String, Object> save(Company company,CompanyAttrBo companyAttrBo){
		Map<String, Object> map=new HashMap<>();
		company.setCreateTime(new Date());
		company.setUpdateTime(company.getCreateTime());
		if(CommonUtils.isEmpty(company.getCompanyNo())){
			map.put("error","公司编号不能为空");
			return map;
		}
		Company com=companyService.getByCompanyNo(company.getCompanyNo());
		if(com!=null){
			map.put("error","公司编号已存在");
			return map;
		}
		companyService.save(company,companyAttrBo.getAt());
		map.put("error","00");
		companyAttrService.getDomain();
		addLog("添加公司", "添加了公司名为:"+company.getName()+"的公司");
		companyAttrService.getDomain();
		return map;
	}
	
	@RequestMapping("/edit")
	public String edit(Long id,ModelMap modelMap){
		Company company=companyService.get(id);
		modelMap.put("company",company);
		List<CompanyAttr> companyAttrs=companyAttrService.getByNames(company.getId(),null);
		if(CommonUtils.isNotEmpty(companyAttrs)){
			Map<String, String> map=new HashMap<>();
			for (CompanyAttr companyAttr : companyAttrs) {
				map.put(companyAttr.getName(), companyAttr.getContant());
			}
			modelMap.put("at",map);
		}
		return "cms/company/edit";
	}
	@RequestMapping("/update")
	@ResponseBody
	public Map<String, Object> update(Company company,CompanyAttrBo companyAttrBo,ModelMap modelMap){
		Map<String, Object> map=new HashMap<>();
		if(CommonUtils.isEmpty(company.getCompanyNo())){
			map.put("error","公司编号不能为空");
			return map;
		}
		Company com=companyService.getByCompanyNo(company.getCompanyNo());
		if(com!=null&&com.getId()!=company.getId()){
			map.put("error","公司编号已存在");
			return map;
		}
		Company persistent=companyService.get(company.getId());
		company.setUpdateTime(new Date());
		BeanUtils.copyProperties(company, persistent, new String[]{"createTime"});
		companyService.update(persistent,companyAttrBo.getAt());
		map.put("error","00");
		addLog("修改公司", "修改了公司名为:"+company.getName()+"的公司");
		companyAttrService.getDomain();
		return map;
	}
	@RequestMapping("/editSecurity")
	public String editSecurity(Long id,ModelMap modelMap){
		Company company=companyService.get(id);
		modelMap.put("company",company);
		List<CompanyAttr> companyAttrs=companyAttrService.getByNames(company.getId(),null);
		if(CommonUtils.isNotEmpty(companyAttrs)){
			Map<String, String> map=new HashMap<>();
			for (CompanyAttr companyAttr : companyAttrs) {
				map.put(companyAttr.getName(), companyAttr.getContant());
			}
			modelMap.put("at",map);
		}
		return "cms/company/editSecurity";
	}
	@RequestMapping("/updateSecurity")
	@ResponseBody
	public Map<String, Object> updateSecurity(Company company,String companySecurityCon1,String companySecurityCon2,String companySecurityCon3,ModelMap modelMap){
		Map<String, Object> map=new HashMap<>();
		Company persistent=companyService.get(company.getId());
		companyService.update(persistent,companySecurityCon1,companySecurityCon2,companySecurityCon3);
		map.put("error","00");
		addLog("修改公司", "修改了公司名为:"+company.getName()+"的公司的安全保障内容");
		return map;
	}
	@RequestMapping("/editCompanyEmail")
	public String editCompanyEmail(Long id,ModelMap modelMap){
		Company company=companyService.get(id);
		modelMap.put("company",company);
		List<CompanyAttr> companyAttrs=companyAttrService.getByNames(company.getId(),null);
		if(CommonUtils.isNotEmpty(companyAttrs)){
			Map<String, String> map=new HashMap<>();
			for (CompanyAttr companyAttr : companyAttrs) {
				map.put(companyAttr.getName(), companyAttr.getContant());
			}
			modelMap.put("at",map);
		}
		return "cms/company/editCompanyEmail";
	}
	
	@RequestMapping("/updateCompanyEmail")
	@ResponseBody
	public Map<String, Object> updateCompanyEmail(Company company,CompanyAttrBo companyAttrBo,ModelMap modelMap){
		Map<String, Object> map=new HashMap<>();
		Company persistent=companyService.get(company.getId());
		companyService.update(persistent,companyAttrBo.getAt());
		map.put("error","00");
		addLog("修改公司", "修改了公司名为:"+company.getName()+"的公司的发件邮箱");
		return map;
	}
	
}
