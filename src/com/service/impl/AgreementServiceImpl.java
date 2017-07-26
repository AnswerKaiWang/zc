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

import com.bo.AgreementAddBo;
import com.bo.AgreementBo;
import com.bo.AgreementVo;
import com.common.Pager;
import com.entity.Agreement;
import com.entity.AgreementFile;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mapper.AgreementFileMapper;
import com.mapper.AgreementMapper;
import com.service.AgreementService;

/**
 * @author	tyb
 * @date	2016年8月29日下午8:04:35
 * @desc	
 */
@Service("agreementService")
public class AgreementServiceImpl extends BaseServiceImpl<Agreement> implements AgreementService {
	
	@Autowired
	private AgreementMapper agreementMapper;
	
	@Autowired
	private AgreementFileMapper agreementFileMapper;
	
	@Override
	public Pager<AgreementVo> getList(Pager<AgreementVo> pager, AgreementBo bo) {
		if(pager.getUsePager()){
			PageHelper.offsetPage(pager.getOffset(), pager.getLimit());
		}
		List<AgreementVo> members=agreementMapper.getList(pager,bo);
		pager.setRows(members);
		PageInfo<AgreementVo> pageInfo=new PageInfo<AgreementVo>(members);
		pager.setTotal(pageInfo.getTotal());
		return pager;
	}

	@Override
	public void saveAgreement(AgreementAddBo bo) {
		if(bo != null){
			Agreement entity = new Agreement();
			BeanUtils.copyProperties(bo, entity);
			Date now = new Date();
			entity.setCreateTime(now);
			entity.setUpdateTime(now);
			agreementMapper.insert(entity);
			if(bo.getFiles() != null){
				for(AgreementFile record: bo.getFiles()){
					if(StringUtils.isNotBlank(record.getName())){
						record.setAid(entity.getId());
						record.setCreateTime(now);
						record.setUpdateTime(now);
						agreementFileMapper.insert(record);
					}
				}
			}
		}
	}

	@Override
	public AgreementVo findDetailById(Long id) {
		return agreementMapper.findDetailById(id);
	}

	@Override
	public void updateAgreement(AgreementAddBo bo) {
		if(bo != null){
			Agreement entity = new Agreement();
			BeanUtils.copyProperties(bo, entity);
			Date now = new Date();
			entity.setCreateTime(now);
			entity.setUpdateTime(now);
			agreementMapper.updateByPrimaryKey(entity);
			//先删
			agreementFileMapper.delByAid(bo.getId());
			if(bo.getFiles() != null){
				for(AgreementFile record: bo.getFiles()){
					if(StringUtils.isNotBlank(record.getName())){
						record.setAid(entity.getId());
						record.setCreateTime(now);
						record.setUpdateTime(now);
						agreementFileMapper.insert(record);
					}
				}
			}
		}
	}

}
