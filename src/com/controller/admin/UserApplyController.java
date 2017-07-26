package com.controller.admin;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bo.UserApplyAmountVo;
import com.bo.UserApplyBo;
import com.bo.UserApplyVo;
import com.common.Pager;
import com.controller.AdminBaseController;
import com.entity.Member;
import com.entity.UserApply;
import com.enums.DictionaryType;
import com.enums.MemberType;
import com.enums.Status;
import com.service.DictionaryService;
import com.service.FundApplyService;
import com.service.FundService;
import com.service.UserApplyService;
import com.service.UserSecondService;
import com.service.UserService;

@Controller("adminUserApplyController")
@RequestMapping("/admin/userApply")
public class UserApplyController extends AdminBaseController{
	
	@Resource
	private UserService userService;
	@Resource
	private UserApplyService userApplyService;
	@Resource
	private FundService fundService;
	@Resource
	private FundApplyService fundApplyService;
	@Resource
	private DictionaryService dictionaryService;
	
	@Resource
	private UserSecondService userSecondService;
	
	@RequestMapping("/toList")
	public String toList(ModelMap map){
		map.put("funds", fundService.getAllList());
		map.addAttribute("applyTypes", dictionaryService.getListByType(DictionaryType.yuYueType));
		map.addAttribute("applyStatus", dictionaryService.getListByType(DictionaryType.yuYueStatus));

		return "/cms/userApply/list";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public Object list(Pager<UserApplyVo> pager,UserApplyBo userApplyBo,ModelMap map){
		//预约管理分权限
		Member m = getCurrentMember();
		if(m != null && m.getType() != null){
			if(m.getType().toString().equals(MemberType.caifuguwen.toString())){
				userApplyBo.setMemberId(m.getId());
			}
		}
		pager=userApplyService.getList(pager,userApplyBo);
		return pager;
	}
	
	@RequestMapping("/toList2")
	public String toList2(ModelMap map){
		map.put("funds", fundService.getAllList());
		map.addAttribute("applyTypes", dictionaryService.getListByType(DictionaryType.yuYueType));
		map.addAttribute("applyStatus", dictionaryService.getListByType(DictionaryType.yuYueStatus));
		return "/cms/userApply/list2";
	}
	
	@RequestMapping("/list2")
	@ResponseBody
	public Object list2(Pager<UserApplyVo> pager,UserApplyBo userApplyBo,ModelMap map){
		Member m = getCurrentMember();
		if(m != null && m.getType() != null){
			if(m.getType().toString().equals(MemberType.caifuguwen.toString())){
				userApplyBo.setMemberId(m.getId());
			}
		}
		pager=userApplyService.getList(pager,userApplyBo);
		return pager;
	}
	
	@RequestMapping("/add")
	public String add(ModelMap modelMap){
		modelMap.put("status", Status.values());
		modelMap.put("applyTypes", dictionaryService.getByType(DictionaryType.yuYueType));
		return "/cms/userApply/add";
	}
	
	
	@RequestMapping("/save")
	@ResponseBody
	public Map<String, Object> save(UserApply user){
		Map<String, Object> map=new HashMap<>();
		user.setCreateTime(new Date());
		user.setUpdateTime(user.getCreateTime());
		if(!userApplyService.checkAmount(user)){
			map.put("error","预约确认金额超出可预约的金额");
			return map;
		}
		userApplyService.save(user);
		map.put("error","00");
		return map;
	}
	
	@RequestMapping("/edit")
	public String edit(Long id, ModelMap modelMap) {
		UserApplyVo user = userApplyService.findDetailById(id);
		modelMap.put("user", user);
		return "cms/userApply/edit";
	}
	
	@RequestMapping("/update")
	@ResponseBody
	public Map<String, Object> update(UserApply user,ModelMap modelMap){
		Map<String, Object> map=new HashMap<>();
		if(!userApplyService.checkAmount(user)){
			map.put("error","预约确认金额超出可预约的金额");
			return map;
		}
		userApplyService.update(user);
		map.put("error","00");
		return map;
	}
	
	@RequestMapping("/seachAmount")
	@ResponseBody
	public UserApplyAmountVo seachAmount(Long fundId){
		return userApplyService.searchAmount(fundId);
	} 
	/**
	 * 确认跳转
	 * @param id
	 * @param modelMap
	 * @return
	 */
	@RequestMapping("/confirm")
	public String confirm(Long id,ModelMap modelMap){
		UserApply userApply=userApplyService.get(id);
		modelMap.put("userApply", userApply);
		modelMap.put("amount", userApplyService.searchAmount(userApply.getFundId()));
		modelMap.put("userSecond", userSecondService.get(userApply.getUserSecondId()));
		return "cms/userApply/confirm";
	}
	
	@RequestMapping("/updateStatus")
	@ResponseBody
	public Map<String, Object> updateStatus(Long id,Long confirMoney,ModelMap modelMap,HttpServletRequest req){
		Map<String, Object> map=new HashMap<>();
		boolean success = userApplyService.confirm(id, confirMoney,getCurrentMember().getId());
		if(!success){
			map.put("error","确认金额超出可以预约金额!");
		}else{
			map.put("error","00");
		}
		return map;
	}
	/**
	 * 取消：确认金额为0，状态为取消
	 * @param id
	 * @param req
	 * @return
	 */
	@RequestMapping("/cancel")
	@ResponseBody
	public Map<String, Object> updateStatus(Long id,HttpServletRequest req){
		Map<String, Object> map=new HashMap<>();
		userApplyService.cancel(id);
		map.put("error","00");
		return map;
	}
}
