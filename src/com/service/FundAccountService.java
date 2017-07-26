package com.service;

import java.util.List;

import com.bo.FundAccountBo;
import com.bo.FundAccountVo;
import com.common.Pager;
import com.entity.FundAccount;

public interface FundAccountService extends BaseService<FundAccount>{

	Pager<FundAccountVo> getList(Pager<FundAccountVo> pager, FundAccountBo fundAccountBo);

	void saveList(List<FundAccount> funds);

	List<FundAccount> getFrontList(Long id);


}
