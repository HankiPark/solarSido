package solar.prcs.prcs.service;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class RsltVO {

	String rsltNo;
	String prdtCd;
	String empId;
	String prcsCd;
	String istQty;
	String rsltQty;
	String inferQty;
	@JsonFormat(pattern="hh24:mi:ss", timezone="Asia/Seoul")
	@DateTimeFormat(pattern="hh24:mi:ss")
	Date frTm;
	@JsonFormat(pattern="hh24:mi:ss", timezone="Asia/Seoul")
	@DateTimeFormat(pattern="hh24:mi:ss")
	Date toTm;
	
	String wkNo;
	@JsonFormat(pattern="yyyy/MM/dd", timezone="Asia/Seoul")
	@DateTimeFormat(pattern="yyyy/MM/dd")
	Date wkDt;
	
	
}
