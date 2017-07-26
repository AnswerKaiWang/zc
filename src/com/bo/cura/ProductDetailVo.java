/**
 * 
 */
package com.bo.cura;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年9月2日上午9:36:35
 * @desc	
 */
@Getter
@Setter
public class ProductDetailVo implements Serializable {
	private static final long serialVersionUID = 1L;
	private Long id;
	private Long companyId;//公司编号
	private String companyName;
	private String no;//产品代码
	private String seriesName;
	private String name;//名字
	private String type;//产品类型
	private String lawWay;
	private Integer riskLevel;
	private String riskName;
	private Integer fundStatus;//基金状态
	private String statusName;
	private Integer showStatus;//0显示 1不显示
	private String  beiNo;
	private String manager;//基金管理人
	private String truster;//委托人
	private String size;//规模
	private Long startPerMoney;
	private String startPerMoneyStr;
	private Long startComMoney;
	private String startComMoneyStr;
	private Long incrMoney;
	private String incrMoneyStr;
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
	private Long gpFund;
	private Long planCollectMoney;
	private String trustInfo;//托管信息
	private String trustNo;//托管编码
	private long pageIndex;//前台排序越大越靠前
	private String fundIntro;//产品介绍
	private String fundDetail;//产品详情
	private String fundStrategy;
}
