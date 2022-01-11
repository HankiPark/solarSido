package solar.prcs.rsltd.service;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class RsltDVO {

	String rsltDetaNo;
	String rsltNo;
	@JsonFormat
	@DateTimeFormat
	Date wkDt;
	String eqmCd;
	String empId;
	String empNo;
	@JsonFormat
	@DateTimeFormat
	Date frTm;
	@JsonFormat
	@DateTimeFormat
	Date toTm;
	
}
