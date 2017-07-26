/**
 * 
 */
package com.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bo.FundRiskBearBo;
import com.common.Pager;
import com.entity.FundRiskBear;

import tk.mybatis.mapper.common.Mapper;

/**
 * @author	tyb
 * @date	2016年9月3日上午10:14:33
 * @desc	
 */
public interface FundRiskBearMapper extends Mapper<FundRiskBear> {
	List<FundRiskBear> getList(@Param("pager")Pager<FundRiskBear> pager, @Param("bo") FundRiskBearBo bo);
}
