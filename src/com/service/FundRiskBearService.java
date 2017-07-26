/**
 * 
 */
package com.service;

import com.bo.FundRiskBearBo;
import com.common.Pager;
import com.entity.FundRiskBear;

/**
 * @author	tyb
 * @date	2016年9月3日上午10:17:07
 * @desc	
 */
public interface FundRiskBearService extends BaseService<FundRiskBear> {
	
	Pager<FundRiskBear> getList(Pager<FundRiskBear> pager,FundRiskBearBo bo);
}
