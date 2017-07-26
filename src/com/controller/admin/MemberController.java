package com.controller.admin;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bo.MemberSaveBo;
import com.common.Pager;
import com.controller.AdminBaseController;
import com.entity.Member;
import com.entity.Role;
import com.enums.MemberType;
import com.enums.Status;
import com.service.CompanyService;
import com.service.MemberService;
import com.service.RoleService;
import com.util.CommonUtils;

@Controller("adminMemberController")
@RequestMapping("/admin/member")
public class MemberController extends AdminBaseController{
	@Resource
	private CompanyService companyService;
	@Resource
	private MemberService memberService;
	@Resource
	private RoleService roleService;
	
	@RequestMapping("/toList")
	public String toList(ModelMap map){
	    map.put("status", Status.values());
	    map.put("companys",companyService.getAllList());
		return "/cms/member/list";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public Object list(Pager<Member> pager,Member member){
		if(!isPermission("canSeeCompany")){
			member.setCompanyId(currentCompany());
		}
		pager=memberService.getList(pager,member);
		return pager;
	}
	
	
	@RequestMapping("/add")
	public String add(ModelMap modelMap){
		modelMap.put("status",Status.values());
		List<Role> roles=roleService.getAllList();
		List<Role> list=new ArrayList<>();
		for (Role role : roles) {
			if(Status.use.equals(role.getStatus())){
				list.add(role);
			}
		}
		modelMap.put("roles", list);
		modelMap.put("companys",companyService.getAllList());
		modelMap.put("types",MemberType.values());
		return "/cms/member/add";
	}
	
	@RequestMapping("/save")
	@ResponseBody
	public Map<String, Object> save(MemberSaveBo memberSaveBo,Long[] roleIds){
		if(!isPermission("canSeeCompany")){
			memberSaveBo.setCompanyId(currentCompany());
		}
		Map<String, Object> map=new HashMap<>();
		List<String> errors=valid(memberSaveBo);
		if(CommonUtils.isNotEmpty(errors)){
			map.put("error", errors.get(0));
			return map;
		}
		Member sysMember=memberService.getByUserName(memberSaveBo.getUserName());
		if(sysMember!=null){
			map.put("error","用户名重复,请重新填写");
			return map;
		}
		sysMember=new Member();
		BeanUtils.copyProperties(memberSaveBo, sysMember);
		sysMember.setPassword(DigestUtils.md5Hex(sysMember.getPassword()));
		sysMember.setCreateTime(new Date());
		sysMember.setUpdateTime(sysMember.getCreateTime());
		memberService.save(sysMember,roleIds);
		addLog("添加系统用户", "添加了用户名为:"+sysMember.getUserName()+"的系统用户");
		map.put("error","00");
		return map;
	}
	
	@RequestMapping("/edit")
	public String edit(Long id,ModelMap modelMap){
		List<Role> list=new ArrayList<>();
		List<Role> roles=roleService.getAllList();
		for (Role role : roles) {
			if(Status.use.equals(role.getStatus())){
				list.add(role);
			}
		}
		modelMap.put("roles", list);
		List<Role> memberRoles=roleService.getRoleByMemberId(id);
		modelMap.put("memberRoles", memberRoles);
		Member sysMember=memberService.get(id);
		modelMap.put("status",Status.values());
		modelMap.put("member",sysMember);
		modelMap.put("companys",companyService.getAllList());
		modelMap.put("types",MemberType.values());
		return "cms/member/edit";
	}
	
	@RequestMapping("/update")
	@ResponseBody
	public Map<String, Object> update(MemberSaveBo memberSaveBo,Long[] roleIds,ModelMap modelMap){
		if(!isPermission("canSeeCompany")){
			memberSaveBo.setCompanyId(currentCompany());
		}
		Map<String, Object> map=new HashMap<>();
		Member sysMember=memberService.getByUserName(memberSaveBo.getUserName());
		BeanUtils.copyProperties(memberSaveBo, sysMember, new String[]{"password","memberId","lastLoginTime","createTime"});
		if(CommonUtils.isNotEmpty(memberSaveBo.getPassword())){
			if(memberSaveBo.getPassword().length()<=5||memberSaveBo.getPassword().length()>=11){
				map.put("error","密码5到10位");
				return map;
			}
			sysMember.setPassword(DigestUtils.md5Hex(memberSaveBo.getPassword()));
		}
		sysMember.setUpdateTime(new Date());
		if(!isPermission("canGiveRole")){
			memberService.update(sysMember);
		}else{
			memberService.update(sysMember,roleIds);
		}
		addLog("修改系统用户", "修改了用户名为:"+sysMember.getUserName()+"的系统用户");
		map.put("error","00");
		return map;
	}
	
	@RequestMapping("/editLoginMember")
	public String editLoginMember(ModelMap modelMap){
		Member member=memberService.getCurrent();
		modelMap.put("member", member);
		return "/cms/editLoginUser";
	}
	
	@RequestMapping("/updateLoginMember")
	@ResponseBody
	public Map<String, Object> updateLoginMember(String email,String realName,String oldPassword,String newPassword,String reNewPassword,ModelMap modelMap){
		Map<String, Object> map=new HashMap<>();
		Member member=memberService.getCurrent();
		if(CommonUtils.isNotEmpty(newPassword)){
			if(CommonUtils.isEmpty(reNewPassword)||!StringUtils.equals(newPassword, reNewPassword)){
				map.put("error","确认新密码不正确");
				return map;
			}
			if(CommonUtils.isEmpty(oldPassword)||!DigestUtils.md5Hex(oldPassword).equals(member.getPassword())){
				map.put("error","原密码不正确");
				return map;
			}
			member.setPassword(DigestUtils.md5Hex(newPassword));
		}
		member.setEmail(email);
		member.setRealName(realName);
		memberService.update(member);
		memberService.getPrincipal().setName(realName);
		map.put("error","00");
		return map;
	}
	
	@RequestMapping("/searchMemberList")
	@ResponseBody
	public Object searchMemberList(String search, Long companyId, MemberType memberType, Status status){
		//查询用户，并通过姓名和账号做模糊匹配
		List<Member> members = memberService.searchMemberList(companyId,memberType, status, search);
		List<Map<String, Object>> objects=new ArrayList<>();
		for (Member member : members) {
			Map<String, Object> map=new HashMap<>();
			map.put("id", member.getId());
			map.put("text", member.getRealName()/*+"_"+member.getUserName()*/);
			objects.add(map);
		}
		return objects;
	}
}
