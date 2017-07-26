package com.service;

import java.util.List;
import java.util.Map;

import com.common.Pager;
import com.entity.Dictionary;
import com.enums.DictionaryType;

public interface DictionaryService extends BaseService<Dictionary>{

	Pager<Dictionary> getList(Pager<Dictionary> pager, Dictionary dictionary);

	Dictionary getByTypeAndName(DictionaryType type, String name);

	List<Dictionary> getByType(DictionaryType userlevel);

	void initDictionary();
	
	List<Map<String,String>> getListByType(DictionaryType type);
}
