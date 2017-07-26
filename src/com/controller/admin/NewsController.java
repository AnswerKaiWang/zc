/**
 * 
 */
package com.controller.admin;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bo.NewsBo;
import com.common.Pager;
import com.controller.AdminBaseController;
import com.entity.News;
import com.service.NewsService;

/**
 * @author	tyb
 * @date	2016年9月4日下午8:40:03
 * @desc	
 */
@Controller("adminNewsController")
@RequestMapping("/admin/news")
public class NewsController extends AdminBaseController {
	
	@Autowired
	private NewsService newsService;
	
	@RequestMapping("/toList")
	public String toList(ModelMap modelMap){
		return "/cms/news/list";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public Object list(Pager<News> pager,NewsBo bo){
		return newsService.getList(pager, bo);
	}
	
	@RequestMapping("/add")
	public String add(ModelMap modelMap){
		return "/cms/news/add";
	}
	
	@RequestMapping("/save")
	@ResponseBody
	public Map<String, Object> save(News bo, ModelMap modelMap){
		Map<String, Object> map=new HashMap<>();
		newsService.save(bo);
		map.put("error","00");
		return map;
	}
	
	@RequestMapping("/edit")
	public String edit(Long id, ModelMap modelMap){
		modelMap.put("news", newsService.get(id));
		return "/cms/news/edit";
	}
	
	@RequestMapping("/update")
	@ResponseBody
	public Map<String, Object> update(News bo, ModelMap modelMap){
		Map<String, Object> map=new HashMap<>();
		News news = newsService.get(bo.getId());
		if(news == null){
			map.put("error","新闻不存在!");
			return map;
		}
		bo.setCreateTime(news.getCreateTime());
		bo.setUpdateTime(new Date());
		newsService.update(bo);
		map.put("error","00");
		return map;
	}
}
