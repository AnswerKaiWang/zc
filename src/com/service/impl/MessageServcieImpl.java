/**
 * 
 */
package com.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bo.MessageBo;
import com.bo.MessageUserBo;
import com.bo.MessageUserVo;
import com.common.Pager;
import com.entity.Message;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mapper.MessageMapper;
import com.service.MessageService;

/**
 * @author	tyb
 * @date	2016年9月11日上午7:57:47
 * @desc	
 */
@Service("messageService")
public class MessageServcieImpl extends BaseServiceImpl<Message> implements MessageService {

	@Autowired
	private MessageMapper messageMapper;

	@Override
	public Pager<Message> getList(Pager<Message> pager, MessageBo bo) {
		if(pager.getUsePager()){
			PageHelper.offsetPage(pager.getOffset(), pager.getLimit());
		}
		List<Message> members=messageMapper.getList(pager,bo);
		pager.setRows(members);
		PageInfo<Message> pageInfo=new PageInfo<Message>(members);
		pager.setTotal(pageInfo.getTotal());
		return pager;
	}
	
	@Override
	public Pager<MessageUserVo> getUserList(Pager<MessageUserVo> pager, MessageUserBo bo) {
		if(pager.getUsePager()){
			PageHelper.offsetPage(pager.getOffset(), pager.getLimit());
		}
		List<MessageUserVo> members=messageMapper.findMessageUsers(pager,bo);
		pager.setRows(members);
		PageInfo<MessageUserVo> pageInfo=new PageInfo<MessageUserVo>(members);
		pager.setTotal(pageInfo.getTotal());
		return pager;
	}



	@Override
	public List<Message> curaMessageList(Integer pageSize, Integer start, Long toUid) {
		start = ((start-1)*pageSize);
		return messageMapper.curaMessageList(pageSize,start,toUid);
	}

	@Override
	public Integer getUnreadCount(Long toUid) {
		return messageMapper.getUnreadCount(toUid);
	}

	@Override
	public void sendMsg(Long[] ids, String content,Long userId) {
		for(Long id: ids){
			Message msg = new Message();
			msg.setFromUid(userId);
			msg.setToUid(id);
			msg.setContent(content);
			msg.setCreateTime(new Date());
			msg.setUpdateTime(new Date());
			msg.setReaded(0);
			save(msg);
		}
	}
}
