/**
 * 
 */
package com.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bo.AgreementBo;
import com.bo.AgreementVo;
import com.common.Pager;
import com.entity.Agreement;

import tk.mybatis.mapper.common.Mapper;

/**
 * @author	tyb
 * @date	2016年8月29日上午11:28:05
 * @desc	
 */
public interface AgreementMapper extends Mapper<Agreement> {
	
	List<AgreementVo> getList(@Param("pager")Pager<AgreementVo> pager, @Param("bo") AgreementBo bo);
	
	AgreementVo findDetailById(@Param("id") Long id);
}
