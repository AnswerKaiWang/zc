/**
 * 
 */
package com.bo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.entity.FundRecord;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年8月26日下午9:31:33
 * @desc	
 */
@Getter
@Setter
public class FundSaveBo implements Serializable {

	private static final long serialVersionUID = 1L;
	private Long id;
	private Long companyId;//公司编号
	private String no;//产品代码
	private String seriesName;
	private String name;//名字
	private String type;//产品类型
	private String lawWay;
	private Integer riskLevel;
	private Integer fundStatus;//基金状态
	private Integer showStatus;//0显示 1不显示
	private String  beiNo;
	private String manager;//基金管理人
	private String truster;//委托人
	private String size;//规模
	private Long startPerMoney;
	private Long startComMoney;
	private Long incrMoney;
	private String deadline;//截止时间
	private String storePeriod;//存续期
	private String duration;//收益分配周期
	private String setupTime;
	private String cashTime;
	private String collectStartTime;
	private String collectEndTime;
	private String buyStartTime;
	private String buyEndTime;
	private String fundManager;//基金经理
	private String gpFund;
	private String planCollectMoney;
	private String trustInfo;//托管信息
	private String trustNo;//托管编码
	private Long pageIndex =0L;//前台排序越大越靠前
	private Date createTime;
	private String fundIntro;//产品介绍
	private String fundDetail;//产品详情
	private String fundStrategy;
	private String fundNature;//产品特点，列表使用
	private Integer frontStatus;//默认0:1:前端banner显示
	private String cover;//前端banner显示时图片
	List<FundRecord> records = new ArrayList<>();
}
