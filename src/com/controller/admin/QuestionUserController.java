/**
 * 
 */
package com.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bo.QuestionUserBo;
import com.bo.QuestionUserVo;
import com.common.Pager;
import com.controller.AdminBaseController;
import com.service.QuestionUserService;

/**
 * @author	tyb
 * @date	2016年8月27日下午9:34:48
 * @desc	风险评估管理
 */
@Controller
@RequestMapping("/admin/questionUser")
public class QuestionUserController extends AdminBaseController {
	
	@Autowired
	private QuestionUserService questionUserService;
	
	@RequestMapping("/toList")
	public String toList(ModelMap modelMap){
		return "/cms/questionUser/list";
	}
	
	/**
	 * 列表
	 * @param pager
	 * @param bo
	 * @return
	 */
	@RequestMapping("/list")
	@ResponseBody
	public Object list(Pager<QuestionUserVo> pager,QuestionUserBo bo){
		pager=questionUserService.getList(pager,bo);
		return pager;
	}
}
