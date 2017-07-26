package com.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bo.SmsCodeBo;
import com.entity.SmsCode;
import com.mapper.SmsCodeMapper;
import com.service.SmsCodeService;

@Service("smsCodeServiceImpl")
public class SmsCodeServiceImpl extends BaseServiceImpl<SmsCode> implements SmsCodeService{

	@Autowired
	private SmsCodeMapper smsCodeMapper;

	@Override
	public List<SmsCode> getByBo(SmsCodeBo smsCodeBo) {
		return smsCodeMapper.getByBo(smsCodeBo);
	}

	@Override
	@Transactional
	public void saveAndUpdate(SmsCode smsCode) {
		SmsCodeBo smsCodeBo=new SmsCodeBo();
		smsCodeBo.setUserId(smsCode.getUserId());
		smsCodeBo.setSmsType(smsCode.getSmsType());
		smsCodeMapper.updateStatusByBo(smsCodeBo);
		smsCodeMapper.insert(smsCode);
	}

	
	
	
}
