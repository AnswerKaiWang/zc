package com.common;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.DisabledAccountException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;

import com.entity.Company;
import com.entity.Member;
import com.enums.Status;
import com.service.CompanyService;
import com.service.MemberService;

public class AuthenticationRealm extends AuthorizingRealm {

	@Resource
	private MemberService memberService;
	@Resource
	private CompanyService companyService;
	
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(org.apache.shiro.authc.AuthenticationToken token) {
		AuthenticationToken authenticationToken = (AuthenticationToken) token;
		String username = authenticationToken.getUsername();
		String password = new String(authenticationToken.getPassword());
		//String captchaId = authenticationToken.getCaptchaId();
		String ip = authenticationToken.getHost();
		if (username != null && password != null) {
			Member member= memberService.getByUserName(username);
			if (member == null) {
				throw new UnknownAccountException();
			}
			if (Status.finish.equals(member.getStatus())) {
				throw new DisabledAccountException();
			}
			if (authenticationToken.getPassword()==null||!DigestUtils.md5Hex(password).equals(member.getPassword())) {
				throw new IncorrectCredentialsException();
			}
			member.setLastLoginTime(new Date());
			memberService.update(member);
			Company company=null;
			if(member.getCompanyId()!=null){
				company=companyService.get(member.getCompanyId());
			}
			Principal principal=new Principal(member.getId(), username,member.getRealName(),ip,member.getCompanyId(),company==null?null:company.getName());
			return new SimpleAuthenticationInfo(principal, password, getName());
		}
		throw new UnknownAccountException();
	}

	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		Principal principal = (Principal) principals.fromRealm(getName()).iterator().next();
		if (principal != null) {
			List<String> authorities = memberService.findAuthorities(principal.getId());
			if (authorities != null) {
				SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
				authorizationInfo.addStringPermissions(authorities);
				return authorizationInfo;
			}
		}
		return null;
	}

}