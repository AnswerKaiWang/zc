/**
 * 
 */
package com.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bo.LectureBo;
import com.bo.LectureEditVo;
import com.bo.cura.LecturePageBo;
import com.bo.cura.LectureWebDetailVo;
import com.bo.cura.LectureWebVo;
import com.common.Pager;
import com.entity.Lecture;

import tk.mybatis.mapper.common.Mapper;

/**
 * @author	tyb
 * @date	2016年8月29日上午11:28:05
 * @desc	
 */
public interface LectureMapper extends Mapper<Lecture> {
	
	List<Lecture> getList(@Param("pager")Pager<Lecture> pager, @Param("bo") LectureBo bo);
	
	
	void delLecVedios(@Param("id") Long id);
	
	
	List<LectureWebVo> curaList(LecturePageBo bo);
	/**
	 * 推荐的微讲堂
	 * @return
	 */
	List<LectureWebVo> curaRecList();
	
	int curaCount(LecturePageBo bo);
	
	LectureWebDetailVo findWebDetailById(@Param("id") Long id);
	
	/**
	 * 编辑详情
	 * @param id
	 * @return
	 */
	LectureEditVo findDetailById(@Param("id") Long id);
}
