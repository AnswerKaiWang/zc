package com.entity;

/**
 * 日志
 * @author 
 *
 */
public class SysLog extends BaseEntity{
	public static final String SYS_LOGS="sys_log_list";
	
	private static final long serialVersionUID = -2742839426096023452L;

    private String name;//名称

    private String ip;//ip

    private String memberName;//用户名

    private Long memberId;//id

    private String contant;//内容
    
    private Long companyId;
    
    private String companyName;
    
    public SysLog() {
    }
    public SysLog(String name,String contant){
    	this.name=name;
    	this.contant=contant;
    }

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public Long getMemberId() {
		return memberId;
	}

	public void setMemberId(Long memberId) {
		this.memberId = memberId;
	}

	public String getContant() {
		return contant;
	}

	public void setContant(String contant) {
		this.contant = contant;
	}
	public Long getCompanyId() {
		return companyId;
	}
	public void setCompanyId(Long companyId) {
		this.companyId = companyId;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

   
}