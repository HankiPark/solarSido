package solar.prcs2.dao;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class Prcs2 {
	String prdtIdx;
	String prdtLot;
	String prdtCd;
	String prdtFg;
	String indicaDetaNo;
	String indicaNo;
	String index;
	String wkNo;
	String empId;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd",timezone="Asia/Seoul")
	Date wkDt;
	String eqmCd;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone="Asia/Seoul")
	Date prcsFrTm;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone="Asia/Seoul")
	Date prcsToTm;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone="Asia/Seoul")
	Date inferDt;
	String prdtInferCd;
	String prdtInferNm;
	String prdtInferDesct;
	String eqmNm;
	String prdtNm;
	
	
	
}
