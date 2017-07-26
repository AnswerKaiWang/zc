package com.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.common.Pager;
import com.entity.Permission;

import tk.mybatis.mapper.common.Mapper;

public interface  PermissionMapper extends Mapper<Permission>{

	List<Permission> getPermissionByUserId(Long memberId);
	
	List<Permission> getPermissionByRoleId(Long roleId);

	List<Permission> getNav();

	List<Permission> getList(@Param("pager")Pager<Permission> pager, @Param("bo")Permission permission);
}
