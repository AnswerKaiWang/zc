package com.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.common.Pager;
import com.common.Principal;
import com.entity.Member;
import com.entity.Permission;
import com.enums.MemberType;
import com.enums.Status;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mapper.MemberMapper;
import com.mapper.PermissionMapper;
import com.mapper.RoleMapper;
import com.service.MemberService;
import com.util.CommonUtils;

import tk.mybatis.mapper.entity.Example;
import tk.mybatis.mapper.entity.Example.Criteria;

@Service("memberServiceImpl")
public class MemberServiceImpl extends BaseServiceImpl<Member> implements MemberService {


    @Autowired
    private MemberMapper memberMapper;
    @Autowired
    private PermissionMapper permissionMapper;
    @Autowired
    private RoleMapper roleMapper;

	@Override
	public Member getByUserName(String userName) {
		return memberMapper.getByUserName(userName);
	}

	@Override
	public boolean usernameExists(String username) {
		return memberMapper.getByUserName(username)!=null;
	}

	@Override
	public List<String> findAuthorities(Long id) {
		List<String> strings=new ArrayList<>();
		List<Permission> sysPermissions=permissionMapper.getPermissionByUserId(id);
		if(CommonUtils.isEmpty(sysPermissions)){
			return strings;
		}
		for (Permission sysPermission : sysPermissions) {
			strings.add(sysPermission.getValue());
		}
		return new ArrayList<String>(strings);
	}

	@Override
	public boolean isAuthenticated() {
		Subject subject = SecurityUtils.getSubject();
		if (subject != null) {
			return subject.isAuthenticated();
		}
		return false;
	}

	@Override
	public Member getCurrent() {
		Subject subject = SecurityUtils.getSubject();
		if (subject != null) {
			Principal principal = (Principal) subject.getPrincipal();
			if (principal != null) {
				return memberMapper.selectByPrimaryKey(principal.getId());
			}
		}
		return null;
	}

	@Override
	public String getCurrentUsername() {
		Subject subject = SecurityUtils.getSubject();
		if (subject != null) {
			Principal principal = (Principal) subject.getPrincipal();
			if (principal != null) {
				return principal.getUsername();
			}
		}
		return null;
	}

	@Override
	public Principal getPrincipal() {
		Subject subject = SecurityUtils.getSubject();
		if (subject != null) {
			return (Principal) subject.getPrincipal();
		}
		return null;
	}

	@Override
	public String getIp() {
		Subject subject = SecurityUtils.getSubject();
		if (subject != null&&subject.getPrincipal()!=null) {
			return ((Principal) subject.getPrincipal()).getIp();
		}
		return "";
	}

	@Override
	public Pager<Member> getList(Pager<Member> pager, Member member) {
		if(pager.getUsePager()){
			PageHelper.offsetPage(pager.getOffset(), pager.getLimit());
		}
		List<Member> members=memberMapper.getList(pager,member);
		pager.setRows(members);
		PageInfo<Member> pageInfo=new PageInfo<Member>(members);
		pager.setTotal(pageInfo.getTotal());
		return pager;
	}

	@Override
	@Transactional
	public void save(Member sysMember, Long[] roleIds) {
		memberMapper.insert(sysMember);
		if(roleIds!=null){
		for (Long long1 : roleIds) {
			roleMapper.saveRoleMember(long1, sysMember.getId());
		}
		}
	}

	@Override
	@Transactional
	public void update(Member sysMember, Long[] roleIds) {
		memberMapper.updateByPrimaryKey(sysMember);
		roleMapper.deleteRoleMember(sysMember.getId());
		if(roleIds!=null){
		for (Long long1 : roleIds) {
			roleMapper.saveRoleMember(long1, sysMember.getId());
		}
		}
	}

	@Override
	public List<Member> getByMemberType(MemberType caifuguwen, Status use) {
		Example example=new Example(Member.class);
		Criteria criteria=example.createCriteria().andEqualTo("type", caifuguwen);
		if(use!=null){
			criteria.andEqualTo("status", use);
		}
		return memberMapper.selectByExample(example);
	}

	@Override
	public List<Member> searchMemberList(Long companyId, MemberType memberType, Status status, String search) {
		Example example=new Example(Member.class);
		Criteria criteria=example.createCriteria().andEqualTo("type", memberType);
		if(status!=null){
			criteria.andEqualTo("status", status);
		}
		if(companyId!=null){
			criteria.andEqualTo("companyId", companyId);
		}
		if(CommonUtils.isNotEmpty(search)){
			criteria.andLike("realName", "%"+search+"%");
		}
		return memberMapper.selectByExample(example);
	}

    
}
