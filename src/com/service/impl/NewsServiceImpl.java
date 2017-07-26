/**
 * 
 */
package com.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bo.NewsBo;
import com.bo.cura.NewsVo;
import com.common.Pager;
import com.entity.News;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mapper.NewsMapper;
import com.service.NewsService;

/**
 * @author	tyb
 * @date	2016年9月4日下午8:46:37
 * @desc	
 */
@Service("newsService")
public class NewsServiceImpl extends BaseServiceImpl<News> implements NewsService {
	
	@Autowired
	private NewsMapper newsMapper;

	@Override
	public Pager<News> getList(Pager<News> pager, NewsBo bo) {
		if(pager.getUsePager()){
			PageHelper.offsetPage(pager.getOffset(), pager.getLimit());
		}
		List<News> members=newsMapper.getList(pager,bo);
		pager.setRows(members);
		PageInfo<News> pageInfo=new PageInfo<News>(members);
		pager.setTotal(pageInfo.getTotal());
		return pager;
	}

	@Override
	public List<NewsVo> curaBannerList() {
		return newsMapper.curaBannerList();
	}

	@Override
	public List<NewsVo> curaList(String keyword, String year, Integer start, Integer pageSize,int mf) {
		start = (start-1)*pageSize;
		return newsMapper.curaList(keyword, year, start, pageSize,mf);
	}

	@Override
	public int curaCount(String keyword, String year, Integer start, Integer pageSize, int mf) {
		return newsMapper.curaCount(keyword, year, start, pageSize, mf);
	}

	@Override
	public List<NewsVo> curaReferList() {
		return newsMapper.curaReferList();
	}
	
}
