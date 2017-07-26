package com.service;

import java.util.List;

import com.bo.SmsCodeBo;
import com.entity.SmsCode;

public interface SmsCodeService extends BaseService<SmsCode>{

	List<SmsCode> getByBo(SmsCodeBo smsCodeBo);

	void saveAndUpdate(SmsCode smsCode);

}
