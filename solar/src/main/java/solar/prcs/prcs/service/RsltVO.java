package solar.prcs.prcs.service;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class RsltVO {

	String prcsNm;
	String liNo;
	String wkNo;
	
	String rsltNo;
	@JsonFormat(pattern="yyyy/MM/dd", timezone="Asia/Seoul")
	@DateTimeFormat(pattern="yyyy/MM/dd")
	Date wkDt;
	
	String rsltDetaNo;
	String empId;
	String empNo;
	String eqmCd;
	String istQty;
	String rsltQty;
	String inferQty;
	Date frTm;
	Date toTm;
	String rscLot;
	
	
}
