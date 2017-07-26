package com.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.common.Pager;
import com.entity.Permission;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mapper.PermissionMapper;
import com.service.PermissionService;

@Service("permissionServiceImpl")
public class PermissionServiceImpl extends BaseServiceImpl<Permission> implements PermissionService{

	@Autowired
	private PermissionMapper permissionMapper;

	@Override
	public List<Permission> getNav() {
		return permissionMapper.getNav();
	}

	@Override
	public Pager<Permission> getList(Pager<Permission> pager, Permission permission) {
		if(pager.getUsePager()){
			PageHelper.offsetPage(pager.getOffset(), pager.getLimit());
		}
		List<Permission> permissions=permissionMapper.getList(pager,permission);
		pager.setRows(permissions);
		PageInfo<Permission> pageInfo=new PageInfo<Permission>(permissions);
		pager.setTotal(pageInfo.getTotal());
		return pager;
	}

	@Override
	public List<Permission> getPermissionByRoleId(Long roleId) {
		return permissionMapper.getPermissionByRoleId(roleId);
	}

	
}
