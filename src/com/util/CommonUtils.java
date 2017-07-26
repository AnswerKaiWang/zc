package com.util;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Random;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.FormulaEvaluator;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.NumberToTextConverter;

public final class CommonUtils {
	
	private static final NumberFormat df = DecimalFormat.getCurrencyInstance();
	private static final NumberFormat df8 = DecimalFormat.getCurrencyInstance();
	static{
	}
	
	public static boolean isEmpty(String s) {
		return null == s || StringUtils.isEmpty(s.trim());
	}

	public static boolean isEmpty(Collection<?> s) {
		return null == s || s.isEmpty();
	}

	public static boolean isNotEmpty(Collection<?> s) {
		return !isEmpty(s);
	}

	public static boolean isNotEmpty(String redirect) {
		return !isEmpty(redirect);
	}

	public static Date stringToDate(String dateString) {
		if (CommonUtils.isEmpty(dateString)) {
			return null;
		}
		try {
			return DateUtils.parseDate(dateString, new String[] { "yyyy", "yyyy-MM", "yyyyMM", "yyyy/MM", "yyyy-MM-dd",
					"yyyyMMdd", "yyyy/MM/dd", "yyyy-MM-dd HH:mm:ss", "yyyyMMddHHmmss", "yyyy/MM/dd HH:mm:ss" });
		} catch (ParseException e) {
			return null;
		}

	}

	public static String nowDateToString(String format) {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(format);
		try {
			return simpleDateFormat.format(new Date());
		} catch (Exception e) {
			return null;
		}

	}

