package solar.prcs.prcs.service;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class PrcsVO {

	String wk_no;
	@JsonFormat
	@DateTimeFormat
	Date wkDt;
	String prodFg;
	String prdtCd;
	String istQty;
	String wkQty;
	String inferQty;
	String prdtLot;
	String expcTm;
	String realTm;
	String prcsCd;
	String indicaDetaNo;
	String indicaNo;
	@JsonFormat
	@DateTimeFormat
	Date indicaDt;
		
}
