package com.bo;

import com.entity.UserApply;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserApplyVo extends UserApply{
	private static final long serialVersionUID = 1L;
	private String fundName;
	private String custName;
	private String custNo;
	private String confirUserName;
	private String phone;
}
