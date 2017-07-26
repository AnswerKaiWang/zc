/**
 * 
 */
package com.controller.admin;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bo.MessageBo;
import com.bo.MessageUserBo;
import com.bo.MessageUserVo;
import com.common.Pager;
import com.controller.AdminBaseController;
import com.entity.Message;
import com.enums.DictionaryType;
import com.service.DictionaryService;
import com.service.MessageService;
import com.util.JsonUtils;

/**
 * @author	tyb
 * @date	2016年9月9日下午4:44:34
 * @desc	消息管理
 */
@Controller
@RequestMapping("/admin/message")
public class MessageController extends AdminBaseController {
	
	@Resource
	private MessageService messageService;
	
	@Resource
	private DictionaryService dictionaryService;
	
	
	@RequestMapping("/toList")
	public String toList(ModelMap model){
		return "/cms/message/list";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public Object list(Pager<Message> pager,MessageBo bo){
		return messageService.getList(pager, bo);
	}
	
	@RequestMapping("/toUsers")
	public String toUsers(ModelMap model){
		model.put("levels", dictionaryService.getListByType(DictionaryType.userLevel));
		model.put("types", dictionaryService.getListByType(DictionaryType.perCardType));
		return "/cms/message/users";
	}
	
	@RequestMapping("/users")
	@ResponseBody
	public Object users(Pager<MessageUserVo> pager,MessageUserBo bo){
		return messageService.getUserList(pager, bo);
	}
	
	
	@RequestMapping("/toSendMsg")
	public String toSendMsg(ModelMap modelMap,Long[] ids){
		modelMap.put("ids", JsonUtils.toJson(ids));
		return "/cms/message/sendMsg";
	}
	
	@RequestMapping("/sendMsg")
	@ResponseBody
	public Map<String, Object> sendMsg(Long[] ids,String content,ModelMap modelMap){
		Map<String, Object> map=new HashMap<>();
		messageService.sendMsg(ids,content,getCurrentMember().getId());
		map.put("error","00");
		return map;
	}
}
