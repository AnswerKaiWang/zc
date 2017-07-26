/**
 * 
 */
package com.util;

import lombok.Getter;
import lombok.Setter;

/**
 * @author	tyb
 * @date	2016年8月21日下午1:13:12
 * @desc	
 */
@Getter
@Setter
public class SMS {
	private String name;//用户账号
	private String pwd;//接口密码
	private String content;//1-500汉子，UTF-8编码
	private String mobile;
	private String stime;//发送时间，不填为当前时间
	private String sign;//必填，签名
	private String type = "pt";//
	private Integer extno;//扩展码
}
