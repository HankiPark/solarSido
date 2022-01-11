package solar.prcs.clot.service;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class ClotVO {

	String rscConNo;
	String rscLot;
	String nowLoc;
	String lowSt;
	String wkNo;
	@JsonFormat
	@DateTimeFormat
	Date wkDt;
	
}
