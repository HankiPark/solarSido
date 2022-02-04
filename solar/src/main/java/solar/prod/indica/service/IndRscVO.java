package solar.prod.indica.service;

import lombok.Data;

@Data
public class IndRscVO {
	//자재사용현황
	String prdtLot;
	String rscLot;
	String rscConQty;
	String rscUseQty;
	
	//생산소요자재
	String indicaDetaNo;
	
	//제품재고관리
	String prdtCd;
	
	//자재입고출고
	String rscQty;
	String rscCd;
	
	//주문상세
	String indicaQty;
	String orderNo;
}
