package solar.prcs.prcs.service;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class RscConVO {

	String rscConNo;
	String indicaDetaNo;
	@JsonFormat(pattern="yyyy/MM/dd", timezone="Asia/Seoul")
	@DateTimeFormat(pattern="yyyy/MM/dd")
	Date recvDt;
	@JsonFormat(pattern="yyyy/MM/dd", timezone="Asia/Seoul")
	@DateTimeFormat(pattern="yyyy/MM/dd")
	Date planDt;
	@JsonFormat(pattern="yyyy/MM/dd", timezone="Asia/Seoul")
	@DateTimeFormat(pattern="yyyy/MM/dd")
	Date indicaDt;
	String orderNo;
	String rscLot;
	String rscConQty;
	
	

}
