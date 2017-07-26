/**
 * 
 */
package com.bo.cura;

import java.io.Serializable;
import java.util.Date;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月1日下午9:17:57
 * @desc	登录
 */
@Getter
@Setter
public class LoginVo implements Serializable {
	private static final long serialVersionUID = 1L;
	private String name;
	private String userType;//用户类型
	private String password;//密码
	private Long userSecondId;//用户ID
	private String message;//错误信息
	private String level;//客户等级
	private String type;//客户类型
	private String riskLevel;//风险等级
	private String riskLevelName;
	private Integer expired = 0;
	private Date evaluationTime;//测评时间
	private Integer integral;//积分
	private Long amount;//在投金额
	private String welcomeCode;
	
	private Integer jobId;//职业
	private Integer industryId;//行业
	private String company;//公司
	private String duty;//职务
	private Integer education;//学历
	private Integer nation;//国籍
	private Integer income;//收入
	private String trusterName;//委托人姓名
	private Long canInvestAmount;//可投金额
	private String trusterPhone;//委托人电话
	private String phone;
	private String cardNo;
	private Integer gender;
	private String custNo;
	private String consultId;
	private String consultName;
	private String consultPhone;
	
	private Long countryId;
	private Long cityId;
	private String zip;
	private String tel;
	private String email;
	private String addr;
	private String comCode;
	private String shuiwu;
	private String kaihu;
	private String xinyong;
	private String welcome;
	private Long cardTypeId;
	private String qixian;
	private String jiguan;
	private String birth;
	
	private Integer unread;
}
