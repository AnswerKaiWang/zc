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
import org.springframework.ui.ModelMap;

import com.bo.QsVo;
import com.bo.QtSurveyBo;
import com.bo.QtSurveyRecordVo;
import com.bo.QtSurveyTopicSaveBo;
import com.bo.QtSurveyTopicVo;
import com.bo.SelectResultVo;
import com.bo.cura.SurveyBo;
import com.common.Pager;
import com.entity.QtSurvey;
import com.entity.QtSurveyAnswer;
import com.entity.QtSurveyRecord;
import com.entity.QtSurveyRecordAnswer;
import com.entity.QtSurveyTopic;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mapper.QtSurveyAnswerMapper;
import com.mapper.QtSurveyMapper;
import com.mapper.QtSurveyRecordAnswerMapper;
import com.mapper.QtSurveyRecordMapper;
import com.mapper.QtSurveyTopicMapper;
import com.service.QtSurveyService;
import com.util.CommonUtils;

/**
 * @author	tyb
 * @date	2016年9月17日上午10:06:57
 * @desc	
 */
@Service("qtSurveyService")
public class QtSurveyServiceImpl extends BaseServiceImpl<QtSurvey> implements QtSurveyService {
	
	
	@Autowired
	private QtSurveyMapper qtSurveyMapper;
	
	@Autowired
	private QtSurveyTopicMapper qtSurveyTopicMapper;
	
	@Autowired
	private QtSurveyAnswerMapper qtSurveyAnswerMapper;
	
	@Autowired
	private QtSurveyRecordMapper qtSurveyRecordMapper;
	
	@Autowired
	private QtSurveyRecordAnswerMapper qtSurveyRecordAnswerMapper;
	
	@Override
	public Pager<QtSurvey> getList(Pager<QtSurvey> pager, QtSurveyBo bo) {
		if(pager.getUsePager()){
			PageHelper.offsetPage(pager.getOffset(), pager.getLimit());
		}
		List<QtSurvey> rows=qtSurveyMapper.getList(pager,bo);
		pager.setRows(rows);
		PageInfo<QtSurvey> pageInfo=new PageInfo<QtSurvey>(rows);
		pager.setTotal(pageInfo.getTotal());
		return pager;
	}

	@Override
	public Pager<QtSurveyTopic> getTopicList(Pager<QtSurveyTopic> pager, QtSurveyBo bo) {
		if(pager.getUsePager()){
			PageHelper.offsetPage(pager.getOffset(), pager.getLimit());
		}
		List<QtSurveyTopic> rows=qtSurveyTopicMapper.getList(pager,bo);
		pager.setRows(rows);
		PageInfo<QtSurveyTopic> pageInfo=new PageInfo<QtSurveyTopic>(rows);
		pager.setTotal(pageInfo.getTotal());
		return pager;
	}

	@Override
	public boolean repeated(QtSurvey entity) {
		Date st = entity.getStartTime();
		Date max = qtSurveyMapper.getMaxEndTime(entity.getId());
		if(max == null){
			return false;
		}
		if(max.after(st)){//时间不对
			return true;
		}
		return false;
	}

	@Override
	public void addTopic(QtSurveyTopicSaveBo bo) {
		if(bo != null){
			QtSurveyTopic entity = new QtSurveyTopic();
			BeanUtils.copyProperties(bo, entity);
			qtSurveyTopicMapper.insert(entity);
			if(bo.getAnswers() != null){
				for(QtSurveyAnswer record: bo.getAnswers()){
					if(StringUtils.isNotBlank(record.getAnswer())){
						record.setQsId(entity.getQsId());
						record.setQstId(entity.getId());
						qtSurveyAnswerMapper.insert(record);
					}
				}
			}
		}
	}
	
	@Override
	public QtSurveyTopicVo findDetaiById(Long id) {
		QtSurveyTopicVo vo = qtSurveyTopicMapper.findDetailById(id);
		if(vo == null){
			vo = new QtSurveyTopicVo();
		}
		return vo;
	}

	@Override
	@Transactional(readOnly=false)
	public void editTopic(QtSurveyTopicSaveBo bo) {
		if(bo != null){
			QtSurveyTopic entity = new QtSurveyTopic();
			BeanUtils.copyProperties(bo, entity);
			qtSurveyTopicMapper.updateByPrimaryKey(entity);
			//删除
			qtSurveyTopicMapper.delByQstId(bo.getId());
			if(bo.getAnswers() != null){
				for(QtSurveyAnswer record: bo.getAnswers()){
					if(StringUtils.isNotBlank(record.getAnswer())){
						record.setQsId(entity.getQsId());
						record.setQstId(entity.getId());
						qtSurveyAnswerMapper.insert(record);
					}
				}
			}
		}
	}

