package com.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bo.ExpireVo;
import com.bo.SelectResultVo;
import com.bo.UserSecondComBo;
import com.bo.UserSecondComVo;
import com.bo.UserSecondPerBo;
import com.bo.UserSecondPerVo;
import com.bo.cura.LoginBo;
import com.bo.cura.LoginVo;
import com.common.Pager;
import com.entity.UserSecond;

import tk.mybatis.mapper.common.Mapper;

public interface UserSecondMapper extends Mapper<UserSecond>{

	List<UserSecondPerVo> getPerList(@Param("pager")Pager<UserSecondPerVo> pager, @Param("bo")UserSecondPerBo secondPerBo);

	List<UserSecondComVo> getComList(@Param("pager")Pager<UserSecondComVo> pager, @Param("bo")UserSecondComBo secondComBo);
	
	
	String getLastestMaxNo(@Param("userType") String userType);
	
	List<SelectResultVo> searchCustList(@Param("keyword") String keyword);
	
	List<LoginVo> findUserSecondCom(@Param("bo") LoginBo bo);
	List<LoginVo> findUserSecondPer(@Param("bo") LoginBo bo);
	
	String getRiskBear(@Param("riskLevel")String riskLevel);
	
	List<Integer> getCardNoCount(@Param("cardNo") String cardNo);
	
	List<Integer> getCardNoCountExclude(@Param("cardNo") String cardNo, @Param("userSecondId") Long userSecondId);
	
	void resetPwd(@Param("id")Long id, @Param("password")String password);
	
	void resetPerPhone(@Param("id")Long id, @Param("phone")String phone);
	
	void resetComPhone(@Param("id")Long id, @Param("phone")String phone);
	
	int getExistPerPhone(@Param("id")Long id, @Param("phone")String phone);
	int getExistComPhone(@Param("id")Long id, @Param("phone")String phone);
	
	void resetPerEmail(@Param("id")Long id, @Param("email")String email);
	
	void resetComEmail(@Param("id")Long id, @Param("email")String email);
	/**
	 * 
	 * @param expireDays
	 * @return
	 */
	List<ExpireVo> getExpriedList(@Param("expireDays") int expireDays);
	/**
	 * 风险测评即将到期日期
	 * @param expireDays
	 * @return
	 */
	List<ExpireVo> getRiskExpriedList(@Param("expireDays") int expireDays);
	
	List<ExpireVo> getFundRecordExpriedList(@Param("expireDays") int expireDays);
}
