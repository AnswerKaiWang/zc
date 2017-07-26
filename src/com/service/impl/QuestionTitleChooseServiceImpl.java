package com.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.entity.QuestionTitleChoose;
import com.mapper.QuestionTitleChooseMapper;
import com.service.QuestionTitleChooseService;

import tk.mybatis.mapper.entity.Example;

@Service("questionTitleChooseServiceImpl")
public class QuestionTitleChooseServiceImpl extends BaseServiceImpl<QuestionTitleChoose> implements QuestionTitleChooseService{

	@Autowired
	private QuestionTitleChooseMapper questionTitleChooseMapper;

	@Override
	public List<QuestionTitleChoose> getByTitleId(Long id) {
		Example example=new Example(QuestionTitleChoose.class);
		example.createCriteria().andEqualTo("titleId", id);
		List<QuestionTitleChoose> dictionaries=questionTitleChooseMapper.selectByExample(example);
		return dictionaries;
	}
}
