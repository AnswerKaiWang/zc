package com.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bo.UserCurrentBo;
import com.bo.UserShareBo;
import com.bo.UserShareCunxuVo;
import com.bo.UserShareVo;
import com.bo.cura.AppointmentQueryBo;
import com.common.Pager;
import com.entity.UserShare;

import tk.mybatis.mapper.common.Mapper;

public interface UserShareMapper  extends Mapper<UserShare>{

	List<UserShareVo> getList(@Param("pager")Pager<UserShareVo> pager, @Param("bo")UserShareBo userShareBo);

	List<UserShareCunxuVo> getUserCurrent(@Param("bo")UserCurrentBo userCurrentBo);

	List<UserShareCunxuVo> getCunxuFromDate(@Param("bo")UserCurrentBo userCurrentBo);

	List<UserShare> getByFundIdAndUserId(@Param("fundId")Long fundId, @Param("userId")Long userId);
	
	List<UserShareCunxuVo> getFundShare(AppointmentQueryBo bo);
   
}