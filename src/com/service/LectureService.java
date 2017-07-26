/**
 * 
 */
package com.service;

import java.util.List;

import com.bo.LectureBo;
import com.bo.LectureEditVo;
import com.bo.LectureSaveBo;
import com.bo.cura.LecturePageBo;
import com.bo.cura.LectureWebDetailVo;
import com.bo.cura.LectureWebVo;
import com.common.Pager;
import com.entity.Lecture;

/**
 * @author	tyb
 * @date	2016年8月29日下午3:01:23
 * @desc	
 */
public interface LectureService extends BaseService<Lecture>{
	
	Pager<Lecture> getList(Pager<Lecture> pager, LectureBo bo);
	
	void save(LectureSaveBo bo);
	
	void edit(LectureSaveBo bo);
	
	//前端
	/**
	 * 列表
	 * @param bo
	 * @return
	 */
	List<LectureWebVo> list(LecturePageBo bo);
	/**
	 * 总数大小
	 * @param bo
	 * @return
	 */
	Integer count(LecturePageBo bo);
	/**
	 * 微讲堂详情
	 * @param id
	 * @return
	 */
	LectureWebDetailVo findWebDetailById(Long id);
	
	List<LectureWebVo> recList();
	/**
	 * 微讲堂编辑详情
	 * @param id
	 * @return
	 */
	LectureEditVo findDetailById(Long id);
}
