/**
 * 
 */
package com.controller.admin;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bo.ActivityApplyQueryBo;
import com.bo.ActivityBo;
import com.bo.ActivitySaveBo;
import com.common.Pager;
import com.controller.AdminBaseController;
import com.entity.Activity;
import com.entity.ActivityApply;
import com.service.ActivityService;

/**
 * @author	tyb
 * @date	2016年9月9日下午4:49:15
 * @desc	
 */
@Controller("adminActivityController")
@RequestMapping("/admin/activity")
public class ActivityController extends AdminBaseController {
	
	@Resource
	private ActivityService activityService;
	
	@RequestMapping("/toList")
	public String toList(ModelMap modelMap){
		return "/cms/activity/list";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public Object list(Pager<Activity> pager,ActivityBo bo){
		return activityService.getList(pager, bo);
	}
	
	@RequestMapping("/add")
	public String add(ModelMap modelMap){
		return "/cms/activity/add";
	}
	
	@RequestMapping("/save")
	@ResponseBody
	public Map<String, Object> save(ActivitySaveBo bo, ModelMap modelMap){
		activityService.save(bo);
		return success();
	}
	
	@RequestMapping("/edit")
	public String edit(Long id, ModelMap modelMap){
		modelMap.put("activity", activityService.getActivitySaveBo(id));
		return "/cms/activity/edit";
	}
	
	@RequestMapping("/update")
	@ResponseBody
	public Map<String, Object> update(ActivitySaveBo bo, ModelMap modelMap){
		activityService.update(bo);
		return success();
	}
	
	/**
	 * 报名查询
	 * @param modelMap
	 * @return
	 */
	@RequestMapping("/apply/toList")
	public String toApplyList(ModelMap modelMap){
		return "/cms/activity/apply/list";
	}
	/**
	 * 报名
	 * @param pager
	 * @param bo
	 * @return
	 */
	@RequestMapping("/apply/list")
	@ResponseBody
	public Object applyList(Pager<ActivityApply> pager,ActivityApplyQueryBo bo){
		return activityService.getList(pager, bo);
	}
}
