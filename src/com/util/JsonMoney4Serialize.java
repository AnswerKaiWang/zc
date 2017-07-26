package com.util;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;

public class JsonMoney4Serialize extends JsonSerializer<Long>{

	@Override
	public void serialize(Long value, JsonGenerator gen, SerializerProvider arg2)
			throws IOException, JsonProcessingException {
		if(value==null||value==0){
			gen.writeString("0.0000");
		}else{
			gen.writeString(new BigDecimal(value).divide(new BigDecimal(10000.0)).setScale(4, RoundingMode.DOWN).toEngineeringString());
		}
	}

}
