package com.service;

import java.util.List;

import com.entity.QuestionTitleChoose;

public interface QuestionTitleChooseService extends BaseService<QuestionTitleChoose>{

	List<QuestionTitleChoose> getByTitleId(Long id);

}
