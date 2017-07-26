package com.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bo.UserApplyAmountVo;
import com.bo.UserApplyBo;
import com.bo.UserApplyVo;
import com.bo.cura.AppointmentQueryBo;
import com.bo.cura.AppointmentQueryVo;
import com.bo.cura.InvestedVo;
import com.bo.cura.ProfitVo;
import com.common.Pager;
import com.entity.UserApply;

import tk.mybatis.mapper.common.Mapper;

public interface UserApplyMapper extends Mapper<UserApply>{

	List<UserApplyVo> getList(@Param("pager")Pager<UserApplyVo> pager, @Param("bo") UserApplyBo userApplyBo);
	
	
	UserApplyVo findDetailById(@Param("id") Long id);
	
	UserApplyAmountVo searchAmount(@Param("fundId") Long id);
	/**
	 * 前台预约产品查询
	 * @param bo
	 * @return
	 */
	List<AppointmentQueryVo> curaList(AppointmentQueryBo bo);
	
	/**
	 * 已投产品查询
	 * @param bo
	 * @return
	 */
	List<InvestedVo> curaInvestedList(AppointmentQueryBo bo);
	/**
	 * 在投金额
	 * @param cardNo
	 * @return
	 */
	Long curaInvestAmount(String cardNo);
	
	/**
	 * 分红查询
	 * @param bo
	 * @return
	 */
	List<ProfitVo> curaProfitList(AppointmentQueryBo bo);
	
	List<UserApplyVo> curaDetailList(AppointmentQueryBo bo);
}