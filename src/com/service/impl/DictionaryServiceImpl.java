package com.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.common.Constant;
import com.common.Pager;
import com.entity.Dictionary;
import com.enums.DictionaryType;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mapper.DictionaryMapper;
import com.service.DictionaryService;
import com.util.CommonUtils;

import tk.mybatis.mapper.entity.Example;

@Service("dictionaryServiceImpl")
public class DictionaryServiceImpl extends BaseServiceImpl<Dictionary> implements DictionaryService{

	@Autowired
	private DictionaryMapper dictionaryMapper;

	@Override
	public Pager<Dictionary> getList(Pager<Dictionary> pager, Dictionary dictionary) {
		if(pager.getUsePager()){
			PageHelper.offsetPage(pager.getOffset(), pager.getLimit());
		}
		List<Dictionary> dictionaries=dictionaryMapper.getList(pager,dictionary);
		pager.setRows(dictionaries);
		PageInfo<Dictionary> pageInfo=new PageInfo<Dictionary>(dictionaries);
		pager.setTotal(pageInfo.getTotal());
		return pager;
	}

	@Override
	public Dictionary getByTypeAndName(DictionaryType type, String name) {
		Example example=new Example(Dictionary.class);
		example.createCriteria().andEqualTo("type", type).andEqualTo("name", name);
		List<Dictionary> dictionaries=dictionaryMapper.selectByExample(example);
		return CommonUtils.isEmpty(dictionaries)?null:dictionaries.get(0);
	}

	@Override
	public List<Dictionary> getByType(DictionaryType dictionaryType) {
		Example example=new Example(Dictionary.class);
		example.createCriteria().andEqualTo("type", dictionaryType);
		return dictionaryMapper.selectByExample(example);
	}

	@Override
	@Transactional
	public void initDictionary() {
		Constant.DICTIONARY_LIST=new ArrayList<>();
		Constant.DICTIONARY_MAP=new HashMap<>();
		Constant.DICTIONARY_TYPE_MAP=new HashMap<DictionaryType, List<Dictionary>>();
		Constant.DICTIONARY_LIST=dictionaryMapper.selectAll();
		for (Dictionary dictionary : Constant.DICTIONARY_LIST) {
			Constant.DICTIONARY_MAP.put(dictionary.getId(), dictionary);
			if(Constant.DICTIONARY_TYPE_MAP.get(dictionary.getType())==null){
				List<Dictionary> dictionaries=new ArrayList<>();
				dictionaries.add(dictionary);
				Constant.DICTIONARY_TYPE_MAP.put(dictionary.getType(),dictionaries);
			}else{
				Constant.DICTIONARY_TYPE_MAP.get(dictionary.getType()).add(dictionary);
			}
		}
	}

	@Override
	public List<Map<String, String>> getListByType(DictionaryType type) {
		List<Dictionary> list = getByType(type);
		List<Map<String, String>> rt = new ArrayList<>();
		if(list != null && list.size()>0){
			for(Dictionary d: list){
				Map<String,String> dd = new HashMap<>();
				dd.put("id", d.getId()+"");
				dd.put("name", d.getName());
				rt.add(dd);
			}
		}
		return rt;
	}
}
