package solar.prod.indica.service;

import lombok.Data;

@Data
public class IndRscVO {
	//자재사용현황
	String prdtLot;
	String rscLot;
	int rscConQty;
	int rscUseQty;
	
	//생산소요자재
	int indicaDetaNo;
	
	//제품재고관리
	int prdtInx;
	String prdtFg;
	String prdtCd;
	
	//자재입고출고
	int rscQty;
	String rscCd;
	
	//주문상세
	int indicaQty;
	String orderNo;
	
}
