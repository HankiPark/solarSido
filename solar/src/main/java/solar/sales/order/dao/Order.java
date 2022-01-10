package solar.sales.order.dao;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class Order {
	String orderNo;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd")
	Date recvDt;
	String coCd;
	String coNm;
	String progInfo;
	String prdtCd;
	String orderQty;
	String indicaQty;
	String oustQty;
	String prdtStc;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd")
	Date paprdDt;
	String deNum;
	String prdtNm;
	
	int rowKey;
	
}
