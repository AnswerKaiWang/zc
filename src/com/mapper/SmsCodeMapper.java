package com.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bo.SmsCodeBo;
import com.entity.SmsCode;

import tk.mybatis.mapper.common.Mapper;

public interface SmsCodeMapper extends Mapper<SmsCode>{

	List<SmsCode> getByBo(@Param("bo")SmsCodeBo smsCodeBo);

	void updateStatusByBo(@Param("bo")SmsCodeBo smsCodeBo);
    
}