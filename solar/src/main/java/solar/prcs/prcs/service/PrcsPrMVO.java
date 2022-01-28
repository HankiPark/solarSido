package solar.prcs.prcs.service;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class PrcsPrMVO {

	String wkNo;
	@JsonFormat(pattern="yyyy/MM/dd", timezone="Asia/Seoul")		// 보낼때  받을때
	@DateTimeFormat(pattern="yyyy/MM/dd")
	String wkDt;
	String prodFg;
	String prdtCd;
	String istQty;
	String wkQty;
	String inferQty;
	String expcTm;
	String realTm;
	String prcsCd;
	String indicaDetaNo;
	String indicaNo;
	@JsonFormat(pattern="yyyy/MM/dd", timezone="Asia/Seoul")		// 보낼때  받을때
	@DateTimeFormat(pattern="yyyy/MM/dd")
	String indicaDt;
		
}
