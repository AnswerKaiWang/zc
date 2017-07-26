package com.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bo.UserBonusBo;
import com.bo.UserBonusVo;
import com.bo.UserCurrentBo;
import com.bo.cura.AppointmentQueryBo;
import com.common.Pager;
import com.entity.UserBonus;

import tk.mybatis.mapper.common.Mapper;

public interface UserBonusMapper  extends Mapper<UserBonus>{

	List<UserBonusVo> getList(@Param("pager")Pager<UserBonusVo> pager, @Param("bo")UserBonusBo userBonusBo);

	List<UserBonusVo> getUserBonus(@Param("bo")UserCurrentBo userCurrentBo);
	
	
	List<UserBonus> getCuraList(@Param("bo") AppointmentQueryBo bo);
   
}