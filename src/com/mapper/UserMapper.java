package com.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bo.UserBo;
import com.bo.UserVo;
import com.common.Pager;
import com.entity.User;

import tk.mybatis.mapper.common.Mapper;

public interface UserMapper extends Mapper<User>{

	List<UserVo> getList(@Param("pager")Pager<UserVo> pager, @Param("bo")UserBo userBo);



}
