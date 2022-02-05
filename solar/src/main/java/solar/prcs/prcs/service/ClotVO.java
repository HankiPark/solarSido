package solar.prcs.prcs.service;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class ClotVO {

	String rscConNo;
	String prdtLot;
	String prcsCd;
	String prcsOrd;
	String prdtNm;
	String eqmCd;
	String lowSt;
	String wkNo;
	@JsonFormat(pattern="yyyy/MM/dd", timezone="Asia/Seoul")
	@DateTimeFormat(pattern="yyyy/MM/dd")
	String wkDt;	
	@JsonFormat(pattern="hh24:mm:ss", timezone="Asia/Seoul")
	@DateTimeFormat(pattern="hh24:mi:ss")
	String prcsFrTm;
	@JsonFormat(pattern="hh24:mm:ss", timezone="Asia/Seoul")
	@DateTimeFormat(pattern="hh24:mi:ss")
	String prcsToTm;

	String indicaDetaNo;
	
	
}
