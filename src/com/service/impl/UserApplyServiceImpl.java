package com.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bo.UserApplyAmountVo;
import com.bo.UserApplyBo;
import com.bo.UserApplyVo;
import com.bo.cura.AppointmentQueryBo;
import com.bo.cura.AppointmentQueryVo;
import com.bo.cura.InvestedVo;
import com.bo.cura.ProfitVo;
import com.common.Pager;
import com.entity.UserApply;
import com.entity.UserSecond;
import com.enums.DictionaryType;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mapper.DictionaryMapper;
import com.mapper.UserApplyMapper;
import com.mapper.UserSecondMapper;
import com.service.UserApplyService;
import com.util.CommonUtils;

@Service("userApplyServiceImpl")
public class UserApplyServiceImpl extends BaseServiceImpl<UserApply> implements UserApplyService{

	@Autowired
	private UserApplyMapper userApplyMapper;
	
	@Autowired
	private UserSecondMapper userSecondMapper;
	
	@Autowired
	private DictionaryMapper dictionaryMapper;
	
	
	@Override
	public Pager<UserApplyVo> getList(Pager<UserApplyVo> pager, UserApplyBo userApplyBo) {
		if(pager.getUsePager()){
			PageHelper.offsetPage(pager.getOffset(), pager.getLimit());
		}
		List<UserApplyVo> members=userApplyMapper.getList(pager,userApplyBo);
		pager.setRows(members);
		PageInfo<UserApplyVo> pageInfo=new PageInfo<UserApplyVo>(members);
		pager.setTotal(pageInfo.getTotal());
		return pager;
	}
	//1	注册客户
	//2	预约客户
	//3	认购客户
	@Override
	public void upgradeCustLevel(Long id,Long status) {
		UserSecond us = userSecondMapper.selectByPrimaryKey(id);
		if(us != null){
			Long s = us.getUserLevelId();
			if(s != null){
				if(s < status){//升级
					us.setUserLevelId(status);
					userSecondMapper.updateByPrimaryKey(us);
				}
			}else{
				us.setUserLevelId(status);
				userSecondMapper.updateByPrimaryKey(us);
			}
		}
	}

	@Override
	public UserApplyVo findDetailById(Long id) {
		return userApplyMapper.findDetailById(id);
	}

	@Override
	public UserApplyAmountVo searchAmount(Long id) {
		return userApplyMapper.searchAmount(id);
	}

	@Override
	public boolean checkAmount(UserApply apply) {
		Long id = dictionaryMapper.getIdByTypeAndName(DictionaryType.yuYueStatus.toString(), "已确认");
		if(apply.getApplyStatus().equals(String.valueOf(id))){//确认
			Long confir = apply.getConfirMoney();//确认金额
			UserApplyAmountVo amount = userApplyMapper.searchAmount(apply.getFundId());
			if(amount != null){
				Long remain = amount.getRemain();
				if(remain != null && remain >= confir){//大于等于确认金额
					return true;
				}else{
					return false;
				}
			}
		}
		return true;
	}
	
	private boolean checkConfirm(UserApply apply){
			Long confir = apply.getConfirMoney();//确认金额
			UserApplyAmountVo amount = userApplyMapper.searchAmount(apply.getFundId());
			if(amount != null){
				Long remain = amount.getRemain();
				if(remain != null && remain >= confir){//大于等于确认金额
					return true;
				}else{
					return false;
				}
			}
		return true;
	}
	
	@Override
	public boolean confirm(Long id, Long confirMoney, Long curUserId) {
		UserApply userApply=userApplyMapper.selectByPrimaryKey(id);
		if(userApply != null){
			userApply.setApplyStatus(String.valueOf(dictionaryMapper.getIdByTypeAndName(DictionaryType.yuYueStatus.toString(), "已确认")));
			userApply.setConfirUserId(curUserId);
			userApply.setConfirMoney(confirMoney);
			userApply.setUpdateTime(new Date());
			userApply.setConfirDate(new Date());
			if(!checkConfirm(userApply)){
				return false;
			}
			userApplyMapper.updateByPrimaryKey(userApply);
			//认购客户
			upgradeCustLevel(userApply.getUserSecondId(), 3L);
		}
		return true;
	}

	@Override
	public void cancel(Long id) {
		UserApply userApply=userApplyMapper.selectByPrimaryKey(id);
		if(userApply != null){
			userApply.setApplyStatus(String.valueOf(dictionaryMapper.getIdByTypeAndName(DictionaryType.yuYueStatus.toString(), "取消")));
			userApply.setConfirMoney(0L);
			userApply.setUpdateTime(new Date());
			userApplyMapper.updateByPrimaryKey(userApply);
		}
	}

	@Override
	public List<AppointmentQueryVo> curaList(AppointmentQueryBo bo) {
		bo.setStart((bo.getStart()-1)*bo.getPageSize());
		return userApplyMapper.curaList(bo);
	}

	@Override
	public List<InvestedVo> curaInvestedList(AppointmentQueryBo bo) {
		bo.setStart((bo.getStart()-1)*bo.getPageSize());
		return userApplyMapper.curaInvestedList(bo);
	}

	@Override
	public List<ProfitVo> curaProfitList(AppointmentQueryBo bo) {
		bo.setStart((bo.getStart()-1)*bo.getPageSize());
		return userApplyMapper.curaProfitList(bo);
	}

	@Override
	public String curaInvestAmount(String cardNo) {
		Long amount = userApplyMapper.curaInvestAmount(cardNo);
		if(amount != null){
			String as = String.valueOf(amount);
			int index = as.lastIndexOf("0");
			int len = as.length();
			//分、元，万元
			
			return CommonUtils.fmtW(amount);
		}
		return "0";
	}

	@Override
	public List<UserApplyVo> curaDetailList(AppointmentQueryBo bo) {
		return userApplyMapper.curaDetailList(bo);
	}
}