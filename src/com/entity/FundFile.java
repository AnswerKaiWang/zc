package com.entity;

import java.util.Date;

import com.enums.FundFileType;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.util.JsonDateSerialize;

/**
 * 基金文件
 * @author Administrator
 *
 */
public class FundFile extends BaseEntity{

	private static final long serialVersionUID = 4947367024084050582L;

	private Long fundId;//基金编号
	
	private String name;//名称
	
	private String contant;//基本信息
	
	private String url;//链接
	
	private FundFileType type;//类型

	private Date beginTime;//发布时间
	
	private long pageIndex;//排序越大越靠前
	
	private int showStatus;//0显示 1不显示
	
	private Long companyId;//公司编号
	
	public Long getFundId() {
		return fundId;
	}

	public void setFundId(Long fundId) {
		this.fundId = fundId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public FundFileType getType() {
		return type;
	}

	public void setType(FundFileType type) {
		this.type = type;
	}

	@JsonSerialize(using=JsonDateSerialize.class)
	public Date getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(Date beginTime) {
		this.beginTime = beginTime;
	}


	public long getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(long pageIndex) {
		this.pageIndex = pageIndex;
	}

	public int getShowStatus() {
		return showStatus;
	}

	public void setShowStatus(int showStatus) {
		this.showStatus = showStatus;
	}

	public Long getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Long companyId) {
		this.companyId = companyId;
	}

	public String getContant() {
		return contant;
	}

	public void setContant(String contant) {
		this.contant = contant;
	}
	
	
}
