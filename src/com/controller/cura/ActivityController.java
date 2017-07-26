/**
 * 
 */
package com.controller.cura;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bo.ActivityVo;
import com.bo.cura.ActivityApplyBo;
import com.bo.cura.ActivityPageBo;
import com.bo.cura.RespBean;
import com.bo.cura.RespListBean;
import com.controller.CuraBaseController;
import com.entity.ActivityApply;
import com.service.ActivityService;

/**
 * @author	tyb
 * @date	2016年9月4日下午9:33:29
 * @desc	
 */
@Controller("curaActivityController")
@RequestMapping("/cura/activity")
public class ActivityController extends CuraBaseController {
	
	@Autowired
	private ActivityService activityService;
	
	/**
	 * 活动
	 * @param year
	 * @param start
	 * @param pageSize
	 * @param keyword
	 * @param model
	 * @return
	 */
	@RequestMapping
	public String index(String year,Integer start,Integer pageSize,String keyword,ModelMap model){
		if(year ==null){
			year = getYear(Calendar.YEAR, 0);
		}
		if(StringUtils.isNotBlank(keyword)){
			try {
				keyword = URLDecoder.decode(keyword, "UTF-8");
			} catch (UnsupportedEncodingException e) {
				//e.printStackTrace();
			}
		}
		if(start ==null) start =1;
		if(pageSize == null) pageSize =5;
		model.put("year", year);
		model.put("start", start);
		model.put("pageSize", pageSize);
		model.put("keyword", keyword);
		model.put("now", getYear(Calendar.YEAR, 0));
		model.put("pre1", getYear(Calendar.YEAR, -1));
		model.put("pre2", getYear(Calendar.YEAR, -2));
		String more = getYear(Calendar.YEAR, -3);
		model.put("pre3", more);
//		int mf = 0;
//		if(year.equals(more)){//常看更多
//			mf = 1;
//		}
		//model.put("agoActs", activityService.curaList(keyword, year, start, pageSize,mf));
		model.put("nowActs", activityService.curaNowList());
		return "/cura/activity";
	}
	@RequestMapping("/list")
	@ResponseBody
	public RespListBean list(ActivityPageBo bo){
		int mf = 0;
		String more = getYear(Calendar.YEAR, -3);
		if(bo.getYear().equals(more)){//常看更多
			mf = 1;
		}
		
		if(StringUtils.isNotBlank(bo.getKeyword())){
			try {
				bo.setKeyword(URLDecoder.decode(bo.getKeyword(), "UTF-8"));
			} catch (UnsupportedEncodingException e) {
				//e.printStackTrace();
			}
		}
		int count = activityService.curaCount(bo.getKeyword(),bo.getYear(),bo.getStart(),bo.getPageSize(),mf);
		List<ActivityVo> rts = activityService.curaList(bo.getKeyword(),bo.getYear(),bo.getStart(),bo.getPageSize(),mf);
		return success(count,count/bo.getPageSize() +1,rts);
	}
	
	@RequestMapping("/detail")
	public String now(Long id,ModelMap model){
		model.put("activity", activityService.curaDetailById(id));
		return "/cura/activity_details";
	}
	
	@RequestMapping("/ago")
	public String ago(ModelMap model){
		model.put("now", getYear(Calendar.YEAR, 0));
		model.put("pre1", getYear(Calendar.YEAR, -1));
		model.put("pre2", getYear(Calendar.YEAR, -2));
		String more = getYear(Calendar.YEAR, -3);
		model.put("pre3", more);
		return "/cura/ago_activity";
	}
	
	@RequestMapping("/ago/detail")
	public String detail(Long id,ModelMap model){
		model.put("activity", activityService.curaDetailById(id));
		return "/cura/ago_details";
	}
	/**
	 * 活动报名
	 * @param bo
	 * @param model
	 * @return
	 */
	@RequestMapping("/apply")
	@ResponseBody
	public RespBean apply(ActivityApplyBo bo, ModelMap model){
		ActivityApply entity = new ActivityApply();
		BeanUtils.copyProperties(bo, entity);
		Date now = new Date();
		entity.setCreateTime(now);
		entity.setUpdateTime(now);
		activityService.saveApply(entity);
		return success();
	}
}
