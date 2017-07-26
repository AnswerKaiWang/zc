/**
 * 
 */
package com.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bo.QuestionUserBo;
import com.bo.QuestionUserVo;
import com.common.Pager;
import com.entity.QuestionUserRecord;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mapper.QuestionUserRecordMapper;
import com.service.QuestionUserService;

/**
 * @author	tyb
 * @date	2016年8月27日下午9:37:42
 * @desc	
 */
@Service("evaluationService")
public class QuestionUserServiceImpl extends BaseServiceImpl<QuestionUserRecord> implements QuestionUserService {
	
	@Autowired
	private QuestionUserRecordMapper questionUserRecordMapper;
	
	@Override
	public Pager<QuestionUserVo> getList(Pager<QuestionUserVo> pager, QuestionUserBo bo) {
		if(pager.getUsePager()){
			PageHelper.offsetPage(pager.getOffset(), pager.getLimit());
		}
		List<QuestionUserVo> members=questionUserRecordMapper.getList(pager,bo);
		pager.setRows(members);
		PageInfo<QuestionUserVo> pageInfo=new PageInfo<QuestionUserVo>(members);
		pager.setTotal(pageInfo.getTotal());
		return pager;
	}

}