	@Override
	public Pager<QtSurveyRecordVo> getQtRecordList(Pager<QtSurveyRecordVo> pager, QtSurveyBo bo) {
		if(pager.getUsePager()){
			PageHelper.offsetPage(pager.getOffset(), pager.getLimit());
		}
		List<QtSurveyRecordVo> rows=qtSurveyRecordMapper.getList(pager,bo);
		pager.setRows(rows);
		PageInfo<QtSurveyRecordVo> pageInfo=new PageInfo<QtSurveyRecordVo>(rows);
		pager.setTotal(pageInfo.getTotal());
		return pager;
	}

	@Override
	public List<SelectResultVo> searchQsList(String keyword) {
		return qtSurveyMapper.searchQsList(keyword);
	}
	
	/**
	 * <option value=1>贵宾信息</option>
				       <option value=2>投资偏好调查</option>
				       <option value=3>风险偏好调查</option>
				       <option value=4>服务偏好调查</option>
	 * @param model
	 * @return
	 */
	@Override
	public List<QsVo> findLastestQsVo(ModelMap model) {
		Long id =qtSurveyMapper.getLastestQt();
		List<QsVo> qss = new ArrayList<>();
		if(id != null){
			qss = qtSurveyMapper.getQsVo(id);
			if(qss != null){
				int index =1;
				for(QsVo qs: qss){
					qs.setIndex(CommonUtils.numToCn(index));
					qs.setQsTypeName(index==1?"贵宾信息":index==2?"投资偏好调查":index==3?"风险偏好调查":"服务偏好调查");
					index ++;
				}
			}
		}
		model.put("qsId", id);
		return qss;
	}

	@Override
	@Transactional(readOnly=false)
	public void addQsRecord(SurveyBo bo, Long userSecondId) {
		Long qsId = bo.getQsId();//问卷调查的ID
		
		QtSurveyRecord record = new QtSurveyRecord();
		record.setCreateTime(new Date());
		record.setQsId(qsId);
		record.setUserSecondId(userSecondId);
		qtSurveyRecordMapper.insert(record);
		addQsa(bo.getTopic1(),record.getId(),bo.getTopicSpan1());
		addQsa(bo.getTopic2(),record.getId(),bo.getTopicSpan2());
		addQsa(bo.getTopic3(),record.getId(),bo.getTopicSpan3());
		addQsa(bo.getTopic4(),record.getId(),bo.getTopicSpan4());
		addQsa(bo.getTopic5(),record.getId(),bo.getTopicSpan5());
		addQsa(bo.getTopic6(),record.getId(),bo.getTopicSpan6());
		addQsa(bo.getTopic7(),record.getId(),bo.getTopicSpan7());
		addQsa(bo.getTopic8(),record.getId(),bo.getTopicSpan8());
		addQsa(bo.getTopic9(),record.getId(),bo.getTopicSpan9());
		addQsa(bo.getTopic10(),record.getId(),bo.getTopicSpan10());
		addQsa(bo.getTopic11(),record.getId(),bo.getTopicSpan11());
		addQsa(bo.getTopic12(),record.getId(),bo.getTopicSpan12());
		addQsa(bo.getTopic13(),record.getId(),bo.getTopicSpan13());
		addQsa(bo.getTopic14(),record.getId(),bo.getTopicSpan14());
		addQsa(bo.getTopic15(),record.getId(),bo.getTopicSpan15());
		addQsa(bo.getTopic16(),record.getId(),bo.getTopicSpan16());
	}
	
	private void addQsa(String topic, Long qsrId,String topicSpan){
		if(StringUtils.isNotBlank(topic)){
			if(topic.contains(",") && topic.contains("_")){//多选
				String[] qids = topic.split(",");
				for(String qid: qids){
					String[] ids = qid.split("_");
					addQsRecordAnswer(qsrId,Long.valueOf(ids[0]),Long.valueOf(ids[1]),null);
				}
			}else{
				if(topic.indexOf("_")>-1){//单选
					String[] ids = topic.split("_");
					addQsRecordAnswer(qsrId,Long.valueOf(ids[0]),Long.valueOf(ids[1]),null);
				}else{//文本
					String[] ids = topicSpan.split("_");
					addQsRecordAnswer(qsrId,Long.valueOf(ids[0]),0L,topic);
				}
			}
		}
	}
	
	private void addQsRecordAnswer(Long qsrId, Long qstId, Long qsaId,String text){
		QtSurveyRecordAnswer answer = new QtSurveyRecordAnswer();
		answer.setQsrId(qsrId);
		answer.setQstId(qstId);
		answer.setQsaId(qsaId);
		answer.setText(text);
		qtSurveyRecordAnswerMapper.insert(answer);
	}
}
