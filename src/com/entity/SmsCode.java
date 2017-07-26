package com.entity;

import com.enums.SmsType;

public class SmsCode extends BaseEntity{
	private static final long serialVersionUID = -7481850333032091470L;
	
	private Long companyId;//公司
	
	private String code;	//验证码
	
	private SmsType smsType;//类型
	
	private Long userId;	//	用户
	
	private String toNumber;	//收信息好吗
	
	private int useStatus;//0:没用 1:用了 2:废了

	public Long getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Long companyId) {
		this.companyId = companyId;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public SmsType getSmsType() {
		return smsType;
	}

	public void setSmsType(SmsType smsType) {
		this.smsType = smsType;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public String getToNumber() {
		return toNumber;
	}

	public void setToNumber(String toNumber) {
		this.toNumber = toNumber;
	}

	public int getUseStatus() {
		return useStatus;
	}

	public void setUseStatus(int useStatus) {
		this.useStatus = useStatus;
	}
	

	

}
