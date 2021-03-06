package com.entity;

import java.io.Serializable;

import javax.persistence.Id;

import lombok.Getter;
import lombok.Setter;

/**
 * 客户机构类型字段
 */
@Getter
@Setter
public class UserSecondCom implements Serializable{

	private static final long serialVersionUID = -6825487999539406113L;
	@Id
	private Long id;//客户id
	
	private String saleRound;//经营范围
	
	private String zhizhao;//营业执照
	
	private String qixian;//证照期限
	
	private String daima;//组织机构代码
	
	private String shuiwu;//税务登记证
	
	private String kaihu;//开户许可
	
	private String xinyong;//机构信用
	
	private String comPhone;//电话
	
	private String comTel;//
	private String comEmail;
	
	private String comZip;//邮编
	
	private String comAddr;//地址
	
	private String realControllerName;//实际控制人
	
	private String realAddr;//实际控制人住所
	
	private String faName;//法定代表人姓名
	
	private Long faCardTypeId;//法定代表人证件类型
	
	private String faCardNo;//法定代表人证件号码
	
	private String faQixian;//法定代表人证件期限
	
	private Boolean faSex;//性别
	
	private Long comCityId;
	
	private String province;
	private String city;
}
