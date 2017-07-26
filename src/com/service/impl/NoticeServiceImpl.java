/**
 * 
 */
package com.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bo.NoticeBo;
import com.common.Pager;
import com.entity.Notice;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mapper.NoticeMapper;
import com.service.NoticeService;

/**
 * @author	tyb
 * @date	2016年8月29日下午8:04:35
 * @desc	
 */
@Service("noticeService")
public class NoticeServiceImpl extends BaseServiceImpl<Notice> implements NoticeService {
	
	@Autowired
	private NoticeMapper noticeMapper;
	
	@Override
	public Pager<Notice> getList(Pager<Notice> pager, NoticeBo bo) {
		if(pager.getUsePager()){
			PageHelper.offsetPage(pager.getOffset(), pager.getLimit());
		}
		List<Notice> members=noticeMapper.getList(pager,bo);
		pager.setRows(members);
		PageInfo<Notice> pageInfo=new PageInfo<Notice>(members);
		pager.setTotal(pageInfo.getTotal());
		return pager;
	}

	@Override
	public List<Notice> getLatest() {
		return noticeMapper.getLatest();
	}
}
