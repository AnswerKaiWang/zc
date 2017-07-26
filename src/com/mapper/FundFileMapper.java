package com.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bo.FundFileBo;
import com.bo.FundFileVo;
import com.common.Pager;
import com.entity.FundFile;

import tk.mybatis.mapper.common.Mapper;

public interface FundFileMapper extends Mapper<FundFile>{

	List<FundFileVo> getList(@Param("pager")Pager<FundFileVo> pager, @Param("bo")FundFileBo fundFileBo);

	List<FundFile> getFrontList(@Param("fundId")Long fundId);


}
