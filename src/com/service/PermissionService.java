package com.service;

import java.util.List;

import com.common.Pager;
import com.entity.Permission;

public interface PermissionService extends BaseService<Permission>{

	List<Permission> getNav();

	Pager<Permission> getList(Pager<Permission> pager, Permission permission);

	List<Permission> getPermissionByRoleId(Long roleId);

}
