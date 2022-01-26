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
		
		tAmount = indicaQty;
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
 	
	$(document).ready(function(){
			PrcsTimer();
		});
 		
	function init(){
		document.getElementById("prcsTimer").innerHTML = "00-00-00"
	}
 		
	// 타이머 
	function PrcsTimer(){
		var timer;
		var sec = "0";
		var min = "0";
		var hour = "0";
 			
 			// 테스트 버튼
 			$("#btnStart").on("click", function(ev){
 				
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
 				console.log(prcsGrid.getColumns());
 				console.log(prcsGrid.getData());
 				console.log(prcsGrid.getRowCount());
 				console.log(tAmount);
 				console.log("----------------------------------------- prcsGrid 테스트")
 				
 				
 				
 				
 			// ******************************************************* 타이머 함수
 				
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
 				
 			// ******************************************************* 타이머 함수

 			
 			
 				
 				for(let i =0; i< prcsEqmList.PRCS.length;i++){
						unitPTime.push(prcsEqmList.PRCS[i].ptime);
					}  
					
				unitPTime.push('10000');
				unitPTime.push('5000');
				unitPTime.push('7200');
				
				console.log(prcsEqmList);
				console.log("공정설비갯수"+prcsEqmList.PRCS.length);
				console.log("-------------------------ptime")
				console.log(prcsEqmList.PRCS[0].ptime);
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
				
				console.log("susususususu");
				console.log(su2);
				console.log(su3);
				console.log(su4);
				console.log("susususususu");
				console.log(!!su2);
				console.log(!!su3);
				console.log(!!su4);
				
				console.log(tAmount);
				
				if(!!u1){
					unit1 = setTimeout(function tick() {
						if(timerFlag===true){
							clearTimeout(unit1);
						}
						
						console.log("1번 유닛 완료 7.2초 단위");
						
						/* $.ajax({
							
						}) */

					
						unit1 = setTimeout(tick, u1); // (*)
						}, u1);
					}
		
				function startUnit2(u2){
					console.log(u2);
					console.log(u1+"딜레이 끝두번째 유닛 시작합니다")
					unit2 = setTimeout(function tick() {
						if(timerFlag===true){
							clearTimeout(unit2);
						}
						console.log("2번 유닛 완료 10초 단위");
							
						/* $.ajax({
								
						}) */
						
						unit2 = setTimeout(tick, u2); // (*)
						}, u2);
				}
				
				function startUnit3(u3){
					console.log(u3);
					console.log(su2+" 딜레이 끝 세번째 유닛 시작합니다")
					unit3 = setTimeout(function tick() {
						if(timerFlag===true){
							clearTimeout(unit3);
						}
						console.log("3번 유닛 완료 5초 단위");
							
						/* $.ajax({
							
						}) */
					
						unit3 = setTimeout(tick, u3); // (*)
						}, u3);
				}
				
				function startUnit4(u4){
					console.log(u4);
					console.log(su3+" 딜레이 끝 네번째 유닛 시작합니다")
					unit4 = setTimeout(function tick() {
						if(timerFlag===true){
							clearTimeout(unit4);
						}
						
						console.log("4번 유닛 완료 7.2초 단위");
						
						/* $.ajax({
							
						}) */
					
						unit4 = setTimeout(tick, u4); // (*)
						}, u4);
				}
		
				
				
				if(!!u2){
					console.log("u2 존재");
					var sUnit2 = setTimeout(function tick() {
								startUnit2(u2);
								console.log("u2 함수실행");
								clearTimeout(sUnit2);
						}, u1);
					
				}
				
				if(!!u3){
				console.log("u3 존재");
					var sUnit3 = setTimeout(function tick(){
								startUnit3(u3);
								console.log("u3 함수실행");
								clearTimeout(sUnit3);
						}, su2);
				}
				 
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
		}
 		
 			
 			
 		
 		
 		
 		
 		
 		
 		
 		
	</script>
	





</html>