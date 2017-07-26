package com.service;

import java.util.List;

public interface BaseService<T> {

	 T get(Object o);
	
	 int save(T o);
	
	 int update(T o);
	 
	 List<T> getAllList();
	 
	 int delete(Object o);
}
