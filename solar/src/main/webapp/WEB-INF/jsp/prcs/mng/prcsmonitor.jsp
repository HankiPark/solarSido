<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<body>

	<h1>공정 모니터링</h1>
	
	<div id="DashBoard">
		<div class="divTable" id="divTable">
			<div class="row">
				<div class="col-md-6 mb-6 ">공정 현황</div>
				<div class="col-md-3 mb-6">현재 시각 들어갈자리</div>
			</div>
			<div class="row">
				<div class="col-md-1 mb-3">설비명</div>
				<div class="col-md-1 mb-3">공정명</div>
				<div class="col-md-1 mb-3">제품명</div>
				<div class="col-md-1 mb-3">진행계획</div>
				<div class="col-md-1 mb-3">가동상태</div>
				<div class="col-md-1 mb-3">생산추적</div>
				<div class="col-md-1 mb-3">현재실적</div>
				<div class="col-md-1 mb-3">현재불량</div>
				<div class="col-md-1 mb-3">실적률</div>
			</div>
			
						
			<button id="btnTest">테스트버ㅓㅓㅓㅓㅓ튼</button>
		
		</div>
	</div>

</body>
<script>

let EqmList;

$("#btnTest").on("click", function(ev){
	
	$.ajax({
		url:"${pageContext.request.contextPath}/prcs/searchPrcsEqmDetail",
		dataType: 'JSON',
		async: false,
		contentType: 'application/json',
		success : function(result){
			EqmList = result.PRCS;
			console.log(EqmList);
			
			let cnt = 1;
			
	 		for(item of EqmList){
	 			let iiiii = 'iiiii';
	 			console.log(item.eqmCd)
				console.log(`asdfasdf${item.eqmCd}`)
				console.log(`asdfasdf${iiiii}`)
				
	 			const table = document.getElementById('divTable')
	 			table.innerHTML += `
	 								<div class="row">
	 									<div class="col-md-1 mb-3 idx${cnt}">${item.eqmCd}</div>
	 									<div class="col-md-10 mb-3 idx${cnt}">fffff</div>
	 								</div>
	 								`;
	 			
	 			
// 	 			if(item.eqmYn == 'Y'){
// 	 				const contents = document.createTextNode("대기중")
// 	 				divCon.appendChild(contents);
// 	 			} else if(item.eqmYn == 'N'){
// 	 				const contents = document.createTextNode("비가동상태")
// 	 				divCon.appendChild(contents);
// 	 			} else {
// 	 				const contents = document.createTextNode("가동중")
// 	 				divCon.appendChild(contents);
// 	 			} 
	 			
				cnt++;
			} 
			
		},
		error : function(result){
			console.log("호출실패")
		}
	});
	
});

</script>


</html>