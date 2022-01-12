package solar.prcs.prcs.service;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class IndicaVO {
	String indicaDetaNo;
	String indicaNo;
	String indicaNm;
	@JsonFormat(pattern="yyyy-MM-dd")		// 보낼때  받을때
	@DateTimeFormat(pattern="yyyy-MM-dd")
	Date indicaDt;
	String planDetaNo;
	String prdtCd;
	String prodFg;
	String indicaQty;
	String wkOrd;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	Date wkDt;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	Date recvDt;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	Date planDt;
	String orderNo;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	Date sDate;
	
	
}
