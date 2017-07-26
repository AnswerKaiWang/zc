package com.service;

import java.util.List;

import com.bo.UserSecondPicVO;
import com.entity.UserSecondPic;

public interface UserSecondPicService extends BaseService<UserSecondPic>{
	
	UserSecondPicVO findById(Long id);
	
	List<UserSecondPicVO> findByCustId(Long id);
}
