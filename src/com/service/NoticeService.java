/**
 * 
 */
package com.service;

import java.util.List;

import com.bo.NoticeBo;
import com.common.Pager;
import com.entity.Notice;

/**
 * @author	tyb
 * @date	2016年8月29日下午3:01:23
 * @desc	
 */
public interface NoticeService extends BaseService<Notice>{
	
	
	Pager<Notice> getList(Pager<Notice> pager, NoticeBo bo);
		
	List<Notice> getLatest();
}
