/**
 * 
 */
package com.service;

import java.util.List;

import com.bo.MessageBo;
import com.bo.MessageUserBo;
import com.bo.MessageUserVo;
import com.common.Pager;
import com.entity.Message;

/**
 * @author	tyb
 * @date	2016年9月11日上午7:57:02
 * @desc	
 */
public interface MessageService extends BaseService<Message> {
	
	Pager<Message> getList(Pager<Message> pager, MessageBo bo);
	/**
	 * 用户
	 * @param pager
	 * @param bo
	 * @return
	 */
	Pager<MessageUserVo> getUserList(Pager<MessageUserVo> pager, MessageUserBo bo);
	
	List<Message> curaMessageList(Integer pageSize, Integer start, Long toUid);
	
	/**
	 * 未读消息
	 * @param toUid
	 * @return
	 */
	Integer getUnreadCount(Long toUid);
	
	void sendMsg(Long[] ids, String content,Long userId);
}
