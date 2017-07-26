package com.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.common.Pager;
import com.entity.Role;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mapper.RoleMapper;
import com.service.RoleService;

@Service("roleServiceImpl")
public class RoleServiceImpl extends BaseServiceImpl<Role> implements RoleService{

	@Autowired
	private RoleMapper roleMapper;

	@Override
	public Pager<Role> getList(Pager<Role> pager, Role role) {
		if(pager.getUsePager()){
			PageHelper.offsetPage(pager.getOffset(), pager.getLimit());
		}
		List<Role> roles=roleMapper.getList(pager,role);
		pager.setRows(roles);
		PageInfo<Role> pageInfo=new PageInfo<Role>(roles);
		pager.setTotal(pageInfo.getTotal());
		return pager;
	}

	@Override
	@Transactional
	public void save(Role role, Set<Long>  permissionIds) {
		role.setCreateTime(new Date());
		role.setDescription(role.getName());
		role.setUpdateTime(role.getCreateTime());
		roleMapper.insert(role);
		for (Long permissionId : permissionIds) {
			roleMapper.saveRolePermission(role.getId(),permissionId);
		}
	}

	@Override
	@Transactional
	public void update(Role persistent, Set<Long> ids) {
		roleMapper.updateByPrimaryKey(persistent);
		roleMapper.deleteRolePermission(persistent.getId());
		for (Long permissionId : ids) {
			roleMapper.saveRolePermission(persistent.getId(),permissionId);
		}
	}

	@Override
	public List<Role> getRoleByMemberId(Long id) {
		return roleMapper.getRoleByMemberId(id);
	}

	

}
