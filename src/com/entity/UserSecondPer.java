package com.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Id;

import lombok.Getter;
import lombok.Setter;

/**
 * 个人客户
 */
@Getter
@Setter
public class UserSecondPer implements Serializable{

	private static final long serialVersionUID = -6825487999539406113L;
	@Id
	private Long id;//客户id
	
	private String perName;//姓名
	
	private Integer perSex;//性别
	
	private Long perCardTypeId;//证件类型
	
	private String perCardNo;//证件号码
	
	private String perQixian;//有效期
	
	private String perJiguan;//发证机关
	
	private String perPhone;//手机
	
	private String perTel;//座机
	
	private String perEmail;//邮箱
	
	private String perZip;//邮编
	
	private Long perCityId;//城市
	
	private String perAddr;//地址
	
	private Date perBirthday;//生日

	private Long perCountryId;//国籍
	
	private String ziranPer;//实际控制客户的自然人
	
	private String shouyiPer;//实际受益人
	
	private Long perZhiyeId;//职业类型
	
	private Long perHangyeId;//行业
	
	private Long perXueliId;//学历
	
	private String gongzuoCompany;//工作单位
	
	private String gongzuoZhiwei;//职位
	
	private String province;
	private String city;
}
