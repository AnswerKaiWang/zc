/**
 * 
 */
package com.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bo.NewsBo;
import com.bo.cura.NewsVo;
import com.common.Pager;
import com.entity.News;

import tk.mybatis.mapper.common.Mapper;

/**
 * @author	tyb
 * @date	2016年9月4日下午8:42:08
 * @desc	
 */
public interface NewsMapper extends Mapper<News> {
	List<News> getList(@Param("pager")Pager<News> pager, @Param("bo") NewsBo bo);
	
	List<NewsVo> curaBannerList();
	
	List<NewsVo> curaList(@Param("keyword")String keyword,@Param("year")String year,@Param("start")Integer start,@Param("pageSize")Integer pageSize,@Param("mf") int mf);
	
	
	int curaCount(@Param("keyword")String keyword,@Param("year")String year,@Param("start")Integer start,@Param("pageSize")Integer pageSize,@Param("mf") int mf);
	
	List<NewsVo> curaReferList();
}
