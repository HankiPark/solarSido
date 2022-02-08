<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="calCont"></div>

<script type="text/javascript">
function saleOrder(orderNo,start,end,coCd,prdt,qty){
	var prdtList = prdt.split(',');
	var qtyList = qty.split(',');
	$("#calCont").append(`
			<div>주문번호</div>
			<div>주문일자 : `+start.toISOString().slice(0, 10)+`</div>
			<div>납기일자 : `+end.toISOString().slice(0, 10)+`</div>
			<div>회사코드 : `+coCd+`</div>
			<div>주문량 </div>
			`)
			for(let i =0;i<prdtList.length;i++){
	$("#calCont").append(`
			<div>`+prdtList[i]+` : `+qtyList[i]+`
			`)
			}
};
function saleIn(start,lot){
	var lotList = lot.split(',');
	let cnt=0;
	$("#calCont").append(`
			<div>입고일자 : `+start.toISOString().slice(0, 10)+`</div>
			<div>제품 LOT </div>
			<div>
			`)
			for(let i =0;i<lotList.length;i++){
				if(cnt==2){
					$("#calCont").append(`<br/>`);
					cnt=0;
				}
			$("#calCont").append(lotList[i]+`  `)
			cnt++;
			}
	$("#calCont").append(`</div>
			<div>총 `+lotList.length+`개 입고처리됨</div>	
			`)
	
};
function saleOut(start,slip,coNm){
	var slipList = slip.split(',');
	var coNmList = coNm.split(',');
	
	$("#calCont").append(`
			<div>출고일자 : `+start.toISOString().slice(0, 10)+`</div>
			<div>전표 번호</div>
			`)		
	for(let i =0;i<slipList.length;i++){
				
			$("#calCont").append(`<div>`+i+1+`. `+slipList[i]+`<br/>  
			회사 이름 : `+coNmList[i]+`</div>`)
			}
	
};
function rscInOut(qty,start,lot,fg){
	var qtyList = qty.split(',');
	var lotList = lot.split(',');
	
	$("#calCont").append(`
			<div>`+fg+`일자 : `+start.toISOString().slice(0, 10)+`</div>
			<div>`+fg+` 목록</div>
			`)		
	for(let i =0;i<lotList.length;i++){
				
			$("#calCont").append(`<div>`+lotList[i]+` : `+qtyList[i]+`개</div>`)
			}
	
};
function eqm(uopr,eqmCd,start,end){

	$("#calCont").append(`
			<div>비가동 설비명 : `+eqmCd+`</div>
			<div>비가동명 : `+uopr+`</div>
			<div>비가동 시작일 : `+start.toISOString().slice(0, 10)+`</div>
			<div>비가동 종료일 : `+end.toISOString().slice(0, 10)+`</div>`);
			
	
};

$(function(){
    setTimeout(() => {
        $('th').css('border-bottom',' 1px solid #ddd')
        }, 1000);
      });

</script>
</body>
</html>