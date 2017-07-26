package com.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.service.BaseService;

import tk.mybatis.mapper.common.Mapper;

@Service
public abstract class BaseServiceImpl<T> implements BaseService<T>{

	@Autowired
	private Mapper<T> mapper;

	
	public Mapper<T> getMapper() {
		return mapper;
	}


	public void setMapper(Mapper<T> mapper) {
		this.mapper = mapper;
	}


	@Transactional(readOnly=true)
	public T get(Object o) {
		return mapper.selectByPrimaryKey(o);
	}
	
	@Transactional
	public int save(T o) {
		return mapper.insert(o);
	}
	
	@Transactional
	public int update(T o) {
		return mapper.updateByPrimaryKey(o);
	}
	
	@Transactional
	public List<T> getAllList() {
		return mapper.selectAll();
	}
	
	@Transactional
	public int delete(Object o) {
		return mapper.deleteByPrimaryKey(o);
	}
}
