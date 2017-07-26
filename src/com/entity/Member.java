package com.entity;

import java.util.Date;

import com.enums.MemberType;
import com.enums.Status;

/**
 * 系统用户
 * @author syblike
 *
 */
public class Member extends BaseEntity{
	
	private static final long serialVersionUID = -713097482977332096L;

    private String userName;//用户名 建议是电话

    private String password;//密码
    
    private String email;//邮箱
    
    private String realName;//真实姓名

    private Boolean sex;//性别

    private Status status;//状态

    private Date lastLoginTime;//最后登录时间

    private Long companyId;//公司编号
    
    private MemberType type;
    /**
     * 手机
     */
    private String phone;
    
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public Boolean getSex() {
		return sex;
	}

	public void setSex(Boolean sex) {
		this.sex = sex;
	}

	public Status getStatus() {
		return status;
	}

	public void setStatus(Status status) {
		this.status = status;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getLastLoginTime() {
		return lastLoginTime;
	}

	public void setLastLoginTime(Date lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}

	public Long getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Long companyId) {
		this.companyId = companyId;
	}

	public MemberType getType() {
		return type;
	}

	public void setType(MemberType type) {
		this.type = type;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
}