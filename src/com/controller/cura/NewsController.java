/**
 * 
 */
package com.controller.cura;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Calendar;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bo.cura.ActivityPageBo;
import com.bo.cura.NewsVo;
import com.bo.cura.RespListBean;
import com.controller.CuraBaseController;
import com.service.NewsService;

/**
 * @author	tyb
 * @date	2016年8月28日下午2:46:28
 * @desc	财智资讯
 */
@Controller("curaNewsController")
@RequestMapping("/cura/news")
public class NewsController extends CuraBaseController  {
	
	@Autowired
	private NewsService newsService;
	
	/**
	 * 投资资讯列表
	 * @param model
	 * @return
	 */
	@RequestMapping
	public String list(ModelMap model){
		//banner页
		model.put("news", newsService.curaBannerList());
		return "/cura/news";
	}
	@RequestMapping("/liebiao")
	public String liebiao(String year,Integer start,Integer pageSize,String keyword,ModelMap model){
		if(year ==null){
			year = getYear(Calendar.YEAR, 0);
		}
		if(StringUtils.isNotBlank(keyword)){
			try {
				keyword = URLDecoder.decode(keyword, "UTF-8");
			} catch (UnsupportedEncodingException e) {
				//e.printStackTrace();
			}
		}
		if(start ==null) start =1;
		if(pageSize == null) pageSize =5;
		model.put("year", year);
		model.put("start", start);
		model.put("pageSize", pageSize);
		model.put("keyword", keyword);
		model.put("now", getYear(Calendar.YEAR, 0));
		model.put("pre1", getYear(Calendar.YEAR, -1));
		model.put("pre2", getYear(Calendar.YEAR, -2));
		String more = getYear(Calendar.YEAR, -3);
		model.put("pre3", more);
		int mf = 0;
		if(year.equals(more)){//常看更多
			mf = 1;
		}
		model.put("news", newsService.curaList(keyword, year, start, pageSize,mf));
		return "/cura/news_liebiao";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public RespListBean list(ActivityPageBo bo){
		int mf = 0;
		String more = getYear(Calendar.YEAR, -3);
		if(bo.getYear().equals(more)){//常看更多
			mf = 1;
		}
		if(StringUtils.isNotBlank(bo.getKeyword())){
			try {
				bo.setKeyword(URLDecoder.decode(bo.getKeyword(), "UTF-8"));
			} catch (UnsupportedEncodingException e) {
				//e.printStackTrace();
			}
		}
		int count = newsService.curaCount(bo.getKeyword(),bo.getYear(),bo.getStart(),bo.getPageSize(),mf);
		List<NewsVo> rts = newsService.curaList(bo.getKeyword(),bo.getYear(),bo.getStart(),bo.getPageSize(),mf);
		return success(count,count/bo.getPageSize() +1,rts);
	}
	
	@RequestMapping("/details")
	public String details(Long id,ModelMap model){
		model.put("news", newsService.get(id));
		model.put("refers", newsService.curaReferList());
		return "/cura/news_details";
	}
	@RequestMapping("/activity")
	public String activity(ModelMap model){
		return "/cura/news_activity";
	}
	@RequestMapping("/activity/details")
	public String actDetails(ModelMap model){
		return "/cura/newsactivity_details";
	}
}
