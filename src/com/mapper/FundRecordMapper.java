/**
 * 
 */
package com.mapper;

import org.apache.ibatis.annotations.Param;

import com.entity.FundRecord;

import tk.mybatis.mapper.common.BaseMapper;

/**
 * @author	tyb
 * @date	2016年8月26日下午9:01:52
 * @desc	
 */
public interface FundRecordMapper extends BaseMapper<FundRecord> {
	
	void delByFundId(@Param("id") Long id);
}