	public static String DateToString(Date date) {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			return simpleDateFormat.format(date);
		} catch (Exception e) {
			return null;
		}

	}

	public static String joinKeyValue(Map<String, Object> map, String prefix, String suffix, String separator,
			boolean ignoreEmptyValue, String... ignoreKeys) {
		List<String> list = new ArrayList<String>();
		if (map != null) {
			for (Entry<String, Object> entry : map.entrySet()) {
				String key = entry.getKey();
				String value = ConvertUtils.convert(entry.getValue());
				if (StringUtils.isNotEmpty(key) && !ArrayUtils.contains(ignoreKeys, key)
						&& (!ignoreEmptyValue || StringUtils.isNotEmpty(value))) {
					list.add(key + "=" + (value != null ? value : "") + "");
				}
			}
		}
		String s = (prefix != null ? prefix : "") + StringUtils.join(list, separator) + (suffix != null ? suffix : "");
		return s;
	}

	public static String joinKeyValue(Map<String, Object> map, String prefix, String suffix, String valuePrefix,
			String valueSuffix, String separator, boolean ignoreEmptyValue, String... ignoreKeys) {
		List<String> list = new ArrayList<String>();
		if (map != null) {
			for (Entry<String, Object> entry : map.entrySet()) {
				String key = entry.getKey();
				String value = ConvertUtils.convert(entry.getValue());
				if (StringUtils.isNotEmpty(key) && !ArrayUtils.contains(ignoreKeys, key)
						&& (!ignoreEmptyValue || StringUtils.isNotEmpty(value))) {
					list.add(key + "=" + valuePrefix + (value != null ? value : "") + valueSuffix);
				}
			}
		}
		String s = (prefix != null ? prefix : "") + StringUtils.join(list, separator) + (suffix != null ? suffix : "");
		return s;
	}

	public static String joinValue(Map<String, Object> map, String prefix, String suffix, String separator,
			boolean ignoreEmptyValue, String... ignoreKeys) {
		List<String> list = new ArrayList<String>();
		if (map != null) {
			for (Entry<String, Object> entry : map.entrySet()) {
				String key = entry.getKey();
				String value = ConvertUtils.convert(entry.getValue());
				if (StringUtils.isNotEmpty(key) && !ArrayUtils.contains(ignoreKeys, key)
						&& (!ignoreEmptyValue || StringUtils.isNotEmpty(value))) {
					list.add(value != null ? value : "");
				}
			}
		}
		return (prefix != null ? prefix : "") + StringUtils.join(list, separator) + (suffix != null ? suffix : "");
	}

	/**
	 * 生成短信验证码
	 * 
	 * @param length
	 *            验证码的长度
	 * @return
	 */
	public static String createRandomForSms(int length) { // length:验证码的长度
		String retStr = "";
		// String strTable = numberFlag ? "1234567890" :
		// "1234567890abcdefghijkmnpqrstuvwxyz";
		String strTable = "1234567890";
		int len = strTable.length();
		boolean bDone = true;
		do {
			retStr = "";
			int count = 0;
			for (int i = 0; i < length; i++) {
				double dblR = Math.random() * len;
				int intR = (int) Math.floor(dblR);
				char c = strTable.charAt(intR);
				if (('0' <= c) && (c <= '9')) {
					count++;
				}
				retStr += strTable.charAt(intR);
			}
			if (count >= 2) {
				bDone = false;
			}
		} while (bDone);

		return retStr;
	}

	// AJAX输出，返回null
	public static String ajax(HttpServletResponse response, String content, String type) {
		try {
			response.setContentType(type + ";charset=UTF-8");
			response.setHeader("Pragma", "No-cache");
			response.setHeader("Cache-Control", "no-cache");
			response.setDateHeader("Expires", 0);
			response.getWriter().write(content);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	public static String join(String str1, String str2) {
		String str = str1 == null ? "" : str1;
		return str + (str2 == null ? "" : str2);
	}

	/**
	 * 根据Map输出JSON,返回null
	 * 
	 * @param response
	 * @param object
	 *            需要序列化的对象
	 * @return
	 */
	public static String ajaxJson(HttpServletResponse response, Object object) {
		return CommonUtils.ajax(response, JsonUtils.toJson(object), "text/html;charset=UTF-8");
	}

	public static boolean isSameDate(Date date1, Date date2) {
		Calendar cal1 = Calendar.getInstance();
		cal1.setTime(date1);

		Calendar cal2 = Calendar.getInstance();
		cal2.setTime(date2);

		boolean isSameYear = cal1.get(Calendar.YEAR) == cal2.get(Calendar.YEAR);
		boolean isSameMonth = isSameYear && cal1.get(Calendar.MONTH) == cal2.get(Calendar.MONTH);
		boolean isSameDate = isSameMonth && cal1.get(Calendar.DAY_OF_MONTH) == cal2.get(Calendar.DAY_OF_MONTH);

		return isSameDate;
	}

	public static boolean da1MaxDa2(Date date1, Date date2) {
		Calendar cal1 = Calendar.getInstance();
		cal1.setTime(date1);

		Calendar cal2 = Calendar.getInstance();
		cal2.setTime(date2);

		boolean isSameYear = cal1.get(Calendar.YEAR) >= cal2.get(Calendar.YEAR);
		boolean isSameMonth = isSameYear && cal1.get(Calendar.MONTH) >= cal2.get(Calendar.MONTH);
		boolean isSameDate = isSameMonth && cal1.get(Calendar.DAY_OF_MONTH) > cal2.get(Calendar.DAY_OF_MONTH);

		return isSameDate;
	}

	public static Date getMoringDate(Date date) {
		Calendar calendar = DateUtils.toCalendar(date);
		calendar.set(Calendar.HOUR_OF_DAY, 0);
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);
		return calendar.getTime();
	}

	public static Date getEveningDate(Date date) {
		Calendar calendar = DateUtils.toCalendar(date);
		calendar.set(Calendar.HOUR_OF_DAY, 23);
		calendar.set(Calendar.MINUTE, 59);
		calendar.set(Calendar.SECOND, 59);
		return calendar.getTime();
	}
	/**
	 * 简单处理一下
	 * @param num
	 * @return
	 */
	public static String numToCn(Integer num){
		if(num <=10){
			switch (num) {
			case 1:
				return "一";
			case 2:
				return "二";
			case 3:
				return "三";
			case 4:
				return "四";
			case 5:
				return "五";
			case 6:
				return "六";
			case 7:
				return "七";
			case 8:
				return "八";
			case 9:
				return "九";
			case 10:
				return "十";

			default:
				break;
			}
		}
		return "";
	}
	
	/**
	 * 金额格式化 ###,###.00
	 * @param money
	 * @return
	 */
	public static String fmtMoney(Long money){
		if(money ==null){
			return "";
		}
		String rt = df.format(money);
		return rt.substring(1,rt.lastIndexOf("."));
	}
	
	/**
	 * #.###.##
	 * @param money
	 * @return
	 */
	public static String fmtMoney2(Long money){
		if(money ==null){
			return "";
		}
		String rt = df8.format(money);
		return rt.substring(1);
	}
	/**
	 * 分-转 万元  100040048000
	 * @param money
	 * @return
	 */
	public static String fmtW(Long money){
		BigDecimal bd = new BigDecimal(money);
		bd = bd.divide(new BigDecimal(10000000), 7, RoundingMode.HALF_UP);
		return fmtMoney2(bd.longValue());
	}
	
	/**
	 * 产品期限
	 * @param value
	 * @return
	 */
	public static String transDeadline(String value){
		if(StringUtils.isBlank(value)){
			return "";
		}
		String rt ="";
		value =  value.trim();
		int len = value.length();
		for(int i=0;i<len;i++){
			char av = value.charAt(i);
			if(av >=48 && av <=57){
				rt += av;
			}
		}
		if(rt ==""){
			return rt;
		}
		int month = Integer.valueOf(rt);
		if(month <12){
			return "半年";
		}else{
			return month/12+"";
		}
		
	}
	
	
	public static String kg(Long kg) {
		if (kg == null) {
			return "0.00";
		}
		return new BigDecimal(kg).divide(new BigDecimal(1000)).setScale(2, RoundingMode.DOWN).toString();
	}

	/**
	 * 分转元
	 * 
	 * @param money
	 * @return
	 */
	public static String money(Long money) {
		if (money == null) {
			return "0.00";
		}
		return new BigDecimal(money).divide(new BigDecimal(100)).setScale(2, RoundingMode.DOWN).toString();
	}

	/**
	 * 元转分
	 * 
	 * @param money
	 * @return
	 */
	public static Long money(String money) {
		if (CommonUtils.isEmpty(money)) {
			return null;
		}
		if (!money.matches("^[0-9]+(\\.[0-9]{1,2})?$")) {
			return null;
		}
		return new BigDecimal(money).multiply(new BigDecimal(100)).longValue();
	}

	/**
	 * 分转元
	 * 
	 * @param money
	 * @return
	 */
	public static String money4(Long money) {
		if (money == null) {
			return "0.0000";
		}
		return new BigDecimal(money).divide(new BigDecimal(10000)).setScale(4, RoundingMode.DOWN).toString();
	}

	/**
	 * 元转分
	 * 
	 * @param money
	 * @return
	 */
	public static Long money4(String money) {
		if (CommonUtils.isEmpty(money)) {
			return null;
		}
		if (!money.matches("^[0-9]+(\\.[0-9]{1,4})?$")) {
			return null;
		}
		return new BigDecimal(money).multiply(new BigDecimal(10000)).longValue();
	}

	/**
	 * kg转g
	 * 
	 * @param money
	 * @return
	 */
	public static Long weight(String weight) {
		if (CommonUtils.isEmpty(weight)) {
			return null;
		}
		if (!weight.matches("^[0-9]+(\\.[0-9]{1,3})?$")) {
			return null;
		}
		return new BigDecimal(weight).multiply(new BigDecimal(1000)).longValue();
	}

	/**
	 * g转kg
	 * 
	 * @param money
	 * @return
	 */
	public static String weight(Long weight) {
		if (weight == null) {
			return "0.000";
		}
		return new BigDecimal(weight).divide(new BigDecimal(1000)).setScale(3, RoundingMode.DOWN).toString();
	}

	public static String getCellValue(Cell cell) {
		String ret;
		switch (cell.getCellType()) {
		case Cell.CELL_TYPE_BLANK:
			ret = "";
			break;
		case Cell.CELL_TYPE_BOOLEAN:
			ret = String.valueOf(cell.getBooleanCellValue());
			break;
		case Cell.CELL_TYPE_ERROR:
			ret = null;
			break;
		case Cell.CELL_TYPE_FORMULA:
			Workbook wb = cell.getSheet().getWorkbook();
			CreationHelper crateHelper = wb.getCreationHelper();
			FormulaEvaluator evaluator = crateHelper.createFormulaEvaluator();
			ret = getCellValue(evaluator.evaluateInCell(cell));
			break;
		case Cell.CELL_TYPE_NUMERIC:
			if (DateUtil.isCellDateFormatted(cell)) {
				Date theDate = cell.getDateCellValue();
				ret = CommonUtils.DateToString(theDate);
			} else {
				ret = NumberToTextConverter.toText(cell.getNumericCellValue());
			}
			break;
		case Cell.CELL_TYPE_STRING:
			ret = cell.getRichStringCellValue().getString();
			break;
		default:
			ret = null;
		}

		return ret; // 有必要自行trim
	}

	public static String cellValue(Row row, int index) {
		if (row == null) {
			return null;
		}
		Cell cell = row.getCell(index);
		if (cell == null) {
			return null;
		}
		return StringUtils.trimToNull(getCellValue(cell));
	}

	public static Cell getCell(Row row, int index) {
		Cell cell = row.getCell(index);
		if (cell == null) {
			cell = row.createCell(index);
		}
		cell.setCellType(Cell.CELL_TYPE_STRING);
		return cell;
	}

	public static Cell setCellValue(Row row, int index, String value) {
		Cell cell = row.getCell(index);
		if (cell == null) {
			cell = row.createCell(index);
		}
		cell.setCellType(Cell.CELL_TYPE_STRING);
		cell.setCellValue(value);
		return cell;
	}

	public static String newFileName() {
		return nowDateToString("yyyyMMddHHmmss") + "_" + new Random().nextInt(1000);
	}
	
	public static void main(String[] args){
		//System.out.println(transDeadline("24月"));
		//System.out.println(df.format(1200000).substring(1));
		System.out.println(fmtW(100040048000L));
		
	}
}
