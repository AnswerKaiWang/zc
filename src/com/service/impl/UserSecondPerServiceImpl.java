package com.service.impl;

import java.util.Date;
import java.util.List;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bo.CustFileBo;
import com.bo.CustFileVo;
import com.bo.cura.RegBo;
import com.common.Pager;
import com.entity.UserSecond;
import com.entity.UserSecondPer;
import com.enums.Status;
import com.enums.UserType;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mapper.UserSecondMapper;
import com.mapper.UserSecondPerMapper;
import com.service.UserSecondPerService;
import com.util.CommonUtils;

import tk.mybatis.mapper.entity.Example;

@Service("userSecondPerServiceImpl")
public class UserSecondPerServiceImpl extends BaseServiceImpl<UserSecondPer> implements UserSecondPerService{

	@Autowired
	private UserSecondPerMapper userSecondPerMapper;
	
	@Autowired
	private UserSecondMapper userSecondMapper;
	
	
	
	@Override
	public UserSecondPer getByCardNo(String perCardNo) {
		Example example=new Example(UserSecondPer.class);
		example.createCriteria().andEqualTo("perCardNo", perCardNo);
		List<UserSecondPer> dictionaries=userSecondPerMapper.selectByExample(example);
		return CommonUtils.isEmpty(dictionaries)?null:dictionaries.get(0);
	}

	@Override
	public UserSecondPer getByPhone(String perPhone) {
		Example example=new Example(UserSecondPer.class);
		example.createCriteria().andEqualTo("perPhone", perPhone);
		List<UserSecondPer> dictionaries=userSecondPerMapper.selectByExample(example);
		return CommonUtils.isEmpty(dictionaries)?null:dictionaries.get(0);
	}

	@Override
	public UserSecondPer getByEmail(String perEmail) {
		Example example=new Example(UserSecondPer.class);
		example.createCriteria().andEqualTo("perEmail", perEmail);
		List<UserSecondPer> dictionaries=userSecondPerMapper.selectByExample(example);
		return CommonUtils.isEmpty(dictionaries)?null:dictionaries.get(0);
	}

	@Override
	public Pager<CustFileVo> getList(Pager<CustFileVo> pager, CustFileBo bo) {
		if(pager.getUsePager()){
			PageHelper.offsetPage(pager.getOffset(), pager.getLimit());
		}
		List<CustFileVo> members=userSecondPerMapper.getList(pager,bo);
		pager.setRows(members);
		PageInfo<CustFileVo> pageInfo=new PageInfo<CustFileVo>(members);
		pager.setTotal(pageInfo.getTotal());
		return pager;
	}

	@Override
	@Transactional(readOnly=false)
	public void curaRegUser(RegBo bo) {
		UserSecond second = new UserSecond();
		Date now = new Date();
		second.setCreateTime(now);
		second.setUpdateTime(now);
		second.setCustomerSourceId(6L);//客户注册
		second.setInfoSourceId(5L);
		second.setName(bo.getName());
		second.setPassword(DigestUtils.md5Hex(bo.getPassword()));
		second.setStatus(Status.use);
		second.setUserType(UserType.geren);
		second.setUserNo(bo.getUserNo());
		userSecondMapper.insert(second);
		UserSecondPer per = new UserSecondPer();
		per.setId(second.getId());
		per.setPerAddr(bo.getAddress());
		if(StringUtils.isNotBlank(bo.getBirth())){
			//per.setPerBirthday(new Date(bo.getBirth()));
		}
		//per.setPerCardNo(perCardNo);
		if(bo.getCity() != null){
			per.setPerCityId(Long.valueOf(bo.getCity()));
		}
		per.setPerEmail(bo.getEmail());
		per.setPerName(bo.getName());
		per.setPerPhone(bo.getPhone());
		per.setPerSex(bo.getGender());
		userSecondPerMapper.insert(per);
		
		bo.setUserId(second.getId());
	}
}
