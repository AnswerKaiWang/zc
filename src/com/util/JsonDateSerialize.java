package com.util;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;

public class JsonDateSerialize extends JsonSerializer<Date>{

	@Override
	public void serialize(Date value, JsonGenerator gen, SerializerProvider arg2)
			throws IOException, JsonProcessingException {
		if(value==null){
			gen.writeString("");
		}else{
			SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd");
			gen.writeString(simpleDateFormat.format(value));
		}
	}

}
