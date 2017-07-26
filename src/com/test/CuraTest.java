/**
 * 
 */
package com.test;

import org.apache.commons.codec.digest.DigestUtils;

/**
 * @author	tyb
 * @date	2016年9月4日下午2:51:23
 * @desc	
 */
public final class CuraTest {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		System.out.println(DigestUtils.md5Hex("123456"));
	}

}
