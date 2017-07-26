/**
 * 
 */
package com.util;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.concurrent.ThreadLocalRandom;

/**
 * @author	tyb
 * @date	2016年8月21日下午12:59:35
 * @desc	
 */
public final class SMSUtils {
	//【中城投资】尊敬的客户，您的验证码为：XXXXXX，有效时间120秒。如非本人操作，请联系客服。
	private static final String SIGN = "中城投资";
	private static final String DEF_CHARSET = "UTF-8";
	//private static final String ENTRY_PWD = "89890CC11E9B2EDDB4C6C59211F5";//接口密码，睡着用户名而变化 daqiao
	private static final String ENTRY_PWD = "A61E3FC309C0D03530651E7CB0A9";
	private static String BASE_URL = "http://web.duanxinwang.cc/asmx/smsservice.aspx?name=zcdx&pwd="+ENTRY_PWD
			+"&stime=&type=pt&extno=";
	private static final ThreadLocalRandom rnd = ThreadLocalRandom.current();
	public static void main(String[] args){
		String content = "尊敬的客户，您的验证码为：999999，有效时间120秒。如非本人操作，请联系客服。";
		System.out.println(HttpHelper.doGet(BASE_URL+"&mobile=13601685139&content="+content));;
	}
	
	static{
		try {
			BASE_URL = BASE_URL+"&sign="+URLEncoder.encode(SIGN, DEF_CHARSET);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}
	/**
	 * 随机生成一个验证码
	 * @return
	 */
	public static String rndCode(){
		return String.valueOf(rnd.nextInt(100000, 999999));
	}
	/**
	 * 邮箱验证码
	 * @return
	 */
	public static String rndEmailCode(){
		return String.valueOf(rnd.nextInt(10000000, 99999999));
	}
	
	/**
	 * 发送短信
	 * @param telphone
	 * @param content
	 */
	public static void send(String telephone, String content){
		content = "尊敬的客户，您的验证码为："+content+"，有效时间120秒。如非本人操作，请联系客服。";
		HttpHelper.doGet(BASE_URL+"&mobile="+telephone+"&content="+content);
	}
}
