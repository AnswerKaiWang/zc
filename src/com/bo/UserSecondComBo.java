package com.bo;

import com.enums.Status;
import com.enums.UserType;

public class UserSecondComBo extends BaseBo{
	
	private UserType userType;//客户类型
	private String userNo;//客户编号
	private Long memberId;//专属顾问
	private String name;//客户名称
	private Status status;//状态
	private Long infoSourceId;//信息来源
	private String zhizhao;
	private String faCardNo;
	private String faName;
	private String  comAddr;//地址
	public String getComAddr() {
		return comAddr;
	}
	public void setComAddr(String comAddr) {
		this.comAddr = comAddr;
	}
	public UserType getUserType() {
		return userType;
	}
	public void setUserType(UserType userType) {
		this.userType = userType;
	}
	public String getUserNo() {
		return userNo;
	}
	public void setUserNo(String userNo) {
		this.userNo = userNo;
	}
	public Long getMemberId() {
		return memberId;
	}
	public void setMemberId(Long memberId) {
		this.memberId = memberId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Status getStatus() {
		return status;
	}
	public void setStatus(Status status) {
		this.status = status;
	}
	public Long getInfoSourceId() {
		return infoSourceId;
	}
	public void setInfoSourceId(Long infoSourceId) {
		this.infoSourceId = infoSourceId;
	}
	public String getZhizhao() {
		return zhizhao;
	}
	public void setZhizhao(String zhizhao) {
		this.zhizhao = zhizhao;
	}
	public String getFaCardNo() {
		return faCardNo;
	}
	public void setFaCardNo(String faCardNo) {
		this.faCardNo = faCardNo;
	}
	public String getFaName() {
		return faName;
	}
	public void setFaName(String faName) {
		this.faName = faName;
	}
	
}
