package com.controller.admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bo.QtSurveyBo;
import com.bo.QtSurveyRecordVo;
import com.bo.QtSurveyTopicSaveBo;
import com.bo.QtSurveyTopicVo;
import com.bo.SelectResultVo;
import com.common.Pager;
import com.controller.AdminBaseController;
import com.entity.QtSurvey;
import com.entity.QtSurveyTopic;
import com.service.QtSurveyService;

/**
 * @author	tyb
 * @date	2016年9月17日上午9:26:34
 * @desc	问卷调查-目录，题目，答案，记录
 */
@Controller("adminQtSurveyController")
@RequestMapping("/admin/qtSurvey")
public class QtSurveyController extends AdminBaseController{

	@Resource
	private QtSurveyService qtSurveyServie;
	
	/**
	 * 问卷调查-跳转
	 * @param modelMap
	 * @return
	 */
	@RequestMapping("/toList")
	public String toTlist(ModelMap modelMap){
		return "/cms/qtsurvey/list";
	}
	/**
	 * 问卷调查-列表
	 * @param pager
	 * @param questionBo
	 * @return
	 */
	@RequestMapping("/list")
	@ResponseBody
	public Object tlist(Pager<QtSurvey> pager,QtSurveyBo bo){
		pager=qtSurveyServie.getList(pager,bo);
		return pager;
	}
	/**
	 * 问卷调查-添加跳转
	 * @param modelMap
	 * @return
	 */
	@RequestMapping("/add")
	public String add(ModelMap modelMap){
		return "/cms/qtsurvey/add";
	}
	/**
	 * 问卷调查-新增
	 * @param entity
	 * @return
	 */
	@RequestMapping("/save")
	@ResponseBody
	public Map<String, Object> save(QtSurvey entity){
		//同一个时间段只能有一份
		if(entity.getStartTime() == null){
			return error("开始日期必填!");
		}
		if(entity.getEndTime() == null){
			return error("结束日期必填!");
		}
		if(qtSurveyServie.repeated(entity)){
			return error("开始日期与上次的日期重叠，请重新选择日期!");
		}
		qtSurveyServie.save(entity);
		return success();
	}
	/**
	 * 问卷调查-编辑跳转
	 * @param id
	 * @param modelMap
	 * @return
	 */
	@RequestMapping("/edit")
	public String toTEdit(Long id,ModelMap modelMap){
		modelMap.put("survey", qtSurveyServie.get(id));
		return "/cms/qtsurvey/edit";
	}
	/**
	 * 问卷调查-编辑保存
	 * @param entity
	 * @return
	 */
	@RequestMapping("/update")
	@ResponseBody
	public Map<String, Object> tupdate(QtSurvey entity){
		if(entity.getStartTime() == null){
			return error("开始日期必填!");
		}
		if(entity.getEndTime() == null){
			return error("结束日期必填!");
		}
		if(qtSurveyServie.repeated(entity)){
			return error("开始日期与上次的日期重叠，请重新选择日期!");
		}
		qtSurveyServie.update(entity);
		return success();
	}
	
	/**************************************问卷调查-题目**********************************************/
	
	@RequestMapping("/searchQsList")
	@ResponseBody
	public Object searchQsList(String search){
		//查询用户，并通过姓名和账号做模糊匹配
		List<SelectResultVo> rts = qtSurveyServie.searchQsList(search);
		List<Map<String, Object>> objects=new ArrayList<>();
		for (SelectResultVo fund : rts) {
			Map<String, Object> map=new HashMap<>();
			map.put("id", fund.getId());
			map.put("text", fund.getName());
			objects.add(map);
		}
		return objects;
	}
	/**
	 * 问卷题目-列表跳转
	 * @param modelMap
	 * @return
	 */
	@RequestMapping("/topic/toList")
	public String toList(ModelMap modelMap){
		return "/cms/qtsurvey/topic/list";
	}
	/**
	 * 问卷题目-列表
	 * @param pager
	 * @param questionBo
	 * @return
	 */
	@RequestMapping("/topic/list")
	@ResponseBody
	public Object list(Pager<QtSurveyTopic> pager,QtSurveyBo bo){
		return qtSurveyServie.getTopicList(pager, bo);
	}
	
	@RequestMapping("/topic/add")
	public String add(Long qsId,ModelMap modelMap){
		modelMap.put("qsId", qsId);
		return "/cms/qtsurvey/topic/add";
	}
	
	@RequestMapping("/topic/save")
	@ResponseBody
	public Map<String, Object> save(QtSurveyTopicSaveBo bo){
		qtSurveyServie.addTopic(bo);
		return success();
	}
	
	@RequestMapping("/topic/edit")
	public String toEdit(@RequestParam Long id,ModelMap modelMap){
		if(id != null){
			modelMap.put("topic", qtSurveyServie.findDetaiById(id));
		}else{
			modelMap.put("topic", new QtSurveyTopicVo() );
		}
		return "/cms/qtsurvey/topic/edit";
	}
	
	@RequestMapping("/topic/update")
	@ResponseBody
	public Map<String, Object> update(QtSurveyTopicSaveBo bo){
		qtSurveyServie.editTopic(bo);
		return success();
	}
	
	/*****************************问卷调查-结束*****************************/
	
	
	
	@RequestMapping("/record/toList")
	public String record(ModelMap modelMap){
		return "/cms/qtsurvey/record/list";
	}
	/**
	 * 问卷调查-列表
	 * @param pager
	 * @param questionBo
	 * @return
	 */
	@RequestMapping("/record/list")
	@ResponseBody
	public Object records(Pager<QtSurveyRecordVo> pager,QtSurveyBo bo){
		pager=qtSurveyServie.getQtRecordList(pager,bo);
		return pager;
	}
}
