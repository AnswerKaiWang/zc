/**
 * 
 */
package com.util;

import java.io.IOException;
import java.net.ConnectException;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

/**
 * 
 * @author	tyb
 * @date	2016年8月30日下午3:08:25
 * @desc
 */
public final class HttpHelper {
	
	private HttpHelper(){}
	
	public static void main(String[] args){
		String url = "http://121.196.244.25:9999/repo/1/patient/402881ce53e9a44f0153e9a6093c0000/target";
		System.out.println(doGet(url));
	}
	
	public static final String doGet(String url,Map<String,String> params){
		CloseableHttpClient client = HttpClients.createDefault();
		HttpGet doGet = new HttpGet(url);
		try {
			if( null != params && params.keySet().size()>0){
				for(String key: params.keySet()){
					doGet.addHeader(key, params.get(key));
				}
			}
			CloseableHttpResponse resp = client.execute(doGet);
			int status = resp.getStatusLine().getStatusCode();
			if(status >= 400){
				
			}
			HttpEntity result = resp.getEntity();
			return StringUtils.toEncodedString(EntityUtils.toByteArray(result), Charset.forName("UTF-8"));
		} catch (ClientProtocolException e) {
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	public static final String doGet(String url,Map<String,String> headers,Map<String,String> params){
		CloseableHttpClient client = HttpClients.createDefault();
		HttpGet doGet = new HttpGet(url);
		try {
			if( null != headers && headers.keySet().size()>0){
				for(String key: headers.keySet()){
					doGet.addHeader(key, headers.get(key));
				}
			}
			CloseableHttpResponse resp = client.execute(doGet);
			int status = resp.getStatusLine().getStatusCode();
			if(status >= 400){
			}
			HttpEntity result = resp.getEntity();
			return StringUtils.toEncodedString(EntityUtils.toByteArray(result), Charset.forName("UTF-8"));
		} catch (ClientProtocolException e) {
		} catch (IOException e) {
			if(e instanceof ConnectException){
			}else{
				e.printStackTrace();
			}
		}
		return null;
	}
	
	public static final String doGet(String url){
		CloseableHttpClient client = HttpClients.createDefault();
		HttpGet doGet = new HttpGet(url);
		try {
			CloseableHttpResponse resp = client.execute(doGet);
			HttpEntity result = resp.getEntity();
			return StringUtils.toEncodedString(EntityUtils.toByteArray(result), Charset.forName("UTF-8"));
		} catch (ClientProtocolException e) {
		} catch (IOException e) {
			if(e instanceof ConnectException){
				
			}else{
				e.printStackTrace();
			}
		}
		return null;
	}
	
	public static final String doPost(String url, Map<String,String> params){
		CloseableHttpClient client = HttpClients.createDefault();
		HttpPost req = new HttpPost(url);
		try {
			if(null != params){
				List<NameValuePair> ps = new ArrayList<NameValuePair>();
				Iterator<String> it = params.keySet().iterator();
				while(it.hasNext()){
					String key = it.next();
					ps.add(new BasicNameValuePair(key,params.get(key)));
				}
				req.setEntity(new UrlEncodedFormEntity(ps));
			}
			CloseableHttpResponse resp = client.execute(req);
			int status = resp.getStatusLine().getStatusCode();
			if(status >= 400){
			}
			HttpEntity result = resp.getEntity();
			return StringUtils.toEncodedString(EntityUtils.toByteArray(result), Charset.forName("UTF-8"));
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	public static final String doPost(String url, Map<String,String> params, Map<String,String> headers){
		CloseableHttpClient client = HttpClients.createDefault();
		HttpPost req = new HttpPost(url);
		try {
			if(headers != null){
				for(String key: headers.keySet()){
					req.setHeader(key, headers.get(key));
				}
			}
			if(null != params){
				List<NameValuePair> ps = new ArrayList<NameValuePair>();
				Iterator<String> it = params.keySet().iterator();
				while(it.hasNext()){
					String key = it.next();
					ps.add(new BasicNameValuePair(key,params.get(key)));
				}
				req.setEntity(new UrlEncodedFormEntity(ps));
			}
			CloseableHttpResponse resp = client.execute(req);
			int status = resp.getStatusLine().getStatusCode();
			if(status >= 400){
			}
			HttpEntity result = resp.getEntity();
			return StringUtils.toEncodedString(EntityUtils.toByteArray(result), Charset.forName("UTF-8"));
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	public static final String doPost(String url, String body, Map<String,String> headers){
		CloseableHttpClient client = HttpClients.createDefault();
		HttpPost req = new HttpPost(url);
		try {
			if(headers != null){
				for(String key: headers.keySet()){
					req.setHeader(key, headers.get(key));
				}
			}
			req.setHeader("Content-Type", "application/json");
			req.setHeader("Accept", "application/json");
			req.setEntity(new StringEntity(body, Charset.forName("UTF-8")));
			CloseableHttpResponse resp = client.execute(req);
			int status = resp.getStatusLine().getStatusCode();
			if(status >= 400){
			}
			HttpEntity result = resp.getEntity();
			return StringUtils.toEncodedString(EntityUtils.toByteArray(result), Charset.forName("UTF-8"));
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
}
