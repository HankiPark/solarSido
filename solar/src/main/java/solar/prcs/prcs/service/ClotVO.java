package solar.prcs.prcs.service;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class ClotVO {

	String rscConNo;
	String prdtLot;
	String prdtNm;
	String prcsCd;
	String lowSt;
	String wkNo;
	@JsonFormat(pattern="yyyy/MM/dd", timezone="Asia/Seoul")
	@DateTimeFormat(pattern="yyyy/MM/dd")
	Date wkDt;

	String indicaDetaNo;
	
	
}
