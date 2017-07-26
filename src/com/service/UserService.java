package com.service;

import java.util.List;

import com.bo.UserBo;
import com.bo.UserVo;
import com.common.Pager;
import com.entity.User;

public interface UserService extends BaseService<User>{

	Pager<UserVo> getList(Pager<UserVo> pager, UserBo userBo);

	List<User> getFundsByCompanyId(Long companyId);

	User getByCardNo(String cardNo, Long companyId);

	User getByPhone(String phone, Long companyId);
	
	User getByEmail(String email, Long companyId);

	void saveList(List<User> users);

	User getByUserNo(String userNo, Long companyId);
}
