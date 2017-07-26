/**
 * 
 */
package com.service.impl;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bo.LectureBo;
import com.bo.LectureEditVo;
import com.bo.LectureSaveBo;
import com.bo.cura.LecturePageBo;
import com.bo.cura.LectureWebDetailVo;
import com.bo.cura.LectureWebVo;
import com.common.Pager;
import com.entity.Lecture;
import com.entity.LectureVedio;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mapper.LectureMapper;
import com.mapper.LectureVideoMapper;
import com.service.LectureService;

/**
 * @author	tyb
 * @date	2016年8月29日下午8:04:35
 * @desc	
 */
@Service("lectureService")
public class LectureServiceImpl extends BaseServiceImpl<Lecture> implements LectureService {
	
	@Autowired
	private LectureMapper lectureMapper;
	
	@Autowired
	private LectureVideoMapper lectureVideoMapper;
	
	@Override
	public Pager<Lecture> getList(Pager<Lecture> pager, LectureBo bo) {
		if(pager.getUsePager()){
			PageHelper.offsetPage(pager.getOffset(), pager.getLimit());
		}
		List<Lecture> members=lectureMapper.getList(pager,bo);
		pager.setRows(members);
		PageInfo<Lecture> pageInfo=new PageInfo<Lecture>(members);
		pager.setTotal(pageInfo.getTotal());
		return pager;
	}

	@Override
	public void save(LectureSaveBo bo) {
		Lecture lec = new Lecture();
		BeanUtils.copyProperties(bo, lec);
		Date now = new Date();
		lec.setCreateTime(now);
		lec.setUpdateTime(now);
		lectureMapper.insert(lec);
		
		if(bo.getVedios() != null){
			for(LectureVedio vedio: bo.getVedios()){
				if(StringUtils.isNotBlank(vedio.getName())){
					vedio.setCreateTime(now);
					vedio.setUpdateTime(now);
					vedio.setLectureId(lec.getId());
					lectureVideoMapper.insert(vedio);
				}
			}
		}
	}

	@Override
	public void edit(LectureSaveBo bo) {
		Lecture old = get(bo.getId());
		if(old != null){
			Lecture lec = new Lecture();
			BeanUtils.copyProperties(bo, lec);
			Date now = new Date();
			lec.setCreateTime(old.getCreateTime());
			lec.setUpdateTime(now);
			lectureMapper.updateByPrimaryKey(lec);
			lectureMapper.delLecVedios(old.getId());
			if(bo.getVedios() != null){
				for(LectureVedio vedio: bo.getVedios()){
					if(StringUtils.isNotBlank(vedio.getName())){
						vedio.setCreateTime(now);
						vedio.setUpdateTime(now);
						vedio.setLectureId(lec.getId());
						lectureVideoMapper.insert(vedio);
					}
				}
			}
		}
	}

	@Override
	public List<LectureWebVo> list(LecturePageBo bo) {
		bo.setStart((bo.getStart()-1)*bo.getPageSize());
		return lectureMapper.curaList(bo);
	}

	@Override
	public Integer count(LecturePageBo bo) {
		return lectureMapper.curaCount(bo);
	}

	@Override
	public LectureWebDetailVo findWebDetailById(Long id) {
		if(id == null){
			return null;
		}
		return lectureMapper.findWebDetailById(id);
	}

	@Override
	public List<LectureWebVo> recList() {
		return lectureMapper.curaRecList();
	}

	@Override
	public LectureEditVo findDetailById(Long id) {
		return lectureMapper.findDetailById(id);
	}
}
