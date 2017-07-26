/**
 * 
 */
package com.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bo.NoticeBo;
import com.common.Pager;
import com.entity.Notice;

import tk.mybatis.mapper.common.Mapper;

/**
 * @author	tyb
 * @date	2016年8月29日上午11:28:05
 * @desc	
 */
public interface NoticeMapper extends Mapper<Notice> {
	
	List<Notice> getList(@Param("pager")Pager<Notice> pager, @Param("bo") NoticeBo bo);
	
	List<Notice> getLatest();
}
