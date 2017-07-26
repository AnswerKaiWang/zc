/**
 * 
 */
package com.service;

import com.bo.QuestionUserBo;
import com.bo.QuestionUserVo;
import com.common.Pager;

/**
 * @author	tyb
 * @date	2016年8月27日下午9:37:23
 * @desc	
 */
public interface QuestionUserService {
	
	Pager<QuestionUserVo> getList(Pager<QuestionUserVo> pager, QuestionUserBo bo);
}
