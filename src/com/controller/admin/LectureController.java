/**
 * 
 */
package com.controller.admin;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bo.LectureBo;
import com.bo.LectureSaveBo;
import com.common.Pager;
import com.controller.AdminBaseController;
import com.entity.Lecture;
import com.service.LectureService;

/**
 * @author	tyb
 * @date	2016年9月13日上午10:46:24
 * @desc	
 */
@Controller("adminLectureController")
@RequestMapping("/admin/lecture")
public class LectureController extends AdminBaseController {
	
	@Resource
	private LectureService lectureService;
	
	@RequestMapping("/toList")
	public String toList(ModelMap modelMap){
		return "/cms/lecture/list";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public Object list(Pager<Lecture> pager,LectureBo bo){
		return lectureService.getList(pager, bo);
	}
	
	@RequestMapping("/add")
	public String add(ModelMap modelMap){
		return "/cms/lecture/add";
	}
	
	@RequestMapping("/save")
	@ResponseBody
	public Map<String, Object> save(LectureSaveBo bo, ModelMap modelMap){
		lectureService.save(bo);
		return success();
	}
	
	@RequestMapping("/edit")
	public String edit(Long id, ModelMap modelMap){
		modelMap.put("lecture", lectureService.findDetailById(id));
		return "/cms/lecture/edit";
	}
	
	@RequestMapping("/update")
	@ResponseBody
	public Map<String, Object> update(LectureSaveBo bo, ModelMap modelMap){
		lectureService.edit(bo);
		return success();
	}
}
