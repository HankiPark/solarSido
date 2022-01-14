package solar.prod.plan.service;

import lombok.Data;

@Data
public class ProdPlanVO {
	
	//order
	String orderNo;		//주문번호
	String recvDt;		//접수일자
	String paprdDt;		//납기일자
	String orderQty; 	//주문량
	
	//Plan
	String planNo;		//생산계획번호
	String planDt;		//계획일자
	String planNm;		//생산계획명
	
	//PlanD
	String planDetaNo;  //생산계획상세번호
//	String planNo;		//생산계획번호
//	Date planDt;		//계획일자
//	String orderNo;		//주문번호
//	Date recvDt;		//접수일자
	String prdtCd; 		//제품코드
	int planQty;		//작업량
	int wkOrd;			//작업순서
	String wkDt;		//작업일자
	String dayOutput;	//일생산량
	String prodDay;		//생산일수
	
	//search
	String planStartDt; //기간시작
	String planEndDt;	//기간끝
//	String prdtCd; 		//제품코드
	String prdtNm; 		//제품명
	String coCd;		//업체코드
	String coNm;		//업체명
	
}
