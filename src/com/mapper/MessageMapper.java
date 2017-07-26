/**
 * 
 */
package com.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bo.MessageBo;
import com.bo.MessageUserBo;
import com.bo.MessageUserVo;
import com.common.Pager;
import com.entity.Message;

import tk.mybatis.mapper.common.Mapper;

/**
 * @author	tyb
 * @date	2016年9月6日上午11:33:45
 * @desc	
 */
public interface MessageMapper extends Mapper<Message> {
	List<Message> getList(@Param("pager")Pager<Message> pager, @Param("bo") MessageBo bo);
	
	List<MessageUserVo> findMessageUsers(@Param("pager")Pager<MessageUserVo> pager, @Param("bo") MessageUserBo bo);
	
	List<Message> curaMessageList(@Param("pageSize") Integer pageSize, @Param("start") Integer start,@Param("toUid") Long toUid);
	
	Integer getUnreadCount(@Param("toUid") Long toUid);
}
