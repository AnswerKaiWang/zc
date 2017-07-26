package com.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bo.QstVo;
import com.bo.QuestionAddBo;
import com.bo.QuestionBo;
import com.bo.QuestionEditVo;
import com.bo.QuestionTimeBo;
import com.bo.RiskTitleVo;
import com.bo.SelectResultVo;
import com.bo.cura.LoginVo;
import com.bo.cura.RiskEvaluationBo;
import com.bo.cura.RiskEvaluationResultVo;
import com.common.Pager;
import com.entity.Dictionary;
import com.entity.Question;
import com.entity.QuestionAnswer;
import com.entity.QuestionTime;
import com.entity.QuestionUserAnswer;
import com.entity.QuestionUserRecord;
import com.entity.UserSecond;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mapper.DictionaryMapper;
import com.mapper.QuestionAnswerMapper;
import com.mapper.QuestionMapper;
import com.mapper.QuestionTimeMapper;
import com.mapper.QuestionUserAnswerMapper;
import com.mapper.QuestionUserRecordMapper;
import com.mapper.UserSecondMapper;
import com.service.QuestionService;
import com.util.CommonUtils;

@Service("questionServiceImpl")
public class QuestionServiceImpl extends BaseServiceImpl<Question> implements QuestionService {

	@Autowired
	private QuestionMapper questionMapper;
	
	@Autowired
	private QuestionUserRecordMapper questionUserRecordMapper;
	
	@Autowired
	private QuestionUserAnswerMapper questionUserAnswerMapper;
	
	@Autowired
	private QuestionAnswerMapper questionAnswerMapper;
	
	@Autowired
	private QuestionTimeMapper questionTimeMapper;
	
	@Autowired
	private UserSecondMapper userSecondMapper;
	
	@Autowired
	private DictionaryMapper dictionaryMapper;
	
	@Override
	public Pager<Question> getList(Pager<Question> pager, QuestionBo questionBo) {
		if(pager.getUsePager()){
			PageHelper.offsetPage(pager.getOffset(), pager.getLimit());
		}
		List<Question> dictionaries=questionMapper.getList(pager,questionBo);
		pager.setRows(dictionaries);
		PageInfo<Question> pageInfo=new PageInfo<Question>(dictionaries);
		pager.setTotal(pageInfo.getTotal());
		return pager;
	}
	
	
	
	@Override
	public Pager<QuestionTime> getTList(Pager<QuestionTime> pager, QuestionTimeBo bo) {
		if(pager.getUsePager()){
			PageHelper.offsetPage(pager.getOffset(), pager.getLimit());
		}
		List<QuestionTime> list=questionTimeMapper.getList(pager,bo);
		pager.setRows(list);
		PageInfo<QuestionTime> pageInfo=new PageInfo<QuestionTime>(list);
		pager.setTotal(pageInfo.getTotal());
		return pager;
	}

	@Override
	public void addQuestionTime(QuestionTime qt) {
		qt.setCreateTime(new Date());
		qt.setUpdateTime(new Date());
		questionTimeMapper.insert(qt);
	}



	@Override
	public void editQuestionTime(QuestionTime qt) {
		QuestionTime old = questionTimeMapper.selectByPrimaryKey(qt.getId());
		if(old != null){
			qt.setCreateTime(old.getCreateTime());
		}
		qt.setUpdateTime(new Date());
		questionTimeMapper.updateByPrimaryKey(qt);
	}



	@Override
	public QuestionTime getQT(Long id) {
		return questionTimeMapper.selectByPrimaryKey(id);
	}



	@Override
	public void saveQuestion(QuestionAddBo bo) {
		if(bo != null){
			Question entity = new Question();
			BeanUtils.copyProperties(bo, entity);
			Date now = new Date();
			entity.setCreateTime(now);
			entity.setUpdateTime(now);
			questionMapper.insert(entity);
			if(bo.getAnswers() != null){
				for(QuestionAnswer record: bo.getAnswers()){
					if(StringUtils.isNotBlank(record.getAnswer())){
						record.setQuestionId(entity.getId());
						record.setCreateTime(now);
						record.setUpdateTime(now);
						questionAnswerMapper.insert(record);
					}
				}
			}
		}
	}

	@Override
	public void updateQuestion(QuestionAddBo bo) {
		if(bo != null){
			Question entity = new Question();
			BeanUtils.copyProperties(bo, entity);
			Date now = new Date();
			entity.setCreateTime(now);
			entity.setUpdateTime(now);
			questionMapper.updateByPrimaryKey(entity);
			//先删
			questionAnswerMapper.delByQuestionId(bo.getId());
			if(bo.getAnswers() != null){
				for(QuestionAnswer record: bo.getAnswers()){
					if(StringUtils.isNotBlank(record.getAnswer())){
						record.setQuestionId(entity.getId());
						record.setCreateTime(now);
						record.setUpdateTime(now);
						questionAnswerMapper.insert(record);
					}
				}
			}
		}
	}

