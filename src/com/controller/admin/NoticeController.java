/**
 * 
 */
package com.controller.admin;

import java.util.Date;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bo.NoticeBo;
import com.common.Pager;
import com.controller.AdminBaseController;
import com.entity.Notice;
import com.service.NoticeService;

/**
 * @author	tyb
 * @date	2016年9月13日上午10:17:43
 * @desc	
 */
@Controller("adminNoticeController")
@RequestMapping("/admin/notice")
public class NoticeController extends AdminBaseController {
	
	@Resource
	private NoticeService noticeService;
	
	@RequestMapping("/toList")
	public String toList(ModelMap modelMap){
		return "/cms/notice/list";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public Object list(Pager<Notice> pager,NoticeBo bo){
		return noticeService.getList(pager, bo);
	}
	
	@RequestMapping("/add")
	public String add(ModelMap modelMap){
		return "/cms/notice/add";
	}
	
	@RequestMapping("/save")
	@ResponseBody
	public Map<String, Object> save(Notice bo, ModelMap modelMap){
		bo.setCreateTime(new Date());
		bo.setUpdateTime(new Date());
		noticeService.save(bo);
		return success();
	}
	
	@RequestMapping("/edit")
	public String edit(Long id, ModelMap modelMap){
		modelMap.put("notice", noticeService.get(id));
		return "/cms/notice/edit";
	}
	
	@RequestMapping("/update")
	@ResponseBody
	public Map<String, Object> update(Notice bo, ModelMap modelMap){
		Notice old = noticeService.get(bo.getId());
		if(old != null){
			bo.setCreateTime(old.getCreateTime());
			bo.setUpdateTime(new Date());
			noticeService.update(bo);
		}
		return success();
	}
}
