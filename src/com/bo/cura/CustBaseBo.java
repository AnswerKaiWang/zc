/**
 * 
 */
package com.bo.cura;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月5日下午4:09:19
 * @desc	
 */
@Getter
@Setter
public class CustBaseBo implements Serializable {
	private static final long serialVersionUID = 7132124866711555124L;
	private Long id;//user secondId
	//第一步
	private Integer sex;
	private String name;//姓名
	private String conTel;//固话
	private String conEmail;
	private String province;
	private String city;
	private String conZip;
	private String conAddr;
	private String welcomeCode;
	private String cardType;
	private String cardNo;
	private String valiateTime;
	private String fzCompany;
	private String birth;
	
	//第二步
	private String jobId;
	private String industryId;
	private String company;
	private String duty;
	private String education;
	private String country;
	private String income;
	private String truster;
	private String canInvestAmount;
	private String trusterPhone;
	
	private Long productId;
}
