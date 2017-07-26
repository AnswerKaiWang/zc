/**
 * 
 */
package com.controller.cura;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bo.cura.LecturePageBo;
import com.bo.cura.LectureWebVo;
import com.bo.cura.RespListBean;
import com.controller.CuraBaseController;
import com.service.LectureService;

/**
 * @author	tyb
 * @date	2016年9月5日下午5:50:10
 * @desc	
 */
@Controller("curaLectureController")
@RequestMapping("/cura/lecture")
public class LectureController extends CuraBaseController {
	
	@Autowired
	private LectureService lectureService;
	
	@RequestMapping("/detail")
	public String detail(Long id,ModelMap model){
		model.put("lecture", lectureService.findWebDetailById(id));
		model.put("recs", lectureService.recList());
		return "/cura/weijiangtang_main";
	}
	
	@RequestMapping("/main")
	public String main(ModelMap model){
		return "/cura/weijiangtang";
	}
	
	/**
	 * 微讲堂-列表
	 * @param model
	 * @return
	 */
	@RequestMapping("/list")
	@ResponseBody
	public RespListBean list(LecturePageBo bo,ModelMap model){
		int count = lectureService.count(bo);
		List<LectureWebVo> lectures = lectureService.list(bo);
		return success(count,count/bo.getPageSize() +1,lectures);
	}
}
