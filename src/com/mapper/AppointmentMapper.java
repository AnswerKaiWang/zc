/**
 * 
 */
package com.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bo.cura.AppointmentBo;
import com.common.Pager;
import com.entity.Appointment;

import tk.mybatis.mapper.common.Mapper;

/**
 * @author	tyb
 * @date	2016年9月6日上午11:33:45
 * @desc	
 */
public interface AppointmentMapper extends Mapper<Appointment> {
	List<Appointment> getList(@Param("pager")Pager<Appointment> pager, @Param("bo") AppointmentBo bo);
}
