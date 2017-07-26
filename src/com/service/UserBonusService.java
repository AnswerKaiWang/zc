package com.service;

import java.util.List;

import com.bo.UserBonusBo;
import com.bo.UserBonusVo;
import com.bo.UserCurrentBo;
import com.bo.cura.AppointmentQueryBo;
import com.common.Pager;
import com.entity.UserBonus;
import com.github.pagehelper.PageInfo;

public interface UserBonusService extends BaseService<UserBonus>{

	Pager<UserBonusVo> getList(Pager<UserBonusVo> pager, UserBonusBo userBonusBo);

	void saveList(List<UserBonus> userBonuss);

	PageInfo<UserBonusVo> getUserBonus(UserCurrentBo userCurrentBo);


	/**
	 * 分红查询-详细
	 * @param bo
	 * @return
	 */
	List<UserBonus> getCuraList(AppointmentQueryBo bo);
}
