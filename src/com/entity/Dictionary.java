package com.entity;

import com.enums.DictionaryType;

/**
 * 字典类
 */
public class Dictionary extends BaseEntity {

	private static final long serialVersionUID = -5614509908716116867L;

	private DictionaryType type;
	
	private String name;
	
	private String note;

	

	public DictionaryType getType() {
		return type;
	}

	public void setType(DictionaryType type) {
		this.type = type;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}
	
	
}
