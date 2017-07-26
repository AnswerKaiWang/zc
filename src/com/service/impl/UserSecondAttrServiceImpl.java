package com.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.entity.UserSecondAttr;
import com.mapper.UserSecondAttrMapper;
import com.service.UserSecondAttrService;

@Service("userSecondAttrServiceImpl")
public class UserSecondAttrServiceImpl extends BaseServiceImpl<UserSecondAttr> implements UserSecondAttrService{

	@Autowired
	private UserSecondAttrMapper userSecondAttrMapper;

	

	
	
}
