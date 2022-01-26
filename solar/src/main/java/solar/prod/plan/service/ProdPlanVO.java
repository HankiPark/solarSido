package solar.prod.plan.service;

import lombok.Data;

@Data
public class ProdPlanVO {
	
	//order
	String orderNo;		//주문번호
	String recvDt;		//접수일자
//	String coCd;		//업체코드
	String progInfo;	//진행정보
	String paprdDt;		//납기일자
	int orderQty; 		//주문량
	int prdtStc;		//제품재고
	
	//Plan
	String planNo;		//생산계획번호
	String planDt;		//계획일자
	String planNm;		//생산계획명
	
	//PlanD
	int planDetaNo;  	//생산계획상세번호
//	String planNo;		//생산계획번호
//	Date planDt;		//계획일자
//	String orderNo;		//주문번호
//	Date recvDt;		//접수일자
	String prdtCd; 		//제품코드
	int planQty;		//작업량
	String wkOrd;		//작업순서
	String wkDt;		//작업일자
	String dayOutput;	//일생산량
	String prodDay;		//생산일수
	
	//search
	String startT;		 //기간시작
	String endT;		//기간끝
//	String prdtCd; 		//제품코드
	String prdtNm; 		//제품명
	String prdtSpec;	//제품규격
	String prdtUnit;	//제품단위
	String coCd;		//업체코드
	String coNm;		//업체명
	String bizno;		//사업자등록번호
	String coFg;		//업체구분
	
	//rsc
	String psafStc;		//제품안전재고
	String rcomQty;		//추천작업량
	String rscCd;		//자재코드
	String rscStc;		//자재재고량
	String safStc;		//자재안전재고
	String ndStc;		//자재필요량
	String shtStc;		//자재부족량
	String rscUseQty;	//자재사용량
}
