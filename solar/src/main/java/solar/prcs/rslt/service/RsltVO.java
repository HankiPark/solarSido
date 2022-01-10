package solar.prcs.rslt.service;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class RsltVO {

	String rsltNo;
	String prdtCd;
	String rscLot;
	String istQty;
	String rsltQty;
	String inferQty;
	String prcsNm;
	String eqmCd;
	String liNo;
	String wkNo;
	@JsonFormat
	@DateTimeFormat
	Date wkDt;
	
}
