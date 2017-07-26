package com.service;

import java.util.List;

import com.entity.QuestionTitle;

public interface QuestionTitleService extends BaseService<QuestionTitle>{

	List<QuestionTitle> getByQuestionId(Long id);

}
