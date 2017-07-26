package com.common;

import java.io.Serializable;

public class LogConfig implements Serializable {

	private static final long serialVersionUID = -1108848647938408402L;

	private String name;

	private String urlPattern;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUrlPattern() {
		return urlPattern;
	}

	public void setUrlPattern(String urlPattern) {
		this.urlPattern = urlPattern;
	}

}