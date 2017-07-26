package com.service;

import java.util.List;

import com.bo.UserCurrentBo;
import com.bo.UserShareBo;
import com.bo.UserShareCunxuVo;
import com.bo.UserShareVo;
import com.bo.cura.AppointmentQueryBo;
import com.common.Pager;
import com.entity.UserShare;
import com.github.pagehelper.PageInfo;

public interface UserShareService extends BaseService<UserShare>{

	Pager<UserShareVo> getList(Pager<UserShareVo> pager, UserShareBo userShareBo);

	void saveList(List<UserShare> userShares);


	PageInfo<UserShareCunxuVo> getUserCurrent(UserCurrentBo userCurrentBo);

	List<UserShareCunxuVo> getCunxuFromDate(UserCurrentBo userCurrentBo);

	List<UserShare> getByFundIdAndUserId(Long fundId, Long userId);

	/**
	 * 已投明细查询
	 * @param cardNo
	 * @param fundId
	 * @return
	 */
	List<UserShareCunxuVo> getFundShare(AppointmentQueryBo bo);

}
