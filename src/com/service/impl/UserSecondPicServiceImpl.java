package com.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bo.UserSecondPicVO;
import com.entity.UserSecondPic;
import com.mapper.UserSecondPicMapper;
import com.service.UserSecondPicService;

@Service("userSecondPicServiceImpl")
public class UserSecondPicServiceImpl extends BaseServiceImpl<UserSecondPic> implements UserSecondPicService{

	@Autowired
	private UserSecondPicMapper userSecondPicMapper;

	@Override
	public UserSecondPicVO findById(Long id) {
		return userSecondPicMapper.findById(id);
	}

	@Override
	public List<UserSecondPicVO> findByCustId(Long custId) {
		return userSecondPicMapper.findByCustId(custId);
	}
}
