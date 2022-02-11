package solar.prcs2.dao;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class EqmAble {

	String eqmCd;
	String liNo; 
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone="Asia/Seoul")
	Date inferDt;
	String prdtInferCd;
	String prdtInferNm;
	String prdtInferDesct;
	String eqmNm;
	String prdtNm;
}
