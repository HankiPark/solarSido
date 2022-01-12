package solar.sales.inout.dao;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class Prdt {

	String prdtLot;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd")
	Date prdtDt;
	String prdtCd;
	String prdtNm;
	String prdtSpec;
	String indicaNo;


	//검색조건
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd")
	Date startT;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd")
	Date endT;
	String prdNm;
	String prdCd;
	String prdSt;
	
	//modal추가정보
	String prdtAmt;
	String prdtUnit;
}
