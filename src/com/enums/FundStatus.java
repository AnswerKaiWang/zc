package com.enums;

public enum FundStatus {

	rengouqi,cunxuqi,jieshuqi;
	
	 private String description;


		public String getDescription() {
			if(this.equals(FundStatus.rengouqi)){
				return "认购期";
			}
			if(this.equals(FundStatus.cunxuqi)){
				return "存续期";
			}
			if(this.equals(FundStatus.jieshuqi)){
				return "结束期";
			}
			return "";
		}
		
		public FundStatus get(String description){
			FundStatus[] cardTypes=FundStatus.values();
			for (FundStatus cardType : cardTypes) {
				if(cardType.getDescription().equals(description)){
					return cardType;
				}
			}
			return null;
		}
}
