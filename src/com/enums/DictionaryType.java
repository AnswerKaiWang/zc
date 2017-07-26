package com.enums;

public enum  DictionaryType {
 
	userLevel,infoSource,customerSource,yearIncome,city,country,zhiye,
	suoshuhangye,xueli,perCardType,yuYueType,yuYueStatus,riskLevel,zhengzhaotype,
	fundType,fundLawWay,fundRiskLevel,fundStatus,fundDuration,
	questionType,activityType,qsType;
	 	private String description;
		public String getDescription() {
			if(this.equals(DictionaryType.userLevel)){
				return "会员等级";
			}
			if(this.equals(DictionaryType.infoSource)){
				return "信息来源";
			}
			if(this.equals(DictionaryType.customerSource)){
				return "客户来源";
			}
			if(this.equals(DictionaryType.yearIncome)){
				return "年收入";
			}
			if(this.equals(DictionaryType.city)){
				return "城市";
			}
			if(this.equals(DictionaryType.country)){
				return "国籍";
			}
			if(this.equals(DictionaryType.zhiye)){
				return "职业";
			}
			if(this.equals(DictionaryType.suoshuhangye)){
				return "所属行业";
			}
			if(this.equals(DictionaryType.xueli)){
				return "学历";
			}
			if(this.equals(DictionaryType.perCardType)){
				return "个人证件类型";
			}
			if(this.equals(DictionaryType.yuYueType)){
				return "预约类型";
			}
			if(this.equals(DictionaryType.yuYueStatus)){
				return "预约状态";
			}
			if(this.equals(DictionaryType.riskLevel)){
				return "风险等级";
			}
			if(this.equals(DictionaryType.zhengzhaotype)){
				return "证照类型";
			}
			if(this.equals(DictionaryType.fundType)){
				return "基金产品类别";
			}
			if(this.equals(DictionaryType.fundLawWay)){
				return "基金法律形式";
			}
			if(this.equals(DictionaryType.fundRiskLevel)){
				return "基金产品风险等级";
			}
			if(this.equals(DictionaryType.fundStatus)){
				return "基金产品状态";
			}
			if(this.equals(DictionaryType.fundDuration)){
				return "基金收益分配周期";
			}
			if(this.equals(DictionaryType.questionType)){
				return "题目类别";
			}
			if(this.equals(DictionaryType.activityType)){
				return "活动类型";
			}
			if(this.equals(DictionaryType.qsType)){
				return "调查问卷类别";
			}
			return "";
		}
		public DictionaryType get(String description){
			DictionaryType[] cardTypes=DictionaryType.values();
			for (DictionaryType cardType : cardTypes) {
				if(cardType.getDescription().equals(description)){
					return cardType;
				}
			}
			return null;
		}
}
