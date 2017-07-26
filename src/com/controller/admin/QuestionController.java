package com.controller.admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bo.QuestionAddBo;
import com.bo.QuestionBo;
import com.bo.QuestionTimeBo;
import com.bo.SelectResultVo;
import com.common.Pager;
import com.controller.AdminBaseController;
import com.entity.Question;
import com.entity.QuestionTime;
import com.enums.DictionaryType;
import com.service.DictionaryService;
import com.service.QuestionService;
import com.service.QuestionTitleChooseService;
import com.service.QuestionTitleService;


@Controller("adminQuestionController")
@RequestMapping("/admin/question")
public class QuestionController extends AdminBaseController{

	@Resource
	private QuestionService questionService;
	@Resource
	private QuestionTitleService questionTitleService;
	@Resource
	private QuestionTitleChooseService questionTitleChooseService;
	@Resource
	private DictionaryService dictionaryService;
	
	//风险测评大类  名称，时段
	@RequestMapping("/toTlist")
	public String toTlist(ModelMap modelMap){
		return "/cms/question/tlist";
	}
	
	@RequestMapping("/tlist")
	@ResponseBody
	public Object tlist(Pager<QuestionTime> pager,QuestionTimeBo questionBo){
		pager=questionService.getTList(pager,questionBo);
		return pager;
	}
	
	@RequestMapping("/tadd")
	public String tadd(ModelMap modelMap){
		return "/cms/question/tadd";
	}
	
	@RequestMapping("/tsave")
	@ResponseBody
	public Map<String, Object> tsave(QuestionTime bo){
		Map<String, Object> map=new HashMap<>();
		questionService.addQuestionTime(bo);;
		map.put("error","00");
		return map;
	}
	
	@RequestMapping("/toTEdit")
	public String toTEdit(Long id,ModelMap modelMap){
		modelMap.put("question", questionService.getQT(id));
		return "/cms/question/tedit";
	}
	
	@RequestMapping("/tupdate")
	@ResponseBody
	public Map<String, Object> tupdate(QuestionTime bo){
		Map<String, Object> map=new HashMap<>();
		questionService.editQuestionTime(bo);
		map.put("error","00");
		return map;
	}
	
	@RequestMapping("/searchQuestionList")
	@ResponseBody
	public Object searchQuestionList(String search){
		//查询用户，并通过姓名和账号做模糊匹配
		List<SelectResultVo> rts = questionService.searchQuestionList(search);
		List<Map<String, Object>> objects=new ArrayList<>();
		for (SelectResultVo fund : rts) {
			Map<String, Object> map=new HashMap<>();
			map.put("id", fund.getId());
			map.put("text", fund.getName());
			objects.add(map);
		}
		return objects;
	}
	
	//测评小类
	
	
	@RequestMapping("/toList")
	public String toList(ModelMap modelMap){
		modelMap.put("questionTypes", dictionaryService.getListByType(DictionaryType.questionType));
		return "/cms/question/list";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public Object list(Pager<Question> pager,QuestionBo questionBo){
		pager=questionService.getList(pager,questionBo);
		return pager;
	}
	
	@RequestMapping("/add")
	public String add(Long qtId,ModelMap modelMap){
		modelMap.put("qtId", qtId);
		return "/cms/question/add";
	}
	
	@RequestMapping("/save")
	@ResponseBody
	public Map<String, Object> save(QuestionAddBo bo){
		Map<String, Object> map=new HashMap<>();
		questionService.saveQuestion(bo);
		map.put("error","00");
		return map;
	}
	
	@RequestMapping("/toEdit")
	public String toEdit(Long id,Long qtId,ModelMap modelMap){
		modelMap.put("qtId", qtId);
		modelMap.put("question", questionService.findDetailById(id));
		return "/cms/question/edit";
	}
	
	@RequestMapping("/update")
	@ResponseBody
	public Map<String, Object> update(QuestionAddBo bo){
		Map<String, Object> map=new HashMap<>();
		Question persistent=questionService.get(bo.getId());
		bo.setCreateTime(persistent.getCreateTime());
		questionService.updateQuestion(bo);
		map.put("error","00");
		return map;
	}
	
	@RequestMapping("/his")
	public String toHis(Long quId, ModelMap model){
		model.put("his", questionService.getQHis(quId));
		return "/cms/questionUser/history";
	}
}
