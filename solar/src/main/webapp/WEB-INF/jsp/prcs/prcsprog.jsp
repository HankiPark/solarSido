<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div id="indicaDialog-form" title="작업지시번호"></div>
	<div id="prcsEqmDialog-form" title="설비검색"></div>


	<div>
		<div class="row">
			<div class="col-5">
				지시번호 : <input type="text" id="indicaDetaNo"><button type="button" id="searchIndica">🔍</button><br><br>
				제품코드 : <input type="text" id="prdtCd"><br><br>
				공정명  : <input type="text" id="prcsNm"><button type="button" id="searchEqm">🔍</button><br><br>
				라인번호 : <input type="text" id="liNm"><br><br>
				<br>
				작업자 : <input type="text" id="empId"><button type="button" id="searchIndic">🔍</button> 작업량 : <input type="text" id="wkQty"><br><br> 
				<input type="text" id="frTm"><button id="btnStart">시작</button><input type="text" id="toTm"><button id="btnEnd" disabled="disabled">종료</button><br>
				<button id="btnAddPerf">실적등록</button>
				<button id="btnTest">테스트용</button>
				<div>
					<!-- 실시간으로 변화할 파트  -->
					<h1 id="prcsTimer"></h1>
				</div>
			</div>
			
			
				
			<div class="col-6" id="prcsGrid1"></div>
			
		</div>	
	</div>
</body>

<script>
	
	// 그리드 선언
	let prcsGrid
	let rk
	
	let indicaGrid
	let prcsEqmGrid
	
	// 지시상세에서 사용하는 변수
	let indicaDataSource
	let sDate
	let sDateSearchBtn
	
	// 장비검색에서 사용하는 변수
	let prcsEqmDataSource
	
	// 지시상세에 엮여있는 소모자재의 리스트를 담아둘 변수
	let prcsItemRsc
	
	// 버튼 함수에서 사용하는 변수
	let sPresent, ePresent;
	let btnStart = document.getElementById("btnStart");
	let btnEnd = document.getElementById("btnEnd");
	let u1=0;
	let u2=0;
	let u3=0;
	let u4=0;
	
		 
	
	// 지시상세 모달 선언
	let indicaDialog = $( "#indicaDialog-form" ).dialog({
		autoOpen: false,
		modal:true,
		width:1000
		/* buttons : {
			"save":function(){alert("save")},
			"upd": function(){alert("upd")}
		} */	
	});
	
	// 공정 모달 선언
	let prcsEqmDialog = $("#prcsEqmDialog-form").dialog({
		autoOpen: false,
		modal:true,
		width:1000	
	});

	// 지시상세 모달 호출 이벤트	
 	$("#searchIndica").on("click", function(){
 		indicaDialog.dialog("open");
		$("#indicaDialog-form").load("${pageContext.request.contextPath}/modal/searchIndicaDetail", function(){})
	});  

	// 공정 모달 호출 이벤트
 	$("#searchEqm").on("click", function(){
 		prcsEqmDialog.dialog("open");
		$("#prcsEqmDialog-form").load("${pageContext.request.contextPath}/modal/searchPrcsEqm", function(){})
	});
	
	// 공정 시작 버튼 호출 이벤트
	$("#btnStart").on("click", function(ev){
		//init
		$("#frTm").val("");
		btnStart.disabled = true;
		btnEnd.disabled = false;
				
		const sTm = new Date(); 
		var sHours = sTm.getHours();
		var sMinutes = sTm.getMinutes();
		var sSeconds = sTm.getSeconds();
		
		var sTime = sHours+"시 "+sMinutes+"분 "+sSeconds+"초";
		
		console.log(sTime);
		console.log($("#frTm"));
		
		$("#frTm").val(sTime);
		
	});
	
	// 공정 종료 버튼 호출 이벤트
	$("#btnEnd").on("click", function(){
		//init
		$("#toTm").val("");
		btnStart.disabled = false;
		btnEnd.disabled = true;
		
		const eTm = new Date();
		var eHours = eTm.getHours();
		var eMinutes = eTm.getMinutes();
		var eSeconds = eTm.getSeconds();
		
		var eTime = eHours+"시 "+eMinutes+"분 "+eSeconds+"초";
		
		console.log(eTime);
		console.log($("#toTm"));
		
		$("#toTm").val(eTime);
		
	});
	
	// 테스트 버튼
	$("#btnTest").on("click", function(){
		console.log(prcsGrid.getColumns());
		console.log(prcsGrid.getData());
		console.log(prcsGrid.getRowCount());
		
		
	});

	
		// 공정 진행 그리드 데이터 컬럼선언
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
				name : 'prcsCd',
				
			}, {
				header : '진행상태',
				name : 'lowSt'
			}
			];
		
		// 공정진행 그리드 데이터 호출
 		const inDataSource = {
				   api : {
				      readData : {
				         url : '${pageContext.request.contextPath}/prcs/prcsItem',
				         method : 'GET'
				      }
				   },
				   contentType : 'application/json'
				};
		
 		// 공정 진행 그리드 선언부
 		prcsGrid = new tui.Grid({
			  el: document.getElementById('prcsGrid1'),
			  data : inDataSource ,
			  columns : prcsColumns,
			  initialRequest : false						// 그리드 생성시 readdata 사용 x
			});	
 		
 		// 공정 진행 그리드 새로고침 이벤트
 		prcsGrid.on("response", function(){
			prcsGrid.refreshLayout(); 			
 		});
 		
 		// 지시상세 페이지에서 정보를 넘겨받아 지시에 종속된 자재 리스트를 불러오는함수
 		function innIndica(inddd, prd, indicaDetaNo, indicaQty){
 			
 			$("#indicaDetaNo").val(inddd);
 			$("#prdtCd").val(prd);
 			document.getElementById("wkQty").placeholder = "목표량 : "+indicaQty;
 			
 			indicaDialog.dialog("close");
 			 			
 			var readParams = {
 					'indicaDetaNo':indicaDetaNo
 			}
 			prcsGrid.readData(1,readParams,true);
 			prcsGrid.refreshLayout();
 			
 			$.ajax({
 				url:"${pageContext.request.contextPath}/prcs/prcsItemRsc",
 				data : {
 					'indicaDetaNo':indicaDetaNo	
 				},
 				dataType: 'JSON',
 				async: false,
 				contentType: 'application/json',
 				success : function(result){
 					prcsItemRsc = result.RSC;
 					console.log("소요자재LOT 리스트 > "+ prcsItemRsc);
 				},
 				error : function(result){
 					console.log("에러")
 				}
 					
 			});

 		} 

 		// 공정명, 라인번호 기입
 		function innPrcsEqm(prcsNm, liNm){
 			$("#prcsNm").val(prcsNm);
 			$("#liNm").val(liNm);
 			
 			prcsEqmDialog.dialog("close");
			
	 		for(let i = 0; i < count; i++){
	 			prcsGrid.setColumnValues("prcsCd",prcsNm,false);
	 		}
	 			 		
 		}
 		
 		// 타이머 
 		function PrcsTimer(u1,u2,u3,u4){
 			var time = time+1;
 			var sec = "0";
 			var min = "0";
 			var hour = "0";
 			
 		 	/* if(time/216000>=1){
 				hour = time%216000;
 			}else if()
 		 */
 			
 			
 			
 		}
 		
 		
 		
 		
 		
 		
	</script>
	





</html>