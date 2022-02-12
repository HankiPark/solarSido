<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>
	.contents{
		text-align:center;
	}
	div{
		border:1px solid black;
		width:500px;
		height:50px;
		font-size:20pt;
	}
	.DashBoard{
		width:100%;
	}
	.divTable{
		width:100%;
		margin-right : 15px;
		margin-left: 15px;
	}
	.divTable > *{
		border:1px solid black;
		width:100%;	
	}
	
</style>

<body>

	<h1>공정 모니터링</h1>
	
	<div class="DashBoard" style="text-align:center">
		<div class="divTable" id="divTable" style="border: 0px;padding:0px">
			<div class="row" style="background-color:#4B89DC">
				<div class="col-md-8 mb-6" style="padding:0px">공정 현황</div>
				<div class="col-md-4 mb-6 present"></div>
			</div>
			<div class="row" style="background-color:yellow">
				<div class="col-md-2 mb-3">설비명</div>
				<!--  <div class="col-md-2 mb-3">공정명</div>-->
				<div class="col-md-3 mb-3">제품명</div>
				<div class="col-md-3 mb-3">가동상태</div>
				<div class="col-md-4 mb-3">생산추적</div>
			</div>
		
		</div>
	</div>

</body>
<script>

let eqmList;
let prcsDO;

let present;

$(function(){
	rscursion();
	
	
	$.ajax({
		url:"${pageContext.request.contextPath}/prcs/searchPrcsEqmDetail",
		dataType: 'JSON',
		async: false,
		contentType: 'application/json',
		success : function(result){
			eqmList = result.PRCS;
						
			let cnt = 1;
			let flag = false;
			
	 		for(item of eqmList){
	 			
	 			const table = document.getElementById('divTable')
	 			table.innerHTML += `
	 								<div class="row irdx\${cnt} \${item.eqmCd}">
	 									<div class="col-md-2 mb-3 eqm indx\${cnt} " style="background-color:#91D653">\${item.eqmCd}</div>
	 									<div class="col-md-10 mb-3 contents idx\${cnt} "style="background-color:white"></div>
	 								</div>
	 								`;
	 			
	 			let contents = document.getElementsByClassName("idx"+cnt);
 			
	 	 			if(item.eqmYn == 'Y'){
	 	 				
	 	 				contents[0].innerText += "대기중"; 
	 	 				
	 	 			} else if(item.eqmYn == 'N'){
	 	 				
	 	 				contents[0].innerText += "비가동됨";
	 	 				
	 	 			} else {
	 	 				
	 	 				contents[0].innerText += "가동중";
	 	 				
	 	 			} 
		 			
					cnt++;
					
			} 
		},
		error : function(result){
		}
	 			
	});
	
});

function rscursion(){
	
	timer = setInterval(function(){
		
		let presentDiv = document.getElementsByClassName('present');
		
		let today = new Date();   

		let year = today.getFullYear(); // 년도
		let month = today.getMonth() + 1;  // 월
		let date = today.getDate();  // 날짜
		let day = today.getDay();  // 요일
		let hours = today.getHours(); // 시
		let minutes = today.getMinutes();  // 분
		let seconds = today.getSeconds();  // 초

		present = year + '년' + month + '월' + date+ '일 ' + hours + '시' + minutes + '분' + seconds + '초';
		
		presentDiv[0].innerHTML = `\${present}`;		
				
		$.ajax({
			url:"${pageContext.request.contextPath}/prcs/selectPrcsDO",
			dataType: 'JSON',
			async: false,
			contentType: 'application/json',
			success : function(result){
				prcsDO = result.data.contents;
				eqmlist = result.eqmList;
				let contents = "";
				
				
				if(prcsDO.length!=0){
					var cnt=1;
					outer :for(let item of prcsDO){
						inner:for(let i =0;i<eqmlist.length;i++){
							if(eqmlist[i].eqmCd == item.eqmCd){
								$("."+item.eqmCd).find(":not(.eqm)").remove();
					 			$("."+item.eqmCd).append(`<div class="col-md-10 mb-3 contents idx\${cnt} ab\${item.eqmCd}"style="background-color:white"></div>`);
					 			
					 			let contents = document.getElementsByClassName("ab"+item.eqmCd);
				 			
					 	 			
					 	 				
					 	 		contents[0].innerText = "대기중"; 
					 	 				
					 	 			
						 			
									cnt++;
									continue outer ;
							}
						}
						
						
					
						let prcsNm;
						let prdtNm;
						let eqmCd = item.eqmCd;
						let state;
						
						if(eqmCd=='EQM011' || eqmCd=='EQM012' || eqmCd=='EQM013' || eqmCd=='EQM014'){
							prcsNm = '태양전지 제조공정'	
						} else if(eqmCd=='EQM021' || eqmCd=='EQM022' || eqmCd=='EQM023' || eqmCd=='EQM024'){
							prcsNm = '태양전지 전극공정'
						} else if(eqmCd=='EQM031' || eqmCd=='EQM032' || eqmCd=='EQM033' || eqmCd=='EQM034'){
							prcsNm = '모듈 용접공정'
						} else if(eqmCd=='EQM041' || eqmCd=='EQM042' || eqmCd=='EQM043' || eqmCd=='EQM044'){
							prcsNm = '모듈 접합 공정';
						} else {
							prcsNm = '신규공정';
						}
						
						
						
						if(item.prdtCd=='p001'){
							prdtNm = '360W 태양광모듈 패널(대)';	
						} else if(item.prdtCd=='p002'){
							prdtNm = '360W 태양광모듈 패널(중)';
						} else if(item.prdtCd=='p003'){
							prdtNm = '300W 태양광모듈 패널(대)';
						} else if(item.prdtCd=='p004'){
							prdtNm = '300W 태양광모듈 패널(중)';
						} else if(item.prdtCd=='p005'){
							prdtNm = '250W 태양광모듈 패널(대)';
						} else if(item.prdtCd=='p006'){
							prdtNm = '250W 태양광모듈 패널(중)';
						} else if(item.prdtCd=='p007'){
							prdtNm = '200W 태야왕모듈 단결정 패널(소)';
						} else {
							prdtNm = '신규제품'
						}
						
						if(item.prdtFg=='C'){
							state = '생산완료'	;
							
						} else {
							state = '가동중';
						}
						$("."+item.eqmCd).find(":not(.eqm)").remove();
						$("."+item.eqmCd).append(
								`
								<div class="col-md-3 mb-3">\${prdtNm}</div>
								<div class="col-md-3 mb-3">\${state}</div>
								<div class="col-md-4 mb-3">\${item.prdtLot}</div>`		
								)
						
											
						cnt++;
					}
					
				} 
				
				
			},
			error : function(result){
			}
		});
		
		
		
	}, 2000);
	
	
}


</script>


</html>