package com.controller.admin;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.common.Pager;
import com.controller.AdminBaseController;
import com.entity.Permission;
import com.service.PermissionService;

@Controller("adminPermissionController")
@RequestMapping("/admin/permission")
public class PermissionController extends AdminBaseController{

	@Resource
	private PermissionService permissionService;
	
	@RequestMapping("/toList")
	public String toList(){
		return "/cms/permission/list";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public Object list(Pager<Permission> pager,Permission permission){
		pager=permissionService.getList(pager,permission);
		return pager;
	}
}
