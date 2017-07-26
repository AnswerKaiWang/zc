package com.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.common.Pager;
import com.entity.Member;

import tk.mybatis.mapper.common.Mapper;

public interface MemberMapper extends Mapper<Member>{

	Member getByUserName(@Param("userName")String userName);

	List<Member> getList(@Param("pager")Pager<Member> pager, @Param("bo")Member member);

}
