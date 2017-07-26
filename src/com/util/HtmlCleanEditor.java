package com.util;

import java.beans.PropertyEditorSupport;

public class HtmlCleanEditor extends PropertyEditorSupport {

	private boolean trim;

	private boolean emptyAsNull;

	public HtmlCleanEditor(boolean trim, boolean emptyAsNull) {
		this.trim = trim;
		this.emptyAsNull = emptyAsNull;
	}

	@Override
	public String getAsText() {
		Object value = getValue();
		return value != null ? value.toString() : "";
	}

	@Override
	public void setAsText(String text) {
		if (text != null) {
			String value = trim ? text.trim() : text;
			if (emptyAsNull && "".equals(value)) {
				value = null;
			}
			setValue(value);
		} else {
			setValue(null);
		}
	}

}