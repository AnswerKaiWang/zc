package com.service;

import java.util.List;

import com.bo.FundBo;
import com.bo.FundEditVo;
import com.bo.FundSaveBo;
import com.bo.SelectResultVo;
import com.bo.UserCurrentBo;
import com.bo.cura.ProductBo;
import com.bo.cura.ProductVo;
import com.common.Pager;
import com.entity.Fund;
import com.github.pagehelper.PageInfo;

public interface FundService extends BaseService<Fund>{

	Pager<Fund> getList(Pager<Fund> pager, FundBo fundBo);

	List<String> getTypeByGroup();

	List<Fund> getFundsByCompanyId(Long companyId);

	void saveList(List<Fund> funds);

	Fund getFunByNo(String no);

	PageInfo<Fund> getFunds(Integer page, UserCurrentBo userCurrentBo);

	Fund getFunByBei(String bei);
	
	List<Fund> searchFundList(String search);
	
	void saveFund(FundSaveBo fund);
	
	void updateFund(FundSaveBo fund);
	
	FundEditVo findDetailById(Long id);
	
	//前端产品列表，带分页
	List<ProductVo> cruaList(ProductBo bo);
	/**
	 * 产品数量
	 * @param bo
	 * @return
	 */
	int curaCount(ProductBo bo);
	/**
	 * 产品系类名称
	 * @return
	 */
	List<SelectResultVo> getSeriesList();
	/**
	 * 产品页面banner
	 * @return
	 */
	List<ProductVo> curaBannerList();
	
	int hasBuyFund(Long userSecondId,Long fundId);
	
	int getMaxIndex();
}
