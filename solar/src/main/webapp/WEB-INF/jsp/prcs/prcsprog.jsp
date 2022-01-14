<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div id="dialog-form" title="작업지시번호"></div>


	<div>
		<div class="row">
			<div class="col-5">
				지시번호 : <input type="text" id="indicaDetaNo"><button type="button" id="searchIndica">돋</button><br><br>
				제품코드 : <input type="text" id="prdtCd"><br><br>
				공정명  : <input type="text" id="prcsNm"><button type="button" id="searchPrcs">돋</button><br><br>
				설비코드 : <input type="text" id="eqmCd"><br><br>
				라인번호 : <input type="text" id="liNo"><br><br>
				<br>
				작업자 : <input type="text" id="empId"><button type="button" id="searchIndic">돋</button> 작업량 : <input type="text" id="wkQty"><br><br> 
				<input type="text" id="frTm"><button id="btnStart">시작</button><input type="text" id="toTm"><button id="btnStart">종료</button><br>
				<button id="btnAddPerf">실적등록</button>
			</div>
			
			
				
			<div class="col-6" id="prcsGrid"></div>
			
		</div>	
	</div>
</body>

<script>
	
	// 그리드 선언
	let indicaGrid
	let prcsGrid
	
	// 지시상세에서 사용하는 변수
	let indicaDataSource
	let sDate
	let sDateSearchBtn
	
	// 지시상세 모달 선언
	let indicaDialog = $( "#dialog-form" ).dialog({
		autoOpen: false,
		modal:true,
		width:1000
		/* buttons : {
			"save":function(){alert("save")},
			"upd": function(){alert("upd")}
		} */	
	});
	
 	$("#searchIndica").on("click", function(){
 		indicaDialog.dialog("open");
		$("#dialog-form").load("${pageContext.request.contextPath}/modal/searchIndicaDetail", function(){})
	});  

		const prcsColumns = 
			[ 
				{
				header : '제품LOT',
				name : 'prdtLot',
			}, {
				header : '제품명',
				name : 'prdtNm'
			}, {
				header : '공정명',
				name : 'prcsNm',
				
			}, {
				header : '진행상태',
				name : 'lowSt'
			}
			];
		
		
 		const inDataSource = {
				   api : {
				      readData : {
				         url : '${pageContext.request.contextPath}/grid/orderList.do',
				         method : 'GET'
				      }
				   },

				   contentType : 'application/json'
				};

 
	
 		prcsGrid = new tui.Grid({
			  el: document.getElementById('prcsGrid'),
			  data : inDataSource ,
			  columns : prcsColumns
			});	
 
 		prcsGrid.on("response", function(){
			prcsGrid.refreshLayout();
 			
 		});
 		
 		// 지시상세 페이지에서 정보를 넘겨받아 지시에 엮인 장비 리스트를 불러오는함수
 		function innIndica(inddd, prd, indicaDetaNo){
 			
 			$("#indicaDetaNo").val(inddd);
 			$("#prdtCd").val(prd);
 			
 			indicaDialog.dialog("close");
 	/* 		
 			var readParams = {
 					'indicaDetaNo':indicaDetaNo
 			}
 			
 			prcsGrid.readData(1,readParams,true);
 			prcsGrid.refreshLayout();
 			*/	
 		} 
 		
 		
	</script>
	





</html>