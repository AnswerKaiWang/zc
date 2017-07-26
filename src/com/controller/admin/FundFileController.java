package com.controller.admin;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bo.FundFileBo;
import com.bo.FundFileVo;
import com.common.Pager;
import com.controller.AdminBaseController;
import com.entity.FundFile;
import com.enums.FundFileType;
import com.service.CompanyService;
import com.service.FundFileService;
import com.service.FundService;

@Controller("adminFundFileController")
@RequestMapping("/admin/fundFile")
public class FundFileController extends AdminBaseController{
	
	@Resource
	private FundFileService fundFileService;
	@Resource
	private FundService fundService;
	@Resource
	private CompanyService companyService;
	
	@RequestMapping("/toList")
	public String toList(ModelMap modelMap){
		modelMap.put("funds", fundService.getAllList());
		modelMap.put("companys", companyService.getAllList());
		modelMap.put("types", FundFileType.values());
		return "/cms/fundFile/list";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public Object list(Pager<FundFileVo> pager,FundFileBo fundFileBo){
		if(!isPermission("canSeeCompany")){
			fundFileBo.setCompanyId(currentCompany());
		}
		pager=fundFileService.getList(pager,fundFileBo);
		return pager;
	}
	
	
	@RequestMapping("/add")
	public String add(ModelMap modelMap){
		modelMap.put("types", FundFileType.values());
		if(!isPermission("canSeeCompany")){
			modelMap.put("funds", fundService.getFundsByCompanyId(currentCompany()));
		}else{
			modelMap.put("funds", fundService.getAllList());
		}
		return "/cms/fundFile/add";
	}
	
	
	@RequestMapping("/save")
	@ResponseBody
	public Map<String, Object> save(FundFile fundFile){
		Map<String, Object> map=new HashMap<>();
		fundFile.setCreateTime(new Date());
		fundFile.setUpdateTime(fundFile.getCreateTime());
		fundFile.setCompanyId(fundService.get(fundFile.getFundId()).getCompanyId());
		fundFileService.save(fundFile);
		map.put("error","00");
		return map;
	}
	
	@RequestMapping("/edit")
	public String edit(Long id,ModelMap modelMap){
		modelMap.put("types", FundFileType.values());
		FundFile fundFile=fundFileService.get(id);
		modelMap.put("fundFile",fundFile);
		if(!isPermission("canSeeCompany")){
			modelMap.put("funds", fundService.getFundsByCompanyId(currentCompany()));
		}else{
			modelMap.put("funds", fundService.getAllList());
		}
		return "cms/fundFile/edit";
	}
	
	@RequestMapping("/update")
	@ResponseBody
	public Map<String, Object> update(FundFile fundFile,ModelMap modelMap){
		Map<String, Object> map=new HashMap<>();
		FundFile persistent=fundFileService.get(fundFile.getId());
		fundFile.setCompanyId(fundService.get(fundFile.getFundId()).getCompanyId());
		persistent.setUpdateTime(new Date());
		BeanUtils.copyProperties(fundFile, persistent, new String[]{"createTime"});
		fundFileService.update(persistent);
		map.put("error","00");
		return map;
	}
	
	@RequestMapping("/delete")
	@ResponseBody
	public Map<String, Object> delete(Long id,ModelMap modelMap){
		Map<String, Object> map=new HashMap<>();
		int i=fundFileService.delete(id);
		if(i==1){
			map.put("error","00");
			return map;
		}
		map.put("error","删除出错,请重试");
		return map;
	}
}
