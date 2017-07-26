package com.controller.admin;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.common.Pager;
import com.controller.AdminBaseController;
import com.entity.Permission;
import com.entity.Role;
import com.enums.Status;
import com.service.PermissionService;
import com.service.RoleService;
import com.util.JsTreeVo;
import com.util.JsonUtils;

@Controller("adminRoleController")
@RequestMapping("/admin/role")
public class RoleController extends AdminBaseController{

	@Resource
	private RoleService roleService;
	@Resource
	private PermissionService permissionService;
	
	
	@RequestMapping("/toList")
	public String toList(ModelMap modelMap){
		modelMap.put("status", Status.values());
		return "/cms/role/list";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public Object list(Pager<Role> pager,Role role){
		pager=roleService.getList(pager,role);
		return pager;
	}
	
	
	@RequestMapping("/add")
	public String add(ModelMap modelMap){
		List<Permission> permissions=permissionService.getAllList();
		List<JsTreeVo> jsTreeVos=new ArrayList<>();
		for (Permission temp : permissions) {
				if("nav".equals(temp.getGroups())&&temp.getParentId()==null){
					JsTreeVo jsTreeVo=new JsTreeVo();
					jsTreeVo.setId(temp.getId().toString());
					jsTreeVo.setText(temp.getName());
					jsTreeVo.getState().put(JsTreeVo.state_opened, true);
					jsTreeVos.add(jsTreeVo);
				}
		}
		List<JsTreeVo> vos=new ArrayList<>();
		for (JsTreeVo jsTreeVo : jsTreeVos) {
			vos.add(jsTreeVo);
			for (Permission temp : permissions) {
				if("nav".equals(temp.getGroups())&&StringUtils.equals(jsTreeVo.getId(), temp.getParentId()+"")){
					JsTreeVo t=new JsTreeVo();
					t.setId(temp.getId().toString());
					t.setText("&nbsp;&nbsp;&nbsp;&nbsp;"+temp.getName());
					t.getState().put(JsTreeVo.state_opened, true);
					vos.add(t);
				}
			}
		}
		for (Permission temp : permissions) {
			if("button".equals(temp.getGroups())){//权限
				JsTreeVo jsTreeVo=new JsTreeVo();
				jsTreeVo.setId(temp.getId().toString());
				jsTreeVo.setText(temp.getName());
				jsTreeVo.getState().put(JsTreeVo.state_opened, true);
				vos.add(jsTreeVo);
			}
		}
		modelMap.put("jsTree", JsonUtils.toJson(vos));
		modelMap.put("status", Status.values());
		return "/cms/role/add";
	}
	
	@RequestMapping("/save")
	@ResponseBody
	public Object save(Role role,Long[] permissionIds,ModelMap modelMap){
		Map<String, Object> map=new HashMap<>();
		if(permissionIds==null||permissionIds.length==0){
			map.put("error", "权限请至少选择一个");
			return map;
		}
		List<Permission> permissions=permissionService.getAllList();
		Set<Long> ids=new HashSet<>();
		for (Long pe : permissionIds) {
			Permission ss=permissionService.get(pe);
			ids.add(pe);
			for (Permission p : permissions) {
				if(p.getId().equals(ss.getParentId())){
					ids.add(p.getId());
				}
			}
		}
		roleService.save(role,ids);
		addLog("添加角色", "添加了角色名为:"+role.getName()+"的角色");
		map.put("error", "00");
		return map;
	}
	
	@RequestMapping("/edit")
	public String edit(Long roleId,ModelMap modelMap){
		Role role=roleService.get(roleId);
		List<Permission> ppp=permissionService.getPermissionByRoleId(roleId);
		List<Permission> permissions=permissionService.getAllList();
		List<JsTreeVo> jsTreeVos=new ArrayList<>();
		for (Permission temp : permissions) {
				if("nav".equals(temp.getGroups())&&temp.getParentId()==null){
					JsTreeVo jsTreeVo=new JsTreeVo();
					jsTreeVo.setId(temp.getId().toString());
					jsTreeVo.setText(temp.getName());
					jsTreeVo.getState().put(JsTreeVo.state_opened, true);
					if(ppp.contains(temp)){
						jsTreeVo.getState().put(JsTreeVo.state_selected, true);
					}
					jsTreeVos.add(jsTreeVo);
				}
		}
		List<JsTreeVo> vos=new ArrayList<>();
		for (JsTreeVo jsTreeVo : jsTreeVos) {
			vos.add(jsTreeVo);
			for (Permission temp : permissions) {
				if("nav".equals(temp.getGroups())&&StringUtils.equals(jsTreeVo.getId(), temp.getParentId()+"")){
					JsTreeVo t=new JsTreeVo();
					t.setId(temp.getId().toString());
					t.setText("&nbsp;&nbsp;&nbsp;&nbsp;"+temp.getName());
					t.getState().put(JsTreeVo.state_opened, true);
					if(ppp.contains(temp)){
						t.getState().put(JsTreeVo.state_selected, true);
					}
					vos.add(t);
				}
			}
		}
		Set<String> keys = new HashSet<>();//存放已存在的键
		int index = 1;
		for (Permission temp : permissions) {
			if("button".equals(temp.getGroups())){
				String prefix = temp.getName();
				if(prefix.indexOf("-") >-1){
					prefix = prefix.substring(0, prefix.indexOf("-"));
				}
				if(keys.contains(prefix)){
					continue;
				}
				keys.add(prefix);
				JsTreeVo jsTreeVo=new JsTreeVo();
				jsTreeVo.setId("p"+index);
				jsTreeVo.setText(prefix);
				jsTreeVo.getState().put(JsTreeVo.state_opened, true);
				jsTreeVo.setChildren(getChild(permissions, prefix, ppp));
				jsTreeVo.getState().put(JsTreeVo.state_selected, false);
//				if(ppp.contains(temp)){
//					jsTreeVo.getState().put(JsTreeVo.state_selected, true);
//				}
				vos.add(jsTreeVo);
				index++;
			}
		}
		modelMap.put("jsTree", JsonUtils.toJson(vos));
		modelMap.put("role", role);
		modelMap.put("status", Status.values());
		return "/cms/role/edit";
	}
	
	private List<JsTreeVo> getChild(List<Permission> ps,String prefix, List<Permission> ppp){
		List<JsTreeVo> child = new ArrayList<>();
		for(Permission p: ps){
			if("button".equals(p.getGroups())){
				String name = p.getName();
				if(name.startsWith(prefix)){
					if(name.indexOf("-") >-1){
						name = name.substring(name.indexOf("-")+1);
					}
					JsTreeVo jsTreeVo=new JsTreeVo();
					jsTreeVo.setId(p.getId().toString());
					jsTreeVo.setText(name);
					jsTreeVo.getState().put(JsTreeVo.state_opened, true);
					if(ppp.contains(p)){
						jsTreeVo.getState().put(JsTreeVo.state_selected, true);
					}
					child.add(jsTreeVo);
				}
			}
		}
		return child;
	}
	
	@RequestMapping("/update")
	@ResponseBody
	public Object update(Role role,Long[] permissionIds,ModelMap modelMap){
		Map<String, Object> map=new HashMap<>();
		Role persistent=roleService.get(role.getId());
		if(persistent==null){
			map.put("error", "查无原角色");
		}
		if(permissionIds==null||permissionIds.length==0){
			map.put("error", "权限请至少选择一个");
			return map;
		}
		persistent.setDescription(role.getName());
		persistent.setStatus(role.getStatus());
		persistent.setName(role.getName());
		persistent.setUpdateTime(new Date());
		List<Permission> permissions=permissionService.getAllList();
		Set<Long> ids=new HashSet<>();
		for (Long pe : permissionIds) {
			Permission ss=permissionService.get(pe);
			ids.add(pe);
			for (Permission p : permissions) {
				if(p.getId().equals(ss.getParentId())){
					ids.add(p.getId());
				}
			}
		}
		roleService.update(persistent,ids);
		addLog("修改角色", "修改了角色名为:"+role.getName()+"的角色");
		map.put("error", "00");
		return map;
	}
}
