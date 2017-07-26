package com.service;

import com.bo.CustFileBo;
import com.bo.CustFileVo;
import com.bo.cura.RegBo;
import com.common.Pager;
import com.entity.UserSecondPer;

public interface UserSecondPerService extends BaseService<UserSecondPer>{

	UserSecondPer getByCardNo(String perCardNo);

	UserSecondPer getByPhone(String perPhone);

	UserSecondPer getByEmail(String perEmail);
	
	Pager<CustFileVo> getList(Pager<CustFileVo> pager, CustFileBo bo);
	
	/**
	 * 注册用户
	 * @param bo
	 */
	void curaRegUser(RegBo bo);
}
