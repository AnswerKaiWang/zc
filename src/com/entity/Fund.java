package com.entity;

import lombok.Getter;
import lombok.Setter;

/**
 * 基金
 * @author Administrator
 *
 */
@Getter
@Setter
public class Fund extends BaseEntity{
	private static final long serialVersionUID = 4300793317881927309L;
	private Long companyId;//基金管理人
	private String no;//产品代码
	private String seriesName;
	private String name;//名字
	private String type;//产品类型
	private String lawWay;//法律形式
	private Integer riskLevel;
	private Integer fundStatus;//基金状态
	private Integer showStatus;//0显示 1不显示
	private String  beiNo;//备案号
	private String manager;//基金管理人
	private String truster;//委托人
	private String size;//规模
	private Long startPerMoney;//起投金额，个人
	private Long startComMoney;//起投金额，公司
	private Long incrMoney;//递增金额
	private String deadline;//截止时间
	private String storePeriod;//存续期
	private String duration;//收益分配周期
	private String setupTime;//成立时间
	private String cashTime;//清算时间
	private String collectStartTime;//募集开始时间
	private String collectEndTime;//募集结束时间
	private String buyStartTime;//购买
	private String buyEndTime;//
	private String fundManager;//基金经理
	private String gpFund;
	private String planCollectMoney;
	private String trustInfo;//托管信息
	private String trustNo;//托管编码
	private Long pageIndex;//前台排序越大越靠前
	
	private Integer frontStatus;//默认0:1:前端banner显示
	private String cover;//前端banner显示时图片
	private String fundIntro;//产品介绍
	private String fundStrategy;//产品策略
	private String fundDetail;//产品详情
	private String fundNature;//产品特点，列表使用
}
