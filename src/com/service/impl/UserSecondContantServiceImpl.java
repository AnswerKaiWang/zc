package com.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.entity.UserSecondContant;
import com.mapper.UserSecondContantMapper;
import com.service.UserSecondContantService;

@Service("userSecondContantServiceImpl")
public class UserSecondContantServiceImpl extends BaseServiceImpl<UserSecondContant> implements UserSecondContantService{

	@Autowired
	private UserSecondContantMapper userSecondContantMapper;

	

	
	
}
