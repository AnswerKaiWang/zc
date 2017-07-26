package com.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.entity.QuestionTitle;
import com.mapper.QuestionTitleMapper;
import com.service.QuestionTitleService;

import tk.mybatis.mapper.entity.Example;


@Service("questionTitleServiceImpl")
public class QuestionTitleServiceImpl extends BaseServiceImpl<QuestionTitle> implements QuestionTitleService{

	@Autowired
	private QuestionTitleMapper questionTitleMapper;

	@Override
	public List<QuestionTitle> getByQuestionId(Long id) {
		Example example=new Example(QuestionTitle.class);
		example.createCriteria().andEqualTo("questionId", id);
		List<QuestionTitle> dictionaries=questionTitleMapper.selectByExample(example);
		return dictionaries;
	}
}
