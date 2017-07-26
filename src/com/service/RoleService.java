package com.service;

import java.util.List;
import java.util.Set;

import com.common.Pager;
import com.entity.Role;

public interface RoleService extends BaseService<Role>{

	Pager<Role> getList(Pager<Role> pager, Role role);

	void save(Role role, Set<Long> ids);

	void update(Role persistent,Set<Long>  ids);

	List<Role> getRoleByMemberId(Long id);

}
