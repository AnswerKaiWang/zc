package com.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bo.UserBonusBo;
import com.bo.UserBonusVo;
import com.bo.UserCurrentBo;
import com.bo.cura.AppointmentQueryBo;
import com.common.Pager;
import com.entity.UserBonus;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mapper.UserBonusMapper;
import com.service.UserBonusService;

@Service("userBonusServiceImpl")
public class UserBonusServiceImpl extends BaseServiceImpl<UserBonus> implements UserBonusService{

	@Autowired
	private UserBonusMapper userBonusMapper;

	@Override
	public Pager<UserBonusVo> getList(Pager<UserBonusVo> pager, UserBonusBo userBonusBo) {
		if(pager.getUsePager()){
			PageHelper.offsetPage(pager.getOffset(), pager.getLimit());
		}
		List<UserBonusVo> members=userBonusMapper.getList(pager,userBonusBo);
		pager.setRows(members);
		PageInfo<UserBonusVo> pageInfo=new PageInfo<UserBonusVo>(members);
		pager.setTotal(pageInfo.getTotal());
		return pager;
	}

	@Override
	@Transactional
	public void saveList(List<UserBonus> userBonuss) {
		for (UserBonus userBonus : userBonuss) {
			userBonusMapper.insert(userBonus);
		}
	}

	@Override
	public PageInfo<UserBonusVo> getUserBonus(UserCurrentBo userCurrentBo) {
		PageHelper.startPage(userCurrentBo.getPage(), 10);
		List<UserBonusVo> members=userBonusMapper.getUserBonus(userCurrentBo);
		return new PageInfo<UserBonusVo>(members);
	}

	@Override
	public List<UserBonus> getCuraList(AppointmentQueryBo bo) {
		return userBonusMapper.getCuraList(bo);
	}

}
