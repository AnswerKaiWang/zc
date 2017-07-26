package com.service;

import java.util.List;

import com.bo.FundFileBo;
import com.bo.FundFileVo;
import com.common.Pager;
import com.entity.FundFile;

public interface FundFileService extends BaseService<FundFile>{

	Pager<FundFileVo> getList(Pager<FundFileVo> pager, FundFileBo fundFileBo);

	List<FundFile> getFrontList(Long id);


}
