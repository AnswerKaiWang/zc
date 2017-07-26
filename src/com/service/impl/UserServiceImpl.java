package com.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bo.UserBo;
import com.bo.UserVo;
import com.common.Pager;
import com.entity.User;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mapper.UserMapper;
import com.service.UserService;
import com.util.CommonUtils;

import tk.mybatis.mapper.entity.Example;

@Service("userServiceImpl")
public class UserServiceImpl extends BaseServiceImpl<User> implements UserService{

	@Autowired
	private UserMapper userMapper;

	@Override
	public Pager<UserVo> getList(Pager<UserVo> pager, UserBo userBo) {
		if(pager.getUsePager()){
			PageHelper.offsetPage(pager.getOffset(), pager.getLimit());
		}
		List<UserVo> members=userMapper.getList(pager,userBo);
		pager.setRows(members);
		PageInfo<UserVo> pageInfo=new PageInfo<UserVo>(members);
		pager.setTotal(pageInfo.getTotal());
		return pager;
	}

	@Override
	public List<User> getFundsByCompanyId(Long companyId) {
		Example example=new Example(User.class);
		example.createCriteria().andEqualTo("companyId", companyId);
		return userMapper.selectByExample(example);
	}

	@Override
	public User getByCardNo(String cardNo, Long companyId) {
		Example example=new Example(User.class);
		example.createCriteria().andEqualTo("cardNo", cardNo).andEqualTo("companyId", companyId);
		List<User> users=userMapper.selectByExample(example);
		return CommonUtils.isEmpty(users)?null:users.get(0);
	}

	@Override
	public User getByPhone(String phone, Long companyId) {
		Example example=new Example(User.class);
		example.createCriteria().andEqualTo("phone", phone).andEqualTo("companyId", companyId);
		List<User> users=userMapper.selectByExample(example);
		return CommonUtils.isEmpty(users)?null:users.get(0);
	}
	@Override
	public User getByEmail(String email, Long companyId) {
		Example example=new Example(User.class);
		example.createCriteria().andEqualTo("email", email).andEqualTo("companyId", companyId);
		List<User> users=userMapper.selectByExample(example);
		return CommonUtils.isEmpty(users)?null:users.get(0);
	}
	@Override
	@Transactional
	public void saveList(List<User> users) {
		for (User user : users) {
			userMapper.insert(user);
		}
	}

	@Override
	public User getByUserNo(String userNo, Long companyId) {
		Example example=new Example(User.class);
		example.createCriteria().andEqualTo("userNo", userNo).andEqualTo("companyId", companyId);
		List<User> users=userMapper.selectByExample(example);
		return CommonUtils.isEmpty(users)?null:users.get(0);
	}


	
	
}
