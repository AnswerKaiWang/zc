package com.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bo.FundBo;
import com.bo.FundEditVo;
import com.bo.FundSaveBo;
import com.bo.SelectResultVo;
import com.bo.UserCurrentBo;
import com.bo.cura.ProductBo;
import com.bo.cura.ProductVo;
import com.common.Pager;
import com.entity.Fund;
import com.entity.FundRecord;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mapper.FundMapper;
import com.mapper.FundRecordMapper;
import com.service.FundService;
import com.util.CommonUtils;

import tk.mybatis.mapper.entity.Example;
import tk.mybatis.mapper.entity.Example.Criteria;

@Service("fundServiceImpl")
public class FundServiceImpl extends BaseServiceImpl<Fund> implements FundService{

	@Autowired
	private FundMapper fundMapper;

	@Autowired
	private FundRecordMapper fundRecordMapper;
	
	
	@Override
	public Pager<Fund> getList(Pager<Fund> pager, FundBo fundBo) {
		if(pager.getUsePager()){
			PageHelper.offsetPage(pager.getOffset(), pager.getLimit());
		}
		List<Fund> members=fundMapper.getList(pager,fundBo);
		pager.setRows(members);
		PageInfo<Fund> pageInfo=new PageInfo<Fund>(members);
		pager.setTotal(pageInfo.getTotal());
		return pager;
	}

	@Override
	public List<String> getTypeByGroup() {
		return fundMapper.getTypeByGroup();
	}

	@Override
	public List<Fund> getFundsByCompanyId(Long companyId) {
		Example example=new Example(Fund.class);
		example.createCriteria().andEqualTo("companyId", companyId);
		return fundMapper.selectByExample(example);
	}

	@Override
	public void saveFund(FundSaveBo fund) {
		if(fund != null){
			Fund entity = new Fund();
			BeanUtils.copyProperties(fund, entity);
			Date now = new Date();
			entity.setCreateTime(now);
			entity.setUpdateTime(now);
			entity.setGpFund(StringUtils.isNotBlank(entity.getGpFund())?entity.getGpFund().replaceAll(",", ""):entity.getGpFund());
			entity.setPlanCollectMoney(StringUtils.isNotBlank(entity.getPlanCollectMoney())?entity.getPlanCollectMoney().replaceAll(",", ""):entity.getPlanCollectMoney());
			fundMapper.insert(entity);
			if(fund.getRecords() != null){
				for(FundRecord record: fund.getRecords()){
					if(StringUtils.isNotBlank(record.getName())){
						record.setFundId(entity.getId());
						record.setCreateTime(now);
						record.setTotalMoney(record.getTotalMoney().replaceAll(",", ""));
						record.setUpdateTime(now);
						fundRecordMapper.insert(record);
					}
				}
			}
		}
	}
	@Override
	public void updateFund(FundSaveBo fund) {
		if(fund != null){
			Fund entity = new Fund();
			BeanUtils.copyProperties(fund, entity);
			Date now = new Date();
			entity.setCreateTime(now);
			entity.setUpdateTime(now);
			entity.setGpFund(StringUtils.isNotBlank(entity.getGpFund())?entity.getGpFund().replaceAll(",", ""):entity.getGpFund());
			entity.setPlanCollectMoney(StringUtils.isNotBlank(entity.getPlanCollectMoney())?entity.getPlanCollectMoney().replaceAll(",", ""):entity.getPlanCollectMoney());
			fundMapper.updateByPrimaryKey(entity);
			//先删
			fundRecordMapper.delByFundId(fund.getId());
			if(fund.getRecords() != null){
				for(FundRecord record: fund.getRecords()){
					if(StringUtils.isNotBlank(record.getName())){
						record.setFundId(entity.getId());
						record.setCreateTime(now);
						record.setUpdateTime(now);
						record.setTotalMoney(record.getTotalMoney().replaceAll(",", ""));
						fundRecordMapper.insert(record);
					}
				}
			}
		}
	}

	@Override
	@Transactional
	public void saveList(List<Fund> funds) {
		for (Fund fund : funds) {
			fundMapper.insert(fund);
		}
	}

	@Override
	public Fund getFunByNo(String no) {
		Example example=new Example(Fund.class);
		example.createCriteria().andEqualTo("no", no);
		List<Fund> funds=fundMapper.selectByExample(example);
		return CommonUtils.isEmpty(funds)?null:funds.get(0);
	}


	@Override
	public PageInfo<Fund> getFunds(Integer page, UserCurrentBo userCurrentBo) {
		PageHelper.startPage((page==null||page<=0)?1:page, 10);
		List<Fund> funds=fundMapper.getFrontList(userCurrentBo);
		return new PageInfo<Fund>(funds);
	}

	@Override
	public Fund getFunByBei(String bei) {
		Example example=new Example(Fund.class);
		example.createCriteria().andEqualTo("beiNo", bei);
		List<Fund> funds=fundMapper.selectByExample(example);
		return CommonUtils.isEmpty(funds)?null:funds.get(0);
	}

	@Override
	public List<Fund> searchFundList(String search) {
		Example example=new Example(Fund.class);
		Criteria criteria=example.createCriteria();
		if(CommonUtils.isNotEmpty(search)){
			criteria.andLike("name", "%"+search+"%");
		}
		return fundMapper.selectByExample(example);
	}

	@Override
	public FundEditVo findDetailById(Long id) {
		return fundMapper.findDetailById(id);
	}

	@Override
	public List<ProductVo> cruaList(ProductBo bo) {
		List<ProductVo> list = new ArrayList<>();
		bo.setStart((bo.getStart()-1)*bo.getPageSize());
		list = fundMapper.cruaList(bo);
		return list;
	}
	
	@Override
	public int curaCount(ProductBo bo) {
		return fundMapper.cruaCount(bo);
	}

	@Override
	public List<ProductVo> curaBannerList() {
		return fundMapper.curaBannerList();
	}

	@Override
	public List<SelectResultVo> getSeriesList() {
		return fundMapper.getSeriesList();
	}

	@Override
	public int hasBuyFund(Long userSecondId, Long fundId) {
		return fundMapper.hasBuyFund(userSecondId, fundId);
	}

	@Override
	public int getMaxIndex() {
		return fundMapper.getMaxIndex();
	}
}
