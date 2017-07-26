/**
 * 
 */
package com.mapper;

import org.apache.ibatis.annotations.Param;

import com.entity.AgreementFile;

import tk.mybatis.mapper.common.Mapper;

/**
 * @author	tyb
 * @date	2016年8月29日下午8:39:22
 * @desc	
 */
public interface AgreementFileMapper extends Mapper<AgreementFile> {
	
	void delByAid(@Param("id") Long id);
}
