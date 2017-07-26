/**
 * 
 */
package com.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bo.ActivityApplyQueryBo;
import com.bo.ActivityBo;
import com.bo.ActivitySaveBo;
import com.bo.ActivityVo;
import com.bo.cura.ActivityWebDetailVo;
import com.common.Pager;
import com.entity.Activity;
import com.entity.ActivityApply;
import com.entity.ActivityFile;
import com.entity.ActivityFundManager;
import com.entity.ActivityGuest;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mapper.ActivityApplyMapper;
import com.mapper.ActivityFileMapper;
import com.mapper.ActivityFundManagerMapper;
import com.mapper.ActivityGuestMapper;
import com.mapper.ActivityMapper;
import com.service.ActivityService;

/**
 * @author	tyb
 * @date	2016年8月29日下午8:04:35
 * @desc	
 */
@Service("activityService")
public class ActivityServiceImpl extends BaseServiceImpl<Activity> implements ActivityService {
	
	@Autowired
	private ActivityMapper activityMapper;
	
	@Autowired
	private ActivityFundManagerMapper activityFundManagerMapper;
	
	@Autowired
	private ActivityGuestMapper activityGuestMapper;
	
	@Autowired
	private ActivityFileMapper activityFileMapper;
	
	@Autowired
	private ActivityApplyMapper activityApplyMapper;
	
	@Override
	public Pager<Activity> getList(Pager<Activity> pager, ActivityBo bo) {
		if(pager.getUsePager()){
			PageHelper.offsetPage(pager.getOffset(), pager.getLimit());
		}
		List<Activity> members=activityMapper.getList(pager,bo);
		pager.setRows(members);
		PageInfo<Activity> pageInfo=new PageInfo<Activity>(members);
		pager.setTotal(pageInfo.getTotal());
		return pager;
	}

	
	
	@Override
	public Pager<ActivityApply> getList(Pager<ActivityApply> pager, ActivityApplyQueryBo bo) {
		if(pager.getUsePager()){
			PageHelper.offsetPage(pager.getOffset(), pager.getLimit());
		}
		List<ActivityApply> members=activityApplyMapper.getList(pager,bo);
		pager.setRows(members);
		PageInfo<ActivityApply> pageInfo=new PageInfo<ActivityApply>(members);
		pager.setTotal(pageInfo.getTotal());
		return pager;
	}



	@Override
	@Transactional(readOnly=false)
	public void save(ActivitySaveBo bo) {
		if(bo != null){
			Activity entity = new Activity();
			BeanUtils.copyProperties(bo, entity);
			Date now = new Date();
			entity.setCreateTime(now);
			entity.setUpdateTime(now);
			activityMapper.insert(entity);
			if(bo.getManagers() != null){
				for(ActivityFundManager record: bo.getManagers()){
					if(StringUtils.isNotBlank(record.getName())){
						record.setCreateTime(now);
						record.setUpdateTime(now);
						record.setActivityId(entity.getId());
						activityFundManagerMapper.insert(record);
					}
				}
			}
			
			if(bo.getGuests() != null){
				for(ActivityGuest record: bo.getGuests()){
					if(StringUtils.isNotBlank(record.getName())){
						record.setCreateTime(now);
						record.setUpdateTime(now);
						record.setActivityId(entity.getId());
						activityGuestMapper.insert(record);
					}
				}
			}
			
			if(bo.getFiles() != null){
				for(ActivityFile record: bo.getFiles()){
					if(StringUtils.isNotBlank(record.getName())){
						record.setCreateTime(now);
						record.setUpdateTime(now);
						record.setActivityId(entity.getId());
						activityFileMapper.insert(record);
					}
				}
			}
		}
	}

	@Override
	public ActivitySaveBo getActivitySaveBo(Long id) {
		return activityMapper.getActivitySaveBo(id);
	}

	@Override
	@Transactional(readOnly=false)
	public void update(ActivitySaveBo bo) {
		if(bo != null){
			Activity entity = new Activity();
			BeanUtils.copyProperties(bo, entity);
			Date now = new Date();
			entity.setCreateTime(now);
			entity.setUpdateTime(now);
			activityMapper.updateByPrimaryKey(entity);
			//
			activityMapper.delManagersByActId(bo.getId());
			activityMapper.delGuestByActId(bo.getId());
			activityMapper.delFileByActId(bo.getId());
			if(bo.getManagers() != null){
				for(ActivityFundManager record: bo.getManagers()){
					if(StringUtils.isNotBlank(record.getName())){
						record.setCreateTime(now);
						record.setUpdateTime(now);
						record.setActivityId(entity.getId());
						activityFundManagerMapper.insert(record);
					}
				}
			}
			
			if(bo.getGuests() != null){
				for(ActivityGuest record: bo.getGuests()){
					if(StringUtils.isNotBlank(record.getName())){
						record.setCreateTime(now);
						record.setUpdateTime(now);
						record.setActivityId(entity.getId());
						activityGuestMapper.insert(record);
					}
				}
			}
			
			if(bo.getFiles() != null){
				for(ActivityFile record: bo.getFiles()){
					if(StringUtils.isNotBlank(record.getName())){
						record.setCreateTime(now);
						record.setUpdateTime(now);
						record.setActivityId(entity.getId());
						activityFileMapper.insert(record);
					}
				}
			}
		}
	}
	
	
	@Override
	public List<ActivityVo> curaList(String keyword, String year, Integer start, Integer pageSize,int mf) {
		start = (start-1)*pageSize;
		return activityMapper.curaList(keyword, year, start, pageSize,mf);
	}

	@Override
	public int curaCount(String keyword, String year, Integer start, Integer pageSize, int mf) {
		return activityMapper.curaCount(keyword, year, start, pageSize, mf);
	}

	@Override
	public List<ActivityVo> curaNowList() {
		List<ActivityVo> acts = activityMapper.curaNowList();
		return acts;
	}

	@Override
	public ActivityWebDetailVo curaDetailById(Long id) {
		ActivityWebDetailVo d = activityMapper.curaDetailById(id);
		if(d != null && d.getFiles() != null){
			if(d.getLiveFiles() == null){
				d.setLiveFiles(new ArrayList<ActivityFile>());//现场集锦-图片集合
			}
			if(d.getVideos() == null){
				d.setVideos(new ArrayList<ActivityFile>());
			}
			List<ActivityFile> attaches = new ArrayList<ActivityFile>();//活动附件
			for(ActivityFile f: d.getFiles()){//拆分为
				if(f.getActFileType() == 1){
					d.getLiveFiles().add(f);
				}else if(f.getActFileType() == 2){
					d.getVideos().add(f);
				}else if(f.getActFileType() == 3){
					attaches.add(f);
				}
			}
			d.setFiles(attaches);//附件
		}
		//现场集锦-左右分开
		if(d.getLiveFiles() != null && d.getLiveFiles().size()>0){
			int len = d.getLiveFiles().size();
			for(int i=1;i<=len;i++){
				if(i%2 == 0){//右边
					d.getRightFiles().add(d.getLiveFiles().get(i-1));
				}else{
					d.getLeftFiles().add(d.getLiveFiles().get(i-1));
				}
			}
		}
		return d;
	}

	@Override
	public void saveApply(ActivityApply entity) {
		activityApplyMapper.insert(entity);
	}
}
