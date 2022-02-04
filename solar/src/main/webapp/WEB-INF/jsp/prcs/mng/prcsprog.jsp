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
	<div id="prcsEqmDialog-form" title="공정선택"></div>
	<div id="empDialog-form" title="사원검색"></div>


	<div>
		<div class="row">
			<div class="col-5">
				지시번호 : <input type="text" id="indicaDetaNo"><button type="button" id="searchIndica">🔍</button><br><br>
				제품코드 : <input type="text" id="prdtCd"><br><br>
				공정명  : <input type="text" id="prcsNm"><button type="button" id="searchEqm">🔍</button><br><br>
				라인번호 : <input type="text" id="liNm"><br><br>
				<br>
				작업자 : <input type="text" id="empNm"><button type="button" id="searchEmp">🔍</button> 작업량 : <input type="text" id="wkQty"><br><br> 
				<input type="text" id="frTm"><button id="btnStart">시작</button>	
				<input type="text" id="toTm"><button id="btnEnd" disabled="disabled">종료</button><br>
				<button id="btnAddPerf">실적등록</button>
				<button id="btnTest1">테스트용1</button>
				<button id="btnTest2">테스트용2</button>
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
	
	// 공정선택에 있어 흐름과 해당 설비에대한 Obj를 담을 변수
	let prcsEqmList
	let prcsFlow
	
	// 공정 버튼 함수에서 사용하는 변수
	let sPresent, ePresent;
	let btnStart = document.getElementById("btnStart");
	let btnEnd = document.getElementById("btnEnd");
	let tAmount = 0;
	let u1=0;
	let u2=0;
	let u3=0;
	let u4=0;
	
	let time = 0;
	let timerFlag = true;
	let unitPTime = [];
	
	
	// 공정진행 관리 insert에서 사용될 변수
	let pIndicaDetaNo;
	let pIndicaNo;
	let pIndicaDt;
	let pIstQty;
	let pPrdtCd;
	let pProdFg;
	let pPrcsCd;
	
	let prcsPrM;
		 
	
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
	
	// 사원 모달 선언
	let empDialog = $("#empDialog-form").dialog({
		autoOpen : false,
		modal : true,
		width : 700,
		height : 700
	})

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
	
	// 사원 모달 호출 이벤트
 	$("#searchEmp").on("click",function() {
 		empDialog.dialog("open");
 		$("#empDialog-form").load(
 		"${pageContext.request.contextPath}/modal/empinfoList"
 		);
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
	function innIndica(inddd,
						prd,
						prdf,
						indicaDetaNo,
						indicaNo,
						indicaDt,
						indicaQty){
		tAmount = indicaQty;
		
		pIndicaDetaNo = indicaDetaNo;
		pIndicaNo = indicaNo; 
		pIndicaDt = indicaDt;
		
		pIstQty = tAmount;
		pPrdtCd = prd;
		pProdFg = prdf;
		
		$("#indicaDetaNo").val(inddd);
		$("#prdtCd").val(prd);
		document.getElementById("wkQty").placeholder = "목표량 : "+tAmount;

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
				const {RSC} = result;
				rscItem = {RSC}
				console.log("소요자재LOT 리스트 > "+RSC);
				console.log("----------------------------------");
				console.log(rscItem);
				console.log("----------------------------------");
				console.log(RSC)
				console.log(RSC[0]);
				
			},
			error : function(result){
				console.log("에러")
			}
				
		});

	} 

 		// 공정명, 라인번호 기입
	function innPrcsEqm(prcsNm, prcsCd, liNm){
		$("#prcsNm").val(prcsNm);
		$("#liNm").val(liNm);
		
		pPrcsCd = prcsCd;
		
		$.ajax({
			url:"${pageContext.request.contextPath}/prcs/searchPrcsFlow",
			data : {
				'prcsCd':prcsCd	
			},
			dataType: 'JSON',
			async: false,
			contentType: 'application/json',
			success : function(result){
				const {PRCSFLOW} = result;
				prcsFlow = {PRCSFLOW}
				console.log("공정내 가동순서 > "+{PRCSFLOW});
				console.log("----------------------------------");
				console.log(prcsFlow);
				console.log(prcsFlow.PRCSFLOW);
				console.log("----------------------------------");
				console.log(prcsFlow[0]);
				console.log(prcsFlow.PRCSFLOW[0].prcsOrd+ "번 순서 "+prcsFlow.PRCSFLOW[0].eqmCd);
			},
			error : function(result){
				console.log("에러")
			}
		});
		
		$.ajax({
			url:"${pageContext.request.contextPath}/prcs/searchPrcsEqmDetail",
			data : {
				'prcsCd':prcsCd	
			},
			dataType: 'JSON',
			async: false,
			contentType: 'application/json',
			success : function(result){
				const {PRCS} = result;
				prcsEqmList = {PRCS}
				console.log("공정내 설비 리스트 > "+PRCS);
				console.log("----------------------------------");
				console.log(prcsEqmList);
				console.log("----------------------------------");
				console.log(PRCS)
				console.log(PRCS[0]);
				console.log(PRCS[0].prcsNm);
				
				for(var i = 0; i<prcsGrid.getRowCount(); i++){
					prcsGrid.setValue(i,'prcsCd',PRCS[0].prcsNm,false);
				}	
			},
			error : function(result){
				console.log("에러")
			}
		});
		prcsEqmDialog.dialog("close");
	}
 	
 	// Millisecond 변환해서 현재날짜 yyyy/MM/dd HH:MM:SS 문자열로 치환해주는 함수
 	function msToHMS(cTime) {

	     var milliseconds = parseInt((cTime % 1000) / 100);
	     var seconds = parseInt((cTime / 1000) % 60);
	     var minutes = parseInt((cTime / (1000 * 60)) % 60);
	     var hours = parseInt(((cTime / (1000 * 60 * 60)) % 24)+9);
	
	     var hours = (hours < 10) ? "0" + hours : hours;
	     var minutes = (minutes < 10) ? "0" + minutes : minutes;
	     var seconds = (seconds < 10) ? "0" + seconds : seconds;
	
	     const presentTime = new Date()
	     var years = presentTime.getFullYear();
	     var month = presentTime.getMonth()+1;
	     var days = presentTime.getDate();
	     
	     var month = (month < 10) ? "0" + month : month;
	     var days = (days < 10) ? "0" + days : days;
	      
	     return years+"-"+month+"-"+days+" "+hours + ":" + minutes + ":" + seconds;
	     
	}
 		
 		
 	// 타이머 펑션 실행
	$(document).ready(function(){
			PrcsTimer();
		});
 		
	function init(){
		document.getElementById("prcsTimer").innerHTML = "00-00-00"
	}
 		
	// 공정타이머 함수 시작
	function PrcsTimer(){
		var timer;
		var sec = "0";
		var min = "0";
		var hour = "0";
 			
 			// 테스트 버튼
 			$("#btnStart").on("click", function(ev){
 			
 					
 				
 				if(!!pIndicaDetaNo){
 					if(!!pPrcsCd){
 						let empNm = $('#empNm').val();
 						if(!(empNm=="")){
 							
 							var Yn = [];
 			 				for(var i = 0 ; i<prcsEqmList.PRCS.length ; i++){
 			 					Yn.push(prcsEqmList.PRCS[0].eqmYn);
 			 				} 		
 							
 							if(!(Yn.includes('N'))){
 			 					
 			 					// 시작버튼 시간 이벤트
 			 	 				$("#frTm").val("");
 			 	 				btnStart.disabled = true;
 			 	 				btnEnd.disabled = false;
 			 	 						
 			 	 				const sTm = new Date(); 
 			 	 				var sHours = sTm.getHours();
 			 	 				var sMinutes = sTm.getMinutes();
 			 	 				var sSeconds = sTm.getSeconds();
 			 	 				
 			 	 				var sTime = sHours+"/"+sMinutes+"/"+sSeconds;
 			 	 				
 			 	 				console.log(sTime);
 			 	 				console.log($("#frTm"));
 			 	 				
 			 	 				$("#frTm").val(sTime);
 			 	 				
 			 	 				// 시작버튼 시간 이벤트끝
 			 	 				
 			 	 				console.log("----------------------------------------- prcsGrid 테스트")
 			 	 				console.log(prcsGrid.getRowCount());
 			 	 				console.log(tAmount);
 			 	 				console.log("----------------------------------------- prcsGrid 테스트")
 			 	 				
 			 	 				// 공정진행관리 첫번째 insert
 			 	 				console.log("----------------------------------------- PRCS_PR_M 테스트")
 			 	 				console.log(pIndicaDetaNo);
 			 	 				console.log(pIndicaDt);
 			 	 				console.log(pIndicaNo);
 			 	 				console.log(pIstQty);
 			 	 				console.log(pPrdtCd);
 			 	 				console.log(pProdFg);
 			 	 				console.log(pPrcsCd);
 			 	 				console.log("----------------------------------------- PRCS_PR_M 테스트")
 			 	 				
 			 	 				$.ajax({
 			 	 					url:"${pageContext.request.contextPath}/prcs/insertPrcsPrM",
 			 	 					data : {
 			 	 						'indicaDetaNo':pIndicaDetaNo,
 			 	 						'indicaDt':pIndicaDt,
 			 	 						'indicaNo':pIndicaNo,
 			 	  						'prdtCd':pPrdtCd,
 			 	 						'prodFg':pProdFg,
 			 	 						'prcsCd':pPrcsCd,	
 			 	 					},
 			 	 					dataType: 'JSON',
 			 	 					async: false,
 			 	 					contentType: 'application/json',
 			 	 					success : function(result){
 			 	 						console.log('공정진행관리 초기 데이터 입력완료');	
 			 	 					},
 			 	 					error : function(result){
 			 	 						console.log("공정진행관리 초기 데이터 입력실패");
 			 	 					}
 			 	 				});
 			 	 				
 			 	 				

 			 	 			// ******************************************************* setInterval 타이머 함수
 			 	 				
 			 					timerFlag = false;
 			 	 				
 			 	 				if(time==0){
 			 	 					init();
 			 	 				}
 			 	 			
 			 	 				timer = setInterval(function(){
 			 	 					time++;
 			 	 					
 			 	 					if(time)
 			 	 					
 			 	 					min = Math.floor(time/60);
 			 	 					hour = Math.floor(min/60);
 			 	 					sec = time%60;
 			 	 					min = min%60;
 			 	 					
 			 	 					var fh = hour;
 			 	 					var fm = min;
 			 	 					var fs = sec;
 			 	 					
 			 	 					if(fh<10) fh = "0"+ hour;
 			 	 					if(fm<10) fm = "0"+ min;
 			 	 					if(fs<10) fs = "0"+ sec;
 			 						 					

 			 	 					document.getElementById("prcsTimer").innerHTML = fh+"/"+fm+"/"+fs; 
 			 	 				
 			 	 				}, 1000);
 			 	 				
 			 	 			// ******************************************************* setInterval 타이머 함수

 			 	 				// 받아온 설비 리스트의 길이와 uph를 받아와 저장
 			 	 				for(let i =0; i< prcsEqmList.PRCS.length;i++){
 			 							unitPTime.push(prcsEqmList.PRCS[i].ptime);
 			 						}  
 			 						
 			 			
 			 					console.log(prcsEqmList);
 			 					console.log("공정설비갯수"+prcsEqmList.PRCS.length);
 			 					console.log("-------------------------ptime")
 			 					console.log(prcsEqmList.PRCS[0].ptime+" 1번째 설비");
 			 					console.log(prcsEqmList.PRCS[1].ptime+" 2번째 설비");
 			 					console.log(prcsEqmList.PRCS[2].ptime+" 3번째 설비");
 			 					console.log(prcsEqmList.PRCS[3].ptime+" 4번째 설비");
 			 					console.log("-------------------------ptime")
 			 					console.log(unitPTime);

 			 	 				

 			 					
 			 					/* ---------------------------------------------------------------------------------- */
 			 					// 공정 정보를 조건으로 실제 함수를 구현할 몸체
 			 					console.log("--------------------------------설비 선택 유무 조건");
 			 					console.log(!!unitPTime[0]);
 			 					console.log(unitPTime[0])
 			 					console.log(!!unitPTime[1]);	
 			 					console.log(unitPTime[1]);
 			 					console.log(!!unitPTime[2]);
 			 					console.log(unitPTime[2]);
 			 					console.log(!!unitPTime[3]);
 			 					console.log(unitPTime[3]);
 			 					console.log("--------------------------------설비 선택 유무 조건"); 						
 			 					
 			 					
 			 					for(var i = 0; i<prcsGrid.getRowCount(); i++){
 			 						if(prcsGrid.getValue(i,'lowSt')==="W"){
 			 							prcsGrid.setValue(i,'lowSt','P',false);
 			 						}
 			 					}
 			 					
 			 					u1 = unitPTime[0];
 			 					u2 = unitPTime[1];
 			 					u3 = unitPTime[2];
 			 					u4 = unitPTime[3];
 			 					
 			 					console.log(!!u1);
 			 					console.log(!!u2);
 			 					console.log(!!u3);
 			 					console.log(!!u4);
 			 					
 			 					let su2 = Number(u1)+Number(u2);
 			 					let su3 = Number(su2)+Number(u3);
 			 					let su4 = Number(su3)+Number(u4);

 			 					console.log(tAmount);
 			 					
 			 					
 			 					// 유닛1 공정진행 타이머
 			 					if(!!u1){
 			 						unit1 = setTimeout(function tick() {
 			 							if(timerFlag===true){
 			 								clearTimeout(unit1);
 			 							}
 			 							
 			 							console.log("1번 유닛 완료 7.2초 단위");
 			 							
 			 							const endTm = new Date(); 
 			 							console.log("-----------------완료시점")
 			 							console.log((endTm-u1));
 			 							console.log(endTm);
 			 							var eqmETime = msToHMS(endTm);
 			 							var eqmSTime = msToHMS(endTm-u1);
 			 							console.log(eqmSTime+"공정시작시간");
 			 							console.log(eqmETime+"공정끝난시간");
 			 							console.log("-----------------완료시점")
 			 														
 			 							/* $.ajax({
 			 								url:"${pageContext.request.contextPath}/prcs/searchPrcsEqmDetail",
 			 								data : {
 			 									'prcsCd':prcsCd	
 			 								},
 			 								dataType: 'JSON',
 			 								async: false,
 			 								contentType: 'application/json',
 			 								success : function(result){
 			 														
 			 								},
 			 								error : function(result){
 			 									console.log("호출실패")
 			 								}
 			 							});	 */
 			 							

 			 						
 			 							unit1 = setTimeout(tick, u1); // (*)
 			 							}, u1);
 			 						}
 			 					
 			 					// 유닛2 공정진행 함수 타이머
 			 					function startUnit2(u2){
 			 						console.log(u2);
 			 						console.log(u1+"딜레이 끝두번째 유닛 시작합니다")
 			 						unit2 = setTimeout(function tick() {
 			 							if(timerFlag===true){
 			 								clearTimeout(unit2);
 			 							}
 			 							console.log("2번 유닛 완료 10초 단위");
 			 							const endTm = new Date(); 
 			 							console.log("-----------------완료시점")
 			 							console.log((endTm-u2));
 			 							console.log(endTm);
 			 							var eqmETime = msToHMS(endTm);
 			 							var eqmSTime = msToHMS(endTm-u2);
 			 							console.log(eqmSTime+"공정시작시간");
 			 							console.log(eqmETime+"공정끝난시간");
 			 							console.log("-----------------완료시점")
 			 							/* $.ajax({
 			 									
 			 							}) */
 			 							
 			 							unit2 = setTimeout(tick, u2); // (*)
 			 							}, u2);
 			 					}
 			 					
 			 					// 유닛3 공정진행 함수 타이머
 			 					function startUnit3(u3){
 			 						console.log(u3);
 			 						console.log(su2+" 딜레이 끝 세번째 유닛 시작합니다")
 			 						unit3 = setTimeout(function tick() {
 			 							if(timerFlag===true){
 			 								clearTimeout(unit3);
 			 							}
 			 							console.log("3번 유닛 완료 5초 단위");

 			 							const endTm = new Date(); 
 			 							console.log("-----------------완료시점")
 			 							console.log((endTm-u3));
 			 							console.log(endTm);
 			 							var eqmETime = msToHMS(endTm);
 			 							var eqmSTime = msToHMS(endTm-u3);
 			 							console.log(eqmSTime+"공정시작시간");
 			 							console.log(eqmETime+"공정끝난시간");
 			 							console.log("-----------------완료시점")			
 			 							/* $.ajax({
 			 								
 			 							}) */
 			 						
 			 							unit3 = setTimeout(tick, u3); // (*)
 			 							}, u3);
 			 					}
 			 					
 			 					// 유닛4 공정진행 함수 타이머
 			 					function startUnit4(u4){
 			 						console.log(u4);
 			 						console.log(su3+" 딜레이 끝 네번째 유닛 시작합니다")
 			 						unit4 = setTimeout(function tick() {
 			 							if(timerFlag===true){
 			 								clearTimeout(unit4);
 			 							}
 			 							
 			 							console.log("4번 유닛 완료 7.2초 단위");
 			 							const endTm = new Date();
 			 						
 			 							console.log("-----------------완료시점")
 			 							console.log((endTm-u4));
 			 							console.log(endTm);
 			 							var eqmETime = msToHMS(endTm);
 			 							var eqmSTime = msToHMS(endTm-u4);
 			 							console.log(eqmSTime+"공정시작시간");
 			 							console.log(eqmETime+"공정끝난시간");
 			 							console.log("-----------------완료시점")	
 			 							/* $.ajax({
 			 								
 			 							}) */
 			 						
 			 							unit4 = setTimeout(tick, u4); // (*)
 			 							}, u4);
 			 					}
 			 			
 			 					
 			 					// 유닛2 공정진행 타이머
 			 					if(!!u2){
 			 						console.log("u2 존재");
 			 						var sUnit2 = setTimeout(function tick() {
 			 									startUnit2(u2);
 			 									console.log("u2 함수실행");
 			 									clearTimeout(sUnit2);
 			 							}, u1);
 			 						
 			 					}
 			 					
 			 					// 유닛3 공정진행 타이머
 			 					if(!!u3){
 			 					console.log("u3 존재");
 			 						var sUnit3 = setTimeout(function tick(){
 			 									startUnit3(u3);
 			 									console.log("u3 함수실행");
 			 									clearTimeout(sUnit3);
 			 							}, su2);
 			 					}
 			 					
 			 					// 유닛4 공정진행 타이머
 			 					if(!!u4){
 			 						console.log("u4 존재");
 			 						var sUnit4 = setTimeout(function tick(){
 			 									startUnit4(u4);
 			 									console.log("u4 함수실행");
 			 									clearTimeout(sUnit4);	
 			 							}, su3);	
 			 					}	
 			 					
 			 					
 			 					
 			 					
 			 	 					
 			 					// 구현 함수 끝
 			 					/* ---------------------------------------------------------------------------------- */
 			 					
 			 				} else {
 			 					alert("비가동상태의 설비가 확인되었습니다. 설비상태를 확인해주세요");
 			 				} // 비가동 확인 조건문 끝

 						} else {
 							alert("사원정보가 선택되지 않았습니다. 사원정보를 선택해주세요");
 						}
 					} else {
 						alert("공정 정보가 선택되지 않았습니다. 공정번호를 선택해주세요");
 					}	
 				} else {
 					alert("지시번호가 선택되지 않았습니다. 지시번호를 선택해주세요");
 				}
 				
 				
 				
 				 				
 			});
	

 				// 종료버튼 이벤트 시작
 				$("#btnEnd").on("click", function(){
 					// init
 					$("#toTm").val("");
 					btnStart.disabled = false;
 					btnEnd.disabled = true;
 					
 					clearTimeout(unit1);
 					clearTimeout(unit2);
 					clearTimeout(unit3);
 					clearTimeout(unit4);
 					
 					// 종료버튼 시간 이벤트
 					const eTm = new Date();
 					var eHours = eTm.getHours();
 					var eMinutes = eTm.getMinutes();
 					var eSeconds = eTm.getSeconds();
 					
 					var eTime = eHours+"/"+eMinutes+"/"+eSeconds;
 					
 					console.log(eTime);
 					console.log($("#toTm"));
 					
 					$("#toTm").val(eTime);
 					// 종료버튼 시간 이벤트 끝
 					
 					for(var i = 0; i<prcsGrid.getRowCount(); i++){
 						if(prcsGrid.getValue(i,'lowSt')==="P"){
 							prcsGrid.setValue(i,'lowSt','W',false);
 						}
 					}
 					

	 				// 타이머 종료 기능
	 	 			if(time != 0){
	 	 				clearInterval(timer);
	 	 			    starFlag = true;
	 	 			  	/* ---------------------------------------------------------------------------------- */	 	 			    
	 	 			    // 종료 버튼 눌렀을때 처리되어야될 페이지 요소수정과 함께 호출될 실적정보를 정리할 함수위치
	 	 			    
	 	 			    
	 	 			  	
	 	 			    //
	 	 			  	/* ---------------------------------------------------------------------------------- */
	 	 			}
 					// 종료버튼 끝
				});

	}	// 공정타이머 함수 끝	
	
	$("#btnTest1").on("click", function(ev){
		console.log(prcsEqmList.PRCS[0].eqmYn);
		console.log(prcsEqmList.PRCS.length);
		var Yn = [];
		for(var i = 0 ; i<prcsEqmList.PRCS.length ; i++){
			Yn.push(prcsEqmList.PRCS[0].eqmYn);
		}
		
		console.log(Yn);
		console.log(Yn.includes('Y'));
		
		if(!(Yn.includes('N'))){
			alert("정상가동중!");
		} else {
			alert("선택안되었거나 비가동중");
		}
			
	});
	
	$("#btnTest2").on("click", function(ev){
		console.log(!!pIndicaDetaNo);
		console.log(!!pPrcsCd);
		console.log($('#empNm').val())
		let empNm = $('#empNm').val();
		console.log(!(empNm===""));
		
	});
	
 		
	</script>
</html>