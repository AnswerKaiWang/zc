package com.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.common.Pager;
import com.entity.Role;

import tk.mybatis.mapper.common.Mapper;

public interface  RoleMapper extends Mapper<Role>{

	List<Role> getList(@Param("pager")Pager<Role> pager, @Param("bo")Role role);

	void saveRolePermission(@Param("roleId")Long roleId, @Param("permissionId")Long permissionId);

	void deleteRolePermission(Long roleId);

	List<Role> getRoleByMemberId(@Param("id")Long id);

	void saveRoleMember(@Param("roleId")Long roleId, @Param("memberId")Long memberId);

	void deleteRoleMember(Long memberId);
	
}
