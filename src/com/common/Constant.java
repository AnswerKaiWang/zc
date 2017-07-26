package com.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.entity.CompanyAttr;
import com.entity.Dictionary;
import com.entity.Permission;
import com.enums.DictionaryType;

public class Constant {
	//左边树
	public static List<Permission> BASIC_NAV_LIST=new ArrayList<>();
	
	public static Map<String, CompanyAttr> COMPANY=new HashMap<>();
	
	public static List<Dictionary> DICTIONARY_LIST=new ArrayList<>();
	
	public static Map<DictionaryType,List<Dictionary>> DICTIONARY_TYPE_MAP=new HashMap<>();
	
	public static Map<Long, Dictionary> DICTIONARY_MAP=new HashMap<>();
	
}
