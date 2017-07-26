/**
 * 
 */
package com.service;

import java.util.List;

import com.bo.NewsBo;
import com.bo.cura.NewsVo;
import com.common.Pager;
import com.entity.News;

/**
 * @author	tyb
 * @date	2016年9月4日下午8:46:07
 * @desc	
 */
public interface NewsService extends BaseService<News> {
	
	Pager<News> getList(Pager<News> pager, NewsBo bo);
	
	List<NewsVo> curaBannerList();
	
	List<NewsVo> curaList(String keyword,String year,Integer start,Integer pageSize,int mf);
	
	int curaCount(String keyword,String year,Integer start,Integer pageSize,int mf);
	
	List<NewsVo> curaReferList();
}
