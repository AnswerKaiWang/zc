/*
 * syb
 * syb
 * syb
 */
package com.util;

import java.beans.PropertyEditorSupport;

public class IntCleanEditor extends PropertyEditorSupport {



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
				setValue(0);
			}else{
				setValue(Integer.parseInt(value));
			}
		} else {
			setValue(0);
		}
	}

}