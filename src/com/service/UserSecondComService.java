package com.service;

import com.entity.UserSecondCom;

public interface UserSecondComService extends BaseService<UserSecondCom>{

	UserSecondCom getByZhizhao(String zhizhao);

}
