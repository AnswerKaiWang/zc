/**
 * 
 */
package com.controller.admin;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bo.FundRiskBearBo;
import com.bo.FundRiskEvaluationBo;
import com.common.Pager;
import com.controller.AdminBaseController;
import com.entity.FundRiskBear;
import com.entity.FundRiskEvaluation;
import com.enums.DictionaryType;
import com.service.DictionaryService;
import com.service.FundRiskBearService;
import com.service.FundRiskEvaluationService;

/**
 * @author	tyb
 * @date	2016年9月3日上午10:07:42
 * @desc	
 */
@Controller("adminFundRiskController")
@RequestMapping("/admin/risk")
public class FundRiskController extends AdminBaseController {
	
	@Resource
	private FundRiskBearService fundRiskBearService;
	@Resource
	private DictionaryService dictionaryService;
	@Resource
	private FundRiskEvaluationService fundRiskEvaluationService;
	
	@RequestMapping("/evaluation/toList")
	public String toEvaluationList(ModelMap modelMap){
		modelMap.put("risks", dictionaryService.getListByType(DictionaryType.fundRiskLevel));
		return "/cms/evaluation/list";
	}
	
	@RequestMapping("/evaluation/list")
	@ResponseBody
	public Object evaluationList(Pager<FundRiskEvaluation> pager,FundRiskEvaluationBo bo){
		return fundRiskEvaluationService.getList(pager, bo);
	}
	
	@RequestMapping("/evaluation/add")
	public String evaluationAdd(ModelMap modelMap){
		return "/cms/evaluation/add";
	}
	
	@RequestMapping("/evaluation/save")
	@ResponseBody
	public Map<String, Object> evaluationSave(FundRiskEvaluation bo, ModelMap modelMap){
		Map<String, Object> map=new HashMap<>();
		Date now = new Date();
		bo.setCreateTime(now);
		bo.setUpdateTime(now);
		fundRiskEvaluationService.save(bo);
		map.put("error","00");
		return map;
	}
	
	@RequestMapping("/evaluation/edit")
	public String evaluationEdit(Long id, ModelMap modelMap){
		modelMap.put("evaluation", fundRiskEvaluationService.get(id));
		return "/cms/evaluation/edit";
	}
	
	@RequestMapping("/evaluation/update")
	@ResponseBody
	public Map<String, Object> evaluationUpdate(FundRiskEvaluation bo, ModelMap modelMap){
		Map<String, Object> map=new HashMap<>();
		FundRiskEvaluation old = fundRiskEvaluationService.get(bo.getId());
		if(old == null){
			map.put("error", "数据不存在!");
			return map;
		}
		Date now = new Date();
		bo.setUpdateTime(now);
		bo.setCreateTime(old.getCreateTime());
		fundRiskEvaluationService.update(bo);
		map.put("error","00");
		return map;
	}
	
	//风险承受能力
	
	@RequestMapping("/bear/toList")
	public String toBearList(ModelMap modelMap){
		return "/cms/bear/list";
	}
	
	@RequestMapping("/bear/list")
	@ResponseBody
	public Object bearList(Pager<FundRiskBear> pager,FundRiskBearBo bo){
		return fundRiskBearService.getList(pager, bo);
	}
	
	@RequestMapping("/bear/add")
	public String bearAdd(ModelMap modelMap){
		return "/cms/bear/add";
	}
	
	@RequestMapping("/bear/save")
	@ResponseBody
	public Map<String, Object> bearSave(FundRiskBear bo, ModelMap modelMap){
		Map<String, Object> map=new HashMap<>();
		Date now = new Date();
		bo.setCreateTime(now);
		bo.setUpdateTime(now);
		fundRiskBearService.save(bo);
		map.put("error","00");
		return map;
	}
	
	@RequestMapping("/bear/edit")
	public String bearEdit(Long id, ModelMap modelMap){
		FundRiskBear bear = fundRiskBearService.get(id);
		if(bear != null && bear.getRiskId() != null){
			FundRiskEvaluation evaluation = fundRiskEvaluationService.get(bear.getRiskId());
			if(evaluation != null){
				bear.setRiskLevel(evaluation.getRiskNature());
			}
		}
		modelMap.put("bear", bear);
		return "/cms/bear/edit";
	}
	
	@RequestMapping("/bear/update")
	@ResponseBody
	public Map<String, Object> bearUpdate(FundRiskBear bo, ModelMap modelMap){
		Map<String, Object> map=new HashMap<>();
		FundRiskBear old = fundRiskBearService.get(bo.getId());
		if(old == null){
			map.put("error", "数据不存在!");
			return map;
		}
		Date now = new Date();
		bo.setUpdateTime(now);
		bo.setCreateTime(old.getCreateTime());
		fundRiskBearService.update(bo);
		map.put("error","00");
		return map;
	}
	
	
	@RequestMapping("/searchRiskList")
	@ResponseBody
	public Object searchRiskList(String search){
		//查询用户，并通过姓名和账号做模糊匹配
		List<FundRiskEvaluation> funds = fundRiskEvaluationService.getAllList();
		List<Map<String, Object>> objects=new ArrayList<>();
		for (FundRiskEvaluation fund : funds) {
			Map<String, Object> map=new HashMap<>();
			map.put("id", fund.getId());
			map.put("text", fund.getRiskNature());
			objects.add(map);
		}
		return objects;
	}
}
