package com.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Transient;

/**
 * 实体基础类
 * 其他实体类应继承此类,用来得到对应的时间
 * @author syblike 
 * @Date 2016-04-29
 */
public abstract class BaseEntity implements Serializable {

	private static final long serialVersionUID = -1108247923032612615L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	private Date createTime;

	private Date updateTime;

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	@Override
	@Transient
	public boolean equals(Object object) {
		if (object == null) {
			return false;
		}
		if (object instanceof BaseEntity) {
			BaseEntity baseEntity = (BaseEntity) object;
			if (this.getId() == null || baseEntity.getId() == null) {
				return false;
			} else {
				return (this.getId().equals(baseEntity.getId()));
			}
		}
		return false;
	}
	
}