	@Override
	public QuestionEditVo findDetailById(Long id) {
		return questionMapper.findDetailById(id);
	}



	@Override
	public List<SelectResultVo> searchQuestionList(String keyword) {
		return questionMapper.searchQuestionList(keyword);
	}



	@Override
	public List<RiskTitleVo> findRiskTitleById(String type) {
		Long qtId = questionMapper.getLastestId(type);
		List<RiskTitleVo> list = questionMapper.findRiskTitleById(qtId);
		if(list != null){
			int index =1;
			for(RiskTitleVo t: list){
				t.setIndex(CommonUtils.numToCn(index));
				index ++;
			}
		}
		return list;
	}


	
	@Transactional(readOnly=false)
	@Override
	public void addRiskEvaluation(RiskEvaluationBo bo, LoginVo vo,Map<String,String> rt) {
		QuestionUserRecord qu = new QuestionUserRecord();
		BeanUtils.copyProperties(bo, qu);
		Date now = new Date();
		qu.setCreateTime(now);
		qu.setUpdateTime(now);
		questionUserRecordMapper.insert(qu);
		Long quId = qu.getId();
		addRiskEvaluationAnswer(quId,bo.getTopic1());
		addRiskEvaluationAnswer(quId,bo.getTopic2());
		addRiskEvaluationAnswer(quId,bo.getTopic3());
		addRiskEvaluationAnswer(quId,bo.getTopic4());
		addRiskEvaluationAnswer(quId,bo.getTopic5());
		addRiskEvaluationAnswer(quId,bo.getTopic6());
		addRiskEvaluationAnswer(quId,bo.getTopic7());
		addRiskEvaluationAnswer(quId,bo.getTopic8());
		addRiskEvaluationAnswer(quId,bo.getTopic9());
		addRiskEvaluationAnswer(quId,bo.getTopic10());
		addRiskEvaluationAnswer(quId,bo.getTopic11());
		addRiskEvaluationAnswer(quId,bo.getTopic12());
		addRiskEvaluationAnswer(quId,bo.getTopic13());
		addRiskEvaluationAnswer(quId,bo.getTopic14());
		addRiskEvaluationAnswer(quId,bo.getTopic15());
		addRiskEvaluationAnswer(quId,bo.getTopic16());
		addRiskEvaluationAnswer(quId,bo.getTopic17());
		
		//计算风险等级
		Integer score = questionUserRecordMapper.getEvaluationScore(quId);
		//风险等级
		if(score != null){
			qu.setScore(score);
			RiskEvaluationResultVo result = questionUserRecordMapper.getEvaluationResult(score);
			if(result != null){
				//更新user数据
				qu.setRiskLevel(result.getRiskLevel());
				//更新用户
				UserSecond us = userSecondMapper.selectByPrimaryKey(bo.getUserSecondId());
				if(us != null){
					us.setUserRiskLevelId(Long.valueOf(result.getRiskLevel()));
					us.setUserEvaluateTime(DateFormatUtils.format(new Date(), "yyyy-MM-dd"));
					userSecondMapper.updateByPrimaryKey(us);
				}
			}
			questionUserRecordMapper.updateByPrimaryKey(qu);//更新
			vo.setEvaluationTime(new Date());
			vo.setRiskLevel(result.getRiskLevel());
			vo.setRiskLevelName(result.getRiskBear());
			rt.put("riskLevelId", result.getRiskLevel());
			rt.put("score", String.valueOf(score));
			rt.put("riskBear", result.getRiskBear());//风险类型
			rt.put("riskNotify",result.getRiskNotification());//风险类型提醒
			Dictionary d = dictionaryMapper.selectByPrimaryKey(Long.valueOf(result.getRiskLevel()));
			if(d!=null){
				rt.put("riskLevel",d.getName().substring(0, 2));
			}
		}
	}
	
	private void addRiskEvaluationAnswer(Long quId,String topic){
		if(StringUtils.isNotBlank(topic) && topic.indexOf("_")>-1){
			QuestionUserAnswer qua = new QuestionUserAnswer();
			qua.setQuId(quId);
			String[] ids = topic.split("_");
			if(ids.length==2){
				qua.setQuestionId(Long.valueOf(ids[0]));
				qua.setQuestionAnswerId(Long.valueOf(ids[1]));
				questionUserAnswerMapper.insert(qua);
			}
		}
	}



	@Override
	public List<QstVo> findQsts() {
		//获得最新的调查报告
		return null;
	}

	@Override
	public List<RiskTitleVo> getQHis(Long quId) {
		List<RiskTitleVo> list = questionMapper.getQHis(quId);
		if(list != null){
			int index =1;
			for(RiskTitleVo t: list){
				t.setIndex(CommonUtils.numToCn(index));
				index ++;
			}
		}
		return list;
	}
}
