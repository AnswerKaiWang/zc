package com.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.entity.UserSecondCom;
import com.mapper.UserSecondComMapper;
import com.service.UserSecondComService;
import com.util.CommonUtils;

import tk.mybatis.mapper.entity.Example;

@Service("userSecondComServiceImpl")
public class UserSecondComServiceImpl extends BaseServiceImpl<UserSecondCom> implements UserSecondComService{

	@Autowired
	private UserSecondComMapper userSecondComMapper;

	@Override
	public UserSecondCom getByZhizhao(String zhizhao) {
		Example example=new Example(UserSecondCom.class);
		example.createCriteria().andEqualTo("zhizhao", zhizhao);
		List<UserSecondCom> dictionaries=userSecondComMapper.selectByExample(example);
		return CommonUtils.isEmpty(dictionaries)?null:dictionaries.get(0);
	}

	

	
	
}
