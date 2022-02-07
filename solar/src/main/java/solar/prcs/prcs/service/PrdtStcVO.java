package solar.prcs.prcs.service;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class PrdtStcVO {
	
	String prdtInx;
	String prdtLot;
	String prdtFg;
	String prdtCd;
	String indicaDetaNo;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd",timezone="Asia/Seoul")
	String prdtDt;
	
}
