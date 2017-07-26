/**
 * 
 */
package com.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bo.AgreementVo;
import com.bo.cura.AppointmentBo;
import com.common.Pager;
import com.entity.Appointment;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mapper.AppointmentMapper;
import com.service.AppointmentService;

/**
 * @author	tyb
 * @date	2016年9月6日下午12:08:32
 * @desc	
 */
@Service("appointmentService")
public class AppointmentServiceImpl extends BaseServiceImpl<Appointment> implements AppointmentService {
	
	@Autowired
	private AppointmentMapper appointmentMapper;

	@Override
	public Pager<Appointment> getList(Pager<Appointment> pager, AppointmentBo bo) {
		if(pager.getUsePager()){
			PageHelper.offsetPage(pager.getOffset(), pager.getLimit());
		}
		List<Appointment> members=appointmentMapper.getList(pager,bo);
		pager.setRows(members);
		PageInfo<Appointment> pageInfo=new PageInfo<Appointment>(members);
		pager.setTotal(pageInfo.getTotal());
		return pager;
	}
}
