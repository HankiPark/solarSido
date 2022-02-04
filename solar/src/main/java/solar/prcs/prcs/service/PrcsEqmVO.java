package solar.prcs.prcs.service;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class PrcsEqmVO {

	String prcsCd;
	String prcsFg;
	String prcsNm;
	String prcsDesct;
	String prcsUnit;
	String ProdPd;
	String eqmCd;
	String eqmNm;
	String eqmFg;
	String eqmMdl;
	String eqmSpec;
	String eqmCo;
	@JsonFormat(pattern="yyyy/MM/dd", timezone="Asia/Seoul")
	@DateTimeFormat(pattern="yyyy/MM/dd")
	Date purcDt;
	String purcAmt;
	String liNo;
	String empId;
	String energy;
	String lf;
	String temp;
	String uph;
	String pTime;
	String eqmImg;
	String eqmYn;
	
	
}
