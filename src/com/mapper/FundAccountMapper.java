package com.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bo.FundAccountBo;
import com.bo.FundAccountVo;
import com.common.Pager;
import com.entity.FundAccount;

import tk.mybatis.mapper.common.Mapper;

public interface FundAccountMapper extends Mapper<FundAccount>{

	List<FundAccountVo> getList(@Param("pager")Pager<FundAccountVo> pager, @Param("bo")FundAccountBo fundAccountBo);

	List<FundAccount> getFrontList(@Param("fundId")Long fundId);


}
