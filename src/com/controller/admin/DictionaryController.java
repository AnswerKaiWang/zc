package com.controller.admin;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.common.Pager;
import com.controller.AdminBaseController;
import com.entity.Dictionary;
import com.enums.DictionaryType;
import com.service.DictionaryService;

@Controller("adminDictionaryController")
@RequestMapping("/admin/dictionary")
public class DictionaryController extends AdminBaseController{
	
	@Resource
	private DictionaryService dictionaryService;
	
	@RequestMapping("/toList")
	public String toList(ModelMap map){
		map.put("dictionaryTypes", DictionaryType.values());
		return "/cms/dictionary/list";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public Object list(Pager<Dictionary> pager,Dictionary dictionary){
		pager=dictionaryService.getList(pager,dictionary);
		return pager;
	}
	
	@RequestMapping("/add")
	public String add(ModelMap modelMap){
		modelMap.put("dictionaryTypes",DictionaryType.values());
		return "/cms/dictionary/add";
	}
	
	
	@RequestMapping("/save")
	@ResponseBody
	public Map<String, Object> save(Dictionary dictionary){
		Map<String, Object> map=new HashMap<>();
		Dictionary persistent=dictionaryService.getByTypeAndName(dictionary.getType(),dictionary.getName());
		if(persistent!=null){
			map.put("error","此类型的面已经包含:"+dictionary.getName()+",请保持唯一性");
			return map;
		}
		dictionary.setCreateTime(new Date());
		dictionary.setUpdateTime(dictionary.getCreateTime());
		dictionaryService.save(dictionary);
		dictionaryService.initDictionary();
		map.put("error","00");
		return map;
	}
	
	@RequestMapping("/edit")
	public String edit(Long id,ModelMap modelMap){
		Dictionary dictionary=dictionaryService.get(id);
		modelMap.put("dictionary",dictionary);
		modelMap.put("dictionaryTypes",DictionaryType.values());
		return "cms/dictionary/edit";
	}
	
	@RequestMapping("/update")
	@ResponseBody
	public Map<String, Object> update(Dictionary dictionary,ModelMap modelMap){
		Map<String, Object> map=new HashMap<>();
		Dictionary persistent=dictionaryService.getByTypeAndName(dictionary.getType(),dictionary.getName());
		if(persistent!=null&&!persistent.getId().equals(dictionary.getId())){
			map.put("error","此类型的面已经包含:"+dictionary.getName()+",请保持唯一性");
			return map;
		}
		persistent=dictionaryService.get(dictionary.getId());
		persistent.setUpdateTime(new Date());
		BeanUtils.copyProperties(dictionary, persistent, new String[]{"createTime"});
		dictionaryService.update(persistent);
		dictionaryService.initDictionary();
		map.put("error","00");
		return map;
	}
}
