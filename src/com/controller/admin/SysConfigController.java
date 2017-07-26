/**
 * 
 */
package com.controller.admin;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bo.SysConfigBo;
import com.common.Pager;
import com.controller.AdminBaseController;
import com.entity.SysConfig;
import com.service.SysConfigService;

/**
 * @author	tyb
 * @date	2016年9月11日上午9:16:13
 * @desc	
 */
@Controller("adminSysConfigController")
@RequestMapping("/admin/sysConfig")
public class SysConfigController extends AdminBaseController {
	
	@Resource
	private SysConfigService sysConfigService;
	
	@RequestMapping("/toList")
	public String toList(ModelMap modelMap){
		return "/cms/sysconfig/list";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public Object list(Pager<SysConfig> pager,SysConfigBo bo){
		return sysConfigService.getList(pager, bo);
	}
	
	@RequestMapping("/add")
	public String add(ModelMap modelMap){
		return "/cms/sysconfig/add";
	}
	
	@RequestMapping("/save")
	@ResponseBody
	public Map<String, Object> save(SysConfig bo, ModelMap modelMap){
		Map<String, Object> map=new HashMap<>();
		bo.setCreateTime(new Date());
		bo.setUpdateTime(new Date());
		sysConfigService.save(bo);
		map.put("error","00");
		return map;
	}
	
	@RequestMapping("/edit")
	public String edit(Long id, ModelMap modelMap){
		modelMap.put("sysConfig", sysConfigService.get(id));
		return "/cms/sysconfig/edit";
	}
	
	@RequestMapping("/update")
	@ResponseBody
	public Map<String, Object> update(SysConfig bo, ModelMap modelMap){
		Map<String, Object> map=new HashMap<>();
		SysConfig cfg = sysConfigService.get(bo.getId());
		if(cfg != null){
			bo.setCreateTime(cfg.getCreateTime());
			bo.setUpdateTime(new Date());
			sysConfigService.update(bo);
		}
		map.put("error","00");
		return map;
	}
}
