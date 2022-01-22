package solar.sales.inout.dao;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class Prdt {

	String prdtLot;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd",timezone="Asia/Seoul")
	Date prdtDt;
	String prdtCd;
	String prdtNm;
	String prdtFg;
	String prdtSpec;
	String indicaNo;
	String indicaDetaNo;
	String prdtInx;
	String coCd;
	String coNm;
	String bizno;
	String coNumber;
	String coFg;
	String slipDetaNo;
	String slipNo;
	String prdtUntprc;
	String prdtStc;
	String oustQty;
	String orderQty;
	String orderNo;
	String slNm;
	String progInfo;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd",timezone="Asia/Seoul")
	Date recvDt;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd",timezone="Asia/Seoul")
	Date paprdDt;
	String valid;
	

	String restQty;
	
	//검색조건
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd",timezone="Asia/Seoul")
	Date startT;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd",timezone="Asia/Seoul")
	Date endT;
	String prdNm;
	String prdCd;
	String copNm;
	String copCd;
	String prdSt;
	//yyyy-MM
	String twit;
	
	
	//modal추가정보
	String prdtAmt;
	String prdtUnit;
	
}
