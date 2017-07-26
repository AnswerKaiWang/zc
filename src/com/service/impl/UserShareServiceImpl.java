package com.service.impl;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bo.UserCurrentBo;
import com.bo.UserShareBo;
import com.bo.UserShareCunxuVo;
import com.bo.UserShareVo;
import com.bo.cura.AppointmentQueryBo;
import com.common.Pager;
import com.entity.UserShare;
import com.enums.OrderType;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mapper.UserShareMapper;
import com.service.UserShareService;

@Service("userShareServiceImpl")
public class UserShareServiceImpl extends BaseServiceImpl<UserShare> implements UserShareService{

	@Autowired
	private UserShareMapper userShareMapper;

	@Override
	public Pager<UserShareVo> getList(Pager<UserShareVo> pager, UserShareBo userShareBo) {
		if(pager.getUsePager()){
			PageHelper.offsetPage(pager.getOffset(), pager.getLimit());
		}
		List<UserShareVo> members=userShareMapper.getList(pager,userShareBo);
		pager.setRows(members);
		PageInfo<UserShareVo> pageInfo=new PageInfo<UserShareVo>(members);
		pager.setTotal(pageInfo.getTotal());
		return pager;
	}

	@Override
	@Transactional
	public void saveList(List<UserShare> userShares) {
		for (UserShare userShare : userShares) {
			userShareMapper.insert(userShare);
		}
	}

	@Override
	public List<UserShareCunxuVo> getCunxuFromDate(UserCurrentBo userCurrentBo) {
		List<UserShareCunxuVo> cunxuVos=userShareMapper.getCunxuFromDate(userCurrentBo);
		if(cunxuVos==null) return null;
		Map<Long, UserShareCunxuVo> map=new LinkedHashMap<>();
		for (UserShareCunxuVo userShareCunxuVo : cunxuVos) {
			UserShareCunxuVo cunxuVo=map.get(userShareCunxuVo.getFundId());
			if(cunxuVo==null){
				if(OrderType.back.equals(userShareCunxuVo.getType())){
					userShareCunxuVo.setMoney(0-userShareCunxuVo.getMoney());
				}else{
					userShareCunxuVo.setMoney(userShareCunxuVo.getMoney());
				}
			}else{
				if(OrderType.back.equals(userShareCunxuVo.getType())){
					userShareCunxuVo.setMoney(cunxuVo.getMoney()-userShareCunxuVo.getMoney());
				}else{
					userShareCunxuVo.setMoney(cunxuVo.getMoney()+userShareCunxuVo.getMoney());
				}
			}
			map.put(userShareCunxuVo.getFundId(), userShareCunxuVo);
		}
		
		List<UserShareCunxuVo> t=new ArrayList<>();
		Set<Long> longs=map.keySet();
		for (Long long1 : longs) {
			t.add(map.get(long1));
		}
		return t;
	}

	@Override
	public List<UserShareCunxuVo> getFundShare(AppointmentQueryBo bo) {
		List<UserShareCunxuVo> cunxuVos=userShareMapper.getFundShare(bo);
		if(cunxuVos==null) return null;
		Map<Long, UserShareCunxuVo> map=new LinkedHashMap<>();
		for (UserShareCunxuVo userShareCunxuVo : cunxuVos) {
			UserShareCunxuVo cunxuVo=map.get(userShareCunxuVo.getFundId());
			if(cunxuVo==null){
				if(OrderType.back.equals(userShareCunxuVo.getType())){
					userShareCunxuVo.setMoney(0-userShareCunxuVo.getMoney());
				}else{
					userShareCunxuVo.setMoney(userShareCunxuVo.getMoney());
				}
			}else{
				if(OrderType.back.equals(userShareCunxuVo.getType())){
					userShareCunxuVo.setMoney(cunxuVo.getMoney()-userShareCunxuVo.getMoney());
				}else{
					userShareCunxuVo.setMoney(cunxuVo.getMoney()+userShareCunxuVo.getMoney());
				}
			}
			map.put(userShareCunxuVo.getFundId(), userShareCunxuVo);
		}
		List<UserShareCunxuVo> t=new ArrayList<>();
		Set<Long> longs=map.keySet();
		for (Long long1 : longs) {
			t.add(map.get(long1));
		}
		return t;
	}

	@Override
	public PageInfo<UserShareCunxuVo> getUserCurrent(UserCurrentBo userCurrentBo) {
		PageHelper.startPage(userCurrentBo.getPage(), 10);
		List<UserShareCunxuVo> members=userShareMapper.getUserCurrent(userCurrentBo);
		return new PageInfo<UserShareCunxuVo>(members);
	}

	@Override
	public List<UserShare> getByFundIdAndUserId(Long fundId, Long userId) {
		return userShareMapper.getByFundIdAndUserId(fundId,userId);
	}


}
