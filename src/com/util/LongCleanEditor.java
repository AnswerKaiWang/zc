/*
 * syb
 * syb
 * syb
 */
package com.util;

import java.beans.PropertyEditorSupport;

public class LongCleanEditor extends PropertyEditorSupport {



	@Override
	public String getAsText() {
		Object value = getValue();
		return value != null ? value.toString() : "";
	}

	@Override
	public void setAsText(String text) {
		if (text != null) {
			String value = text.trim();
			if ("".equals(value)) {
				setValue(0l);
			}else{
				setValue(Long.parseLong(value));
			}
		} else {
			setValue(0l);
		}
	}

}