package com.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bo.UserSecondPicVO;
import com.entity.UserSecondPic;

import tk.mybatis.mapper.common.Mapper;

public interface UserSecondPicMapper extends Mapper<UserSecondPic>{
	
	/**
	 * 
	 * @param id
	 * @return
	 */
	UserSecondPicVO findById(Long id);
	
	/**
	 * 
	 * @param custId
	 * @return
	 */
	List<UserSecondPicVO> findByCustId(@Param("id") Long custId);
	
	/**
	 * 更新图片证照信息
	 * @param entity
	 */
	void updatePic(UserSecondPic entity);
	/**
	 * 删除图片
	 * @param id
	 */
	void delPicsByPid(@Param("id") Long id);
}
