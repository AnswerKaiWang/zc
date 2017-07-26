package com.service;

import java.util.List;

import com.bo.UserApplyAmountVo;
import com.bo.UserApplyBo;
import com.bo.UserApplyVo;
import com.bo.cura.AppointmentQueryBo;
import com.bo.cura.AppointmentQueryVo;
import com.bo.cura.InvestedVo;
import com.bo.cura.ProfitVo;
import com.common.Pager;
import com.entity.UserApply;

public interface UserApplyService extends BaseService<UserApply>{
	
	Pager<UserApplyVo> getList(Pager<UserApplyVo> pager, UserApplyBo userApplyBo);
	
	UserApplyVo findDetailById(Long id);
	/**
	 * 更新客户等级
	 * @param id
	 * @param status
	 */
	void upgradeCustLevel(Long id,Long status);
	
	UserApplyAmountVo searchAmount(Long id);
	/**
	 * 确认金额是否合理
	 * @param apply
	 * @return
	 */
	boolean checkAmount(UserApply apply);
	/**
	 * 确认
	 * @param id
	 * @param confirMoney
	 * @param curUserId
	 * @return
	 */
	boolean confirm(Long id, Long confirMoney, Long curUserId);
	
	/**
	 * 取消
	 * @param id
	 */
	void cancel(Long id);
	
	/**
	 * 预约查询
	 * @param bo
	 * @return
	 */
	List<AppointmentQueryVo> curaList(AppointmentQueryBo bo);
	/**
	 * 预约明细查询
	 * @param bo
	 * @return
	 */
	List<UserApplyVo> curaDetailList(AppointmentQueryBo bo);
	
	/**
	 * 已投产品查询
	 * @param bo
	 * @return
	 */
	List<InvestedVo> curaInvestedList(AppointmentQueryBo bo);
	/**
	 * 分红查询
	 * @param bo
	 * @return
	 */
	List<ProfitVo> curaProfitList(AppointmentQueryBo bo);
	/**
	 * 在投金额
	 * @param cardNo
	 * @return
	 */
	String curaInvestAmount(String cardNo);
}
