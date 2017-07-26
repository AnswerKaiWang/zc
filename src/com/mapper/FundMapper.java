package com.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bo.FundBo;
import com.bo.FundEditVo;
import com.bo.SelectResultVo;
import com.bo.UserCurrentBo;
import com.bo.cura.ProductBo;
import com.bo.cura.ProductVo;
import com.common.Pager;
import com.entity.Fund;

import tk.mybatis.mapper.common.Mapper;

public interface FundMapper extends Mapper<Fund>{

	List<Fund> getList(@Param("pager")Pager<Fund> pager, @Param("bo")FundBo fundBo);

	List<String> getTypeByGroup();

	List<Fund> getFrontList(@Param("bo")UserCurrentBo userCurrentBo);
	
	FundEditVo findDetailById(@Param("id") Long id);
	
	List<ProductVo> cruaList(@Param("bo") ProductBo bo);
	
	int cruaCount(@Param("bo") ProductBo bo);
	
	
	Integer cruaListCount(@Param("bo") ProductBo bo);
	
	List<SelectResultVo> getSeriesList();
	
	List<ProductVo> curaBannerList();
	
	int hasBuyFund(@Param("userSecondId") Long userSecondId, @Param("fundId") Long fundId);
	
	Integer getMaxIndex();
}
