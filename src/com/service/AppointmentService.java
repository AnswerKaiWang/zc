/**
 * 
 */
package com.service;

import com.bo.cura.AppointmentBo;
import com.common.Pager;
import com.entity.Appointment;

/**
 * @author	tyb
 * @date	2016年9月6日上午11:34:24
 * @desc	
 */
public interface AppointmentService extends BaseService<Appointment> {
	Pager<Appointment> getList(Pager<Appointment> pager, AppointmentBo bo);
}
