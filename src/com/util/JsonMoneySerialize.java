package com.util;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.DecimalFormat;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;

public class JsonMoneySerialize extends JsonSerializer<Long>{

	@Override
	public void serialize(Long value, JsonGenerator gen, SerializerProvider arg2)
			throws IOException, JsonProcessingException {
		if(value==null||value==0){
			gen.writeString("0.00");
		}else{
			BigDecimal b=new BigDecimal(value).divide(new BigDecimal(100.0)).setScale(2, RoundingMode.DOWN);
			DecimalFormat d1 =new DecimalFormat("#,##0.00");
			gen.writeString(d1.format(b));
		}
	}
}
