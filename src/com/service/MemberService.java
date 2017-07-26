package com.service;

import java.util.List;

import com.common.Pager;
import com.common.Principal;
import com.entity.Member;
import com.enums.MemberType;
import com.enums.Status;

public interface MemberService extends BaseService<Member>{

	Member getByUserName(String userName);
	
	boolean usernameExists(String username);
	
	List<String> findAuthorities(Long id);
	
	boolean isAuthenticated();

	Member getCurrent();

	String getCurrentUsername();
	
	Principal getPrincipal();

	String getIp();

	Pager<Member> getList(Pager<Member> pager, Member member);

	void save(Member sysMember, Long[] roleIds);

	void update(Member sysMember, Long[] roleIds);

	List<Member> getByMemberType(MemberType memberType, Status status);

	List<Member> searchMemberList(Long companyId, MemberType memberType, Status status, String search);
}
