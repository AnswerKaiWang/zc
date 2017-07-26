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

import com.bo.cura.AppointmentBo;
import com.common.Pager;
import com.controller.AdminBaseController;
import com.entity.Appointment;
import com.service.AppointmentService;
import com.service.CompanyService;

/**
 * @author	tyb
 * @date	2016年9月10日上午8:54:25
 * @desc	财富顾问预约
 */
@Controller("adminAppointmentController")
@RequestMapping("/admin/appointment")
public class AppointmenntController extends AdminBaseController {
	@Resource
	private AppointmentService appointmentService;
	@Resource
	private CompanyService companyService;
	@RequestMapping("/toList")
	public String toList(ModelMap modelMap){
//		modelMap.put("companys",companyService.getAllList());
		return "/cms/appointment/list";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public Object list(Pager<Appointment> pager,AppointmentBo bo){
		return appointmentService.getList(pager, bo);
	}
	
	@RequestMapping("/add")
	public String add(ModelMap modelMap){
		return "/cms/appointment/add";
	}
	
	@RequestMapping("/save")
	@ResponseBody
	public Map<String, Object> save(Appointment bo, ModelMap modelMap){
		Map<String, Object> map=new HashMap<>();
		appointmentService.save(bo);
		map.put("error","00");
		return map;
	}
	
	@RequestMapping("/edit")
	public String edit(Long id, ModelMap modelMap){
		modelMap.put("appointment", appointmentService.get(id));
		return "/cms/appointment/edit";
	}
	
	@RequestMapping("/update")
	@ResponseBody
	public Map<String, Object> update(Appointment bo, ModelMap modelMap){
		Map<String, Object> map=new HashMap<>();
		appointmentService.update(bo);
		map.put("error","00");
		return map;
	}
	
	@RequestMapping("/confirm")
	@ResponseBody
	public Map<String, Object> confirm(Long id,String remark, ModelMap modelMap){
		Map<String, Object> map=new HashMap<>();
		Appointment app = appointmentService.get(id);
		if(app != null){
			app.setCallbackStatus(1);
			app.setUpdateTime(new Date());
			app.setEndTime(new Date());
			app.setRemark(remark);
			appointmentService.update(app);
		}
		map.put("error","00");
		return map;
	}
}
