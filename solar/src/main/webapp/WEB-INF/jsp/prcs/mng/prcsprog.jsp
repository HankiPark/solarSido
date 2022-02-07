<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
.eqmImg {
	width: 150px;
	height: 150px;
}

.progressBar {
	background-color: #d3d3d3;
}

.pBar {
	background-color: #47af50;
}

.eqm {
	background-color: rgb(247, 247, 247);
	text-align: center;
}

.tk {
	position: absolute;
	z-index: 100;
	width: 128px;
	height: 86px;
	display: none;
}
</style>
<body>
	<h1>공정 진행 관리</h1>
	<div id="indicaDialog-form" title="작업지시번호"></div>
	<div id="prcsEqmDialog-form" title="공정선택"></div>
	<div id="empDialog-form" title="사원검색"></div>


	<div>
		<div class="row" id="sensePrdtIn">
			<div
				class="card card-pricing card-primary card-white card-outline col-4"
				id="sensePrdtInBody"
				style="margin-left: 50px; margin-right: 30px; margin-top: 70px; padding-left: 40px; margin-bottom: 250px; height: 600px">
				<div class="card-body">
					<div data-role="fieldcontain" style="margin-bottom: 20px; margin-top: 50px;"><label>지시번호 </label> <input type="text" id="indicaDetaNo">
					<button type="button" id="searchIndica">🔍</button></div>
					<div style="margin-bottom: 20px;"> <label>제품코드</label> <input type="text"
						id="prdtCd"></div><div style="margin-bottom: 20px;"> <label>공정명&nbsp;&nbsp;&nbsp;&nbsp;</label> <input
						type="text" id="prcsNm">
					<button type="button" id="searchEqm">🔍</button></div>
					<div style="margin-bottom: 20px;"> <label>라인번호</label> <input type="text"
						id="liNm"></div> <div style="margin-bottom: 20px;"><label>작업자&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<input type="text" id="empNm">
					<button type="button" id="searchEmp">🔍</button></div>
					<div style="margin-bottom: 10px;"><label>작업량&nbsp;&nbsp;&nbsp;&nbsp;</label> <input type="text" id="wkQty"></div>
					<div style="margin-bottom: 10px;"><input type="text" id="frTm">
					<button id="btnStart" style="margin-bottom:10px;width: 100px; height: 40px; font-size: 20px; border-radius: 5px;box-shadow:2px 2px 2px #74a3b0; padding: 6px 1px 6px 3px">시작</button></div>
					<div style="margin-bottom: 10px;"><input type="text" id="toTm">
					<button id="btnEnd" disabled="disabled" style="margin-bottom:10px;width: 100px; height: 40px; font-size: 20px; border-radius: 5px;box-shadow:2px 2px 2px #74a3b0; padding: 6px 1px 6px 3px">종료</button></div>
					
					<button id="btnAddRslt" style="margin-bottom:10px;margin-left:120px;width: 150px; height: 40px; font-size: 20px; border-radius: 5px;box-shadow:2px 2px 2px #74a3b0; padding: 6px 1px 6px 3px"><i class="far fa-registered"></i>실적등록</button>
					<div>
						<!-- 실시간으로 변화할 파트  -->
						<h1 id="prcsTimer"></h1>
					</div>
				</div>
			</div>

			<div class="col-7">
				<div id="prcsGrid1"></div>

				<div>
					
					<div class="flex row"><h3 id="whichPrcs">공정명</h3> &nbsp;&nbsp;
						<div class="col-2 eqm">
						
							<div>
								<img id="eqmImg1" class="eqmImg"
									src="${pageContext.request.contextPath}/images/eqm1.png"><br>1번설비:
								<span id="eqm1">0</span>
							</div>
							<div class="progressBar">
								<div id="pBar1" class="pBar" style="width: 0%">
									<div class="pBarText">0%</div>
								</div>
							</div>
						</div>
						<div class="col-2 eqm">
							<div>
								<img id="eqmImg2" class="eqmImg"
									src="${pageContext.request.contextPath}/images/eqm2.png"><br>2번설비:
								<span id="eqm2">0</span>
							</div>
							<div class="progressBar">
								<div id="pBar2" class="pBar" style="width: 0%">
									<div class="pBarText">0%</div>
								</div>
							</div>
						</div>
						<div class="col-2 eqm">
							<div>
								<img id="eqmImg3" class="eqmImg"
									src="${pageContext.request.contextPath}/images/eqm3.png"><br>3번설비:
								<span id="eqm3">0</span>
							</div>
							<div class="progressBar">
								<div id="pBar3" class="pBar" style="width: 0%">
									<div class="pBarText">0%</div>
								</div>
							</div>
						</div>
						<div class="col-2 eqm">
							<div>
								<img id="eqmImg4" class="eqmImg"
									src="${pageContext.request.contextPath}/images/eqm4.png"><br>4번설비:
								<span id="eqm4">0</span>
							</div>
							<div class="progressBar">
								<div id="pBar4" class="pBar" style="width: 0%">
									<div class="pBarText">0%</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

<script>
	/*---------------------------------------------------------*/
	let selectedPrdtCd;
	
	let fst=true,snd=true,trd=true,fth=true;
	
	function sleep(ms) {
		  return new Promise((r) => setTimeout(r, ms));
		}
	
	function pngToGif(i){
		let imgTag = document.getElementById('eqmImg'+i);
		imgTag.src = '${pageContext.request.contextPath}/images/eqm'+i+'.gif';
		sleep(3210).then(() => {imgTag.src = '${pageContext.request.contextPath}/images/eqm'+i+'.png';});
	}
	
	function setProgress(num, cnt, max) {
		let pBar = document.getElementById('pBar'+num);
		let eqm = document.getElementById('eqm'+num);
		pBar.style.width = (cnt/max*100)+'%';
	    pBar.childNodes[1].innerHTML = (cnt/max*100).toFixed(1)+'%';
	    eqm.innerText = cnt;
	    pngToGif(num);
	}
		
	function makeTk(num, cnt, max) {
		let pBar = document.getElementById('pBar'+num);
		let eqm = document.getElementById('eqm'+num);
		pBar.style.width = (cnt/max*100)+'%';
	    pBar.childNodes[1].innerHTML = (cnt/max*100).toFixed(1)+'%';
	    eqm.innerText = cnt;
	    moveTk(num);
	}
	function moveTk(i){
		let tk = document.getElementById('tk'+i);
		tk.style.display = 'block';
		if(parseInt(tk.style.left)<200){
			sleep(50).then(() => {tk.style.left = parseInt(tk.style.left)+5+'px';tk.style.top = parseInt(tk.style.top)+3+'px';moveTk(i);});
		}else{
			tk.style.display = 'none';
			tk.style.left = '0px';
			tk.style.top = '100px';
		}
	}
	
	/*----------------------------------------------------------*/
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
	
	let unit1Count=0;
	let unit2Count=0;
	let unit3Count=0;
	let unit4Count=0;
	
	
	
	// 공정진행 관리 insert에서 사용될 변수
	let pIndicaDetaNo;
	let pIndicaNo;
	let pIndicaDt;
	let pIstQty;
	let pPrdtCd;
	let pPrdtNm;
	let pProdFg;
	let pPrcsCd;
	
	let prcsPrM;
	
	let wkQty = document.getElementById("wkQty");
	
	// 선택한 사원정보를 담을 변수
	let sEmp;
	
	
	// 테스트용 변수 전역처리
	
	
	
		 
	
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
			formatter:'listItemText',
			editor: {
				type: 'text',
				options : {
					listItems : [
						{ text:'생산대기중', value: '0' },
						{ text:'태양전지 제조공정', value: '태양전지_제조공정'},
						{ text:'태양전지 전극공정', value: '태양전지_전극공정'},
						{ text:'모듈 용접 공정', value: '모듈_용접_공정'},
						{ text:'모듈 접합 공정', value: '모듈_접합_공정'},
						]
	            }
			}
		}, {
			header : '진행상태',
			name : 'lowSt'
		}
		];
	
	// 공정진행 그리드 데이터 호출
	const inDataSource = {
			   api : {
			      readData : {
			         url : '${pageContext.request.contextPath}/prcs/prcsBasicItem',
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
	  bodyHeight : 500,
	  minBodyHeight : 500,
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
						prdNm,
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
		pPrdtNm = prdNm;
		
		$("#indicaDetaNo").val(inddd);
		$("#prdtCd").val(prd);
		document.getElementById("wkQty").placeholder = "목표량 : "+tAmount;

		indicaDialog.dialog("close");
		
		
		
		var readParams = {
				'indicaDetaNo':indicaDetaNo
		}
		prcsGrid.readData(1,readParams,false);
		//prcsGrid.refreshLayout();
		
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
		whichPrcs.innerText = prcsNm;
		
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
				console.log("공정내 가동순서 > ")
				console.log("----------------------------------");
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
	     var hours = parseInt((((cTime / (1000 * 60 * 60)) % 24)+9) % 24);
	
	     var hours = (hours < 10) ? "0" + hours : hours;
	     var minutes = (minutes < 10) ? "0" + minutes : minutes;
	     var seconds = (seconds < 10) ? "0" + seconds : seconds;
	
	     const presentTime = new Date()
	     var years = presentTime.getFullYear();
	     var month = presentTime.getMonth()+1;
	     var days = presentTime.getDate();
	     
	     var month = (month < 10) ? "0" + month : month;
	     var days = (days < 10) ? "0" + days : days;
	      
	     //return years+"-"+month+"-"+days+" "+hours + ":" + minutes + ":" + seconds;
	     return hours + ":" + minutes + ":" + seconds;
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
 			
 			// 시작 버튼
 			$("#btnStart").on("click", function(ev){
 			
 					
 				
 				if(!!pIndicaDetaNo){
 					if(!!pPrcsCd){
 						let empNm = $('#empNm').val();
 						if(!(empNm=="")){
 							
 							let Yn = [];
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
 			 	 				
 			 	 				$("#frTm").val(sTime);
 			 	 				
 			 	 				// 시작버튼 시간 이벤트끝
 			 	 				
 			 	 				document.getElementById("wkQty").value=0;
 			 	 					
 			 	 				// 공정진행관리 첫번째 insert

 			 	 				
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
 			 	 						prcsPrM = result.prcsPrMVO;
 			 	 						console.log(prcsPrM);
 			 	 						console.log(prcsPrM.wkNo);
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
 			 							
 			 							const endTm = new Date(); 
 			 							console.log("-----------------1번장비 완료시점")
 			 							console.log((endTm-u1));
 			 							console.log(endTm);
 			 							let eqmETime = msToHMS(endTm);
 			 							let eqmSTime = msToHMS(endTm-u1);
 			 							console.log(eqmSTime+"공정시작시간");
 			 							console.log(eqmETime+"공정끝난시간");
 			 							console.log("-----------------1번장비 완료시점")
 			 														
 			 							
//-------------------------------------------------------------------------------------------------------------------------------
										let prcsSeq = prcsFlow.PRCSFLOW[0].prcsOrd;
 			 							let targetItems = [];
 			 							
										$.ajax({																			// RscClot table을 조회해 작동가능한 아이템을 읽어온다
										url:'${pageContext.request.contextPath}/prcs/prcsItem',
										data : {
											'indicaDetaNo':pIndicaDetaNo,
										},
										dataType: 'JSON',
										async: false,
										contentType: 'application/json',
										success : function(result){
											items = result.data.contents;
											if(prcsSeq==1){																// 첫번째 장비인경우 조건
												if(unit1Count < tAmount){												// 유닛 카운트가 생산목표보다 작을때까지 조건
/* 												console.log(items[unit1Count].prdtLot);
												console.log(unit1Count);
												 */
												for(let item of items){
													if(item.prcsCd=='0'){
														targetItems.push(item);
													}	
												}
												
													if(items[unit1Count].lowSt === 'W'){									// 현재가리키고있는 아이템의 상태가 'w' 대기일때 조건
														$.ajax({															// 현재가리키고있는 아이템의 상태를 'C' 완료로 update ajax
															url:"${pageContext.request.contextPath}/prcs/updateRscClot",
															data : {
																'prdtLot':targetItems[unit1Count].prdtLot	
															},
															dataType: 'JSON',
															async: false,
															contentType: 'application/json',
															success : function(result){
																console.log(targetItems[unit1Count].prdtLot+" 랏 장비 상태 업데이트 성공")
																
																$.ajax({													// 현재가리키고있는 아이템을 다음공정 'w' 대기상태로 insert ajsx
										 								url:"${pageContext.request.contextPath}/prcs/insertRscClot",
										 								data : {
										 									'prdtLot':targetItems[unit1Count].prdtLot,	
										 									'prcsCd': prcsEqmList.PRCS[0].prcsCd,		//공정코드  << 장비목록 0번
										 									'eqmCd': prcsFlow.PRCSFLOW[0].eqmCd,		//설비코드 << 장비목록 0번
										 									'wkNo': prcsPrM.wkNo,						//작업번호 << 리턴받은 기본값
										 									'prcsFrTm': eqmSTime,						//공정시작시간 << 계산된 시간 일단 임시로 쓰기
										 									'prcsToTm': eqmETime 						//공정종료시간 << 계산된 시간 일단 임시로 쓰기
										 								},
										 								dataType: 'JSON',
										 								async: false,
										 								contentType: 'application/json',
										 								success : function(result){
										 									//console.log("첫번째 공정완료");
										 									unit1Count++;
										 									console.log("카운트가 다음 장비를 가리킵니다")
										 									setProgress(1,unit1Count,tAmount);
										 								},
										 								error : function(result){
										 									console.log("등록실패")
										 								}
										 							}); 													// 현재가리키고있는 아이템을 다음공정 'w' 대기상태로 insert ajax				
															},
															error : function(result){
																console.log("호출실패")
															}
														});													// 현재가리키고있는 아이템의 상태를 'C' 완료로 업데이트 ajax
														
													}														// 현재가리키고있는 아이템의 상태가 'w' 대기일때 조건 				
												} else{
													
													console.log("지시량만큼 제 1공정을 마쳤습니다");
													
												}														// 유닛 카운트가 생산목표보다 작을때까지 조건
												console.log("성공성공");
											}															// 첫번째 장비인 경우 조건 끝
											else {														// 첫번째 장비가 아닌경우 조건
//-------------------------------------------------------------------------------------------------------------------------------														
												let prcsSeq = prcsFlow.PRCSFLOW[0].prcsOrd;
												let thisUnitCd = prcsFlow.PRCSFLOW[0].eqmCd;
												let itemSt = prcsFlow.PRCSFLOW[0].lowSt;
												let items = [];
												let targetItems = [];
										
												$.ajax({																			// RscClot table을 조회해 작동가능한 아이템을 읽어온다
													url:'${pageContext.request.contextPath}/prcs/prcsItem',
													data : {
														'indicaDetaNo':pIndicaDetaNo,
														},
													dataType: 'JSON',
													async: false,
													contentType: 'application/json',
													success : function(result){
														items = result.data.contents;
														console.log(items.length);
													
														for(let item of items){
															if(prcsSeq-1 == item.prcsOrd){
																targetItems.push(item);
															}	
														}
	
														if(unit1Count < tAmount){												// 유닛 카운트가 생산목표보다 작을때까지 조건
														console.log(targetItems[unit1Count].prdtLot);
														console.log(unit1Count);
															if(targetItems[unit1Count].lowSt === 'W'){									// 현재가리키고있는 아이템의 상태가 'w' 대기일때 조건
																$.ajax({															// 현재가리키고있는 아이템의 상태를 'C' 완료로 update ajax
																	url:"${pageContext.request.contextPath}/prcs/updateRscClot",
																	data : {
																		'prdtLot':targetItems[unit1Count].prdtLot	
																	},
																	dataType: 'JSON',
																	async: false,
																	contentType: 'application/json',
																	success : function(result){
																		console.log(targetItems[unit1Count].prdtLot+" 랏 장비 상태 업데이트 성공")
																		
																		$.ajax({													// 현재가리키고있는 아이템을 다음공정 'w' 대기상태로 insert ajsx
												 								url:"${pageContext.request.contextPath}/prcs/insertRscClot",
												 								data : {
												 									'prdtLot':targetItems[unit1Count].prdtLot,	
												 									'prcsCd': prcsEqmList.PRCS[0].prcsCd,		//공정코드  << 장비목록 0번
												 									'eqmCd': prcsFlow.PRCSFLOW[0].eqmCd,		//설비코드 << 장비목록 0번
												 									'wkNo': prcsPrM.wkNo,						//작업번호 << 리턴받은 기본값
												 									'prcsFrTm': eqmSTime,						//공정시작시간 << 계산된 시간 일단 임시로 쓰기
												 									'prcsToTm': eqmETime 						//공정종료시간 << 계산된 시간 일단 임시로 쓰기
												 								},
												 								dataType: 'JSON',
												 								async: false,
												 								contentType: 'application/json',
												 								success : function(result){
												 									//console.log("첫번째 공정완료");
												 									unit1Count++;
												 									console.log("1번장비 "+unit1Count+"번 완료");
												 									//console.log("카운트가 다음 장비를 가리킵니다")
												 									setProgress(1,unit1Count,tAmount);
												 								},
												 								error : function(result){
												 									console.log("등록실패")
												 								}
												 							}); 													// 현재가리키고있는 아이템을 다음공정 'w' 대기상태로 insert ajax				
																	},
																	error : function(result){
																		console.log("호출실패")
																	}
																});													// 현재가리키고있는 아이템의 상태를 'C' 완료로 업데이트 ajax
																
															}														// 현재가리키고있는 아이템의 상태가 'w' 대기일때 조건 				
														} else{
															
															console.log("지시량만큼 돌았습니다 타이머 유닛1을 종료합니다");
															clearTimeout(unit1);
														}														// 유닛 카운트가 생산목표보다 작을때까지 조건
															console.log("성공성공");
													},
													error : function(result){
														console.log("mmmmmmmmmmmmmmmmmmmmmmmmm장비리스트 호출 실패")
													}
													
												
											});																// RscClot table을 조회해 작동가능한 아이템을 읽어온다	
//-------------------------------------------------------------------------------------------------------------------------------	
												}															// 첫번째 장비가 아닌경우 조건 끝	
													
													
												},
												error : function(result){
													console.log("mmmmmmmmmmmmmmmmmmmmmmmmm장비리스트 호출 실패")
												}
												
											
											});																	// RscClot table을 조회해 작동가능한 아이템을 읽어온다  
	
//------------------------------------------------------------------------------------------------------------------------------- 			 						
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

 			 							const endTm = new Date(); 
 			 							var eqmETime = msToHMS(endTm);
 			 							var eqmSTime = msToHMS(endTm-u2);
 			 							console.log(eqmSTime+"공정시작시간");
 			 							console.log(eqmETime+"공정끝난시간");
//------------------------------------------------------------------------------------------------------------------------------- 
 			 							let prcsSeq = prcsFlow.PRCSFLOW[1].prcsOrd;
										let thisUnitCd = prcsFlow.PRCSFLOW[1].eqmCd;
										let itemSt = prcsFlow.PRCSFLOW[0].lowSt;
										let items = [];
										let targetItems = [];
								
										$.ajax({																			// RscClot table을 조회해 작동가능한 아이템을 읽어온다
										url:'${pageContext.request.contextPath}/prcs/prcsItem',
										data : {
											'indicaDetaNo':pIndicaDetaNo,
										},
										dataType: 'JSON',
										async: false,
										contentType: 'application/json',
										success : function(result){
											items = result.data.contents;
											console.log(items.length);
											console.log(prcsSeq);
											
											for(let item of items){
												//if(prcsSeq-1 == item.prcsOrd && prcsPrM.wkNo == item.wkNo){
													if(prcsSeq-1 == item.prcsOrd){
														targetItems.push(item);
													}												
												}	
											
											if(unit2Count < tAmount){												// 유닛 카운트가 생산목표보다 작을때까지 조건
											console.log(targetItems[unit2Count].prdtLot);
												if(targetItems[unit2Count].lowSt === 'W'){									// 현재가리키고있는 아이템의 상태가 'w' 대기일때 조건
													$.ajax({															// 현재가리키고있는 아이템의 상태를 'C' 완료로 update ajax
														url:"${pageContext.request.contextPath}/prcs/updateRscClot",
														data : {
															'prdtLot':targetItems[unit2Count].prdtLot	
														},
														dataType: 'JSON',
														async: false,
														contentType: 'application/json',
														success : function(result){
															console.log(targetItems[unit2Count].prdtLot+" 랏 장비 상태 업데이트 성공")
															
															$.ajax({													// 현재가리키고있는 아이템을 다음공정 'w' 대기상태로 insert ajsx
									 								url:"${pageContext.request.contextPath}/prcs/insertRscClot",
									 								data : {
									 									'prdtLot':targetItems[unit2Count].prdtLot,	
									 									'prcsCd': prcsEqmList.PRCS[1].prcsCd,		//공정코드  << 장비목록 0번
									 									'eqmCd': prcsFlow.PRCSFLOW[1].eqmCd,		//설비코드 << 장비목록 0번
									 									'wkNo': prcsPrM.wkNo,						//작업번호 << 리턴받은 기본값
									 									'prcsFrTm': eqmSTime,						//공정시작시간 << 계산된 시간 일단 임시로 쓰기
									 									'prcsToTm': eqmETime 						//공정종료시간 << 계산된 시간 일단 임시로 쓰기
									 								},
									 								dataType: 'JSON',
									 								async: false,
									 								contentType: 'application/json',
									 								success : function(result){
									 									//console.log("첫번째 공정완료");
									 									unit2Count++;
									 									console.log("카운트가 다음 장비를 가리킵니다")
									 									setProgress(2,unit2Count,tAmount);
									 								},
									 								error : function(result){
									 									console.log("등록실패")
									 								}
									 							}); 													// 현재가리키고있는 아이템을 다음공정 'w' 대기상태로 insert ajax				
														},
														error : function(result){
															console.log("호출실패")
														}
													});													// 현재가리키고있는 아이템의 상태를 'C' 완료로 업데이트 ajax
													
												}														// 현재가리키고있는 아이템의 상태가 'w' 대기일때 조건 				
											} else{
												
												console.log("지시량만큼 돌았습니다 타이머 유닛1을 종료합니다");
												clearTimeout(unit1);
											}														// 유닛 카운트가 생산목표보다 작을때까지 조건
												console.log("성공성공");
										},
										error : function(result){
											console.log("mmmmmmmmmmmmmmmmmmmmmmmmm장비리스트 호출 실패")
										}
										
									
									});																// RscClot table을 조회해 작동가능한 아이템을 읽어온다   
		
//------------------------------------------------------------------------------------------------------------------------------- 			 							
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

 			 							const endTm = new Date(); 
 			 							var eqmETime = msToHMS(endTm);
 			 							var eqmSTime = msToHMS(endTm-u3);
 			 							console.log(eqmSTime+"공정시작시간");
 			 							console.log(eqmETime+"공정끝난시간");
 			 							console.log("-----------------완료시점")			
//------------------------------------------------------------------------------------------------------------------------------- 
 			 							let prcsSeq = prcsFlow.PRCSFLOW[2].prcsOrd;
										let thisUnitCd = prcsFlow.PRCSFLOW[2].eqmCd;
										let itemSt = prcsFlow.PRCSFLOW[2].lowSt;
										let items = [];
										let targetItems = [];
								
										$.ajax({																			// RscClot table을 조회해 작동가능한 아이템을 읽어온다
										url:'${pageContext.request.contextPath}/prcs/prcsItem',
										data : {
											'indicaDetaNo':pIndicaDetaNo,
										},
										dataType: 'JSON',
										async: false,
										contentType: 'application/json',
										success : function(result){
											items = result.data.contents;
											console.log(items.length);
											console.log(prcsSeq);
																						
											for(let item of items){
												//if(prcsSeq-1 == item.prcsOrd && prcsPrM.wkNo == item.wkNo){
												if(prcsSeq-1 == item.prcsOrd){
													targetItems.push(item);
												}	
											}
											
											if(unit3Count < tAmount){												// 유닛 카운트가 생산목표보다 작을때까지 조건
											console.log(unit3Count);
											console.log(targetItems[unit3Count].prdtLot);
												if(targetItems[unit3Count].lowSt === 'W'){									// 현재가리키고있는 아이템의 상태가 'w' 대기일때 조건
													$.ajax({															// 현재가리키고있는 아이템의 상태를 'C' 완료로 update ajax
														url:"${pageContext.request.contextPath}/prcs/updateRscClot",
														data : {
															'prdtLot':targetItems[unit3Count].prdtLot	
														},
														dataType: 'JSON',
														async: false,
														contentType: 'application/json',
														success : function(result){
															console.log(targetItems[unit3Count].prdtLot+" 랏 장비 상태 업데이트 성공")
															
															$.ajax({													// 현재가리키고있는 아이템을 다음공정 'w' 대기상태로 insert ajsx
									 								url:"${pageContext.request.contextPath}/prcs/insertRscClot",
									 								data : {
									 									'prdtLot':targetItems[unit3Count].prdtLot,	
									 									'prcsCd': prcsEqmList.PRCS[2].prcsCd,		//공정코드  << 장비목록 0번
									 									'eqmCd': prcsFlow.PRCSFLOW[2].eqmCd,		//설비코드 << 장비목록 0번
									 									'wkNo': prcsPrM.wkNo,						//작업번호 << 리턴받은 기본값
									 									'prcsFrTm': eqmSTime,						//공정시작시간 << 계산된 시간 일단 임시로 쓰기
									 									'prcsToTm': eqmETime 						//공정종료시간 << 계산된 시간 일단 임시로 쓰기
									 								},
									 								dataType: 'JSON',
									 								async: false,
									 								contentType: 'application/json',
									 								success : function(result){
									 									//console.log("첫번째 공정완료");
									 									unit3Count++;
									 									console.log("카운트가 다음 장비를 가리킵니다")
 									 									setProgress(3,unit3Count,tAmount);
									 								},
									 								error : function(result){
									 									console.log("등록실패")
									 								}
									 							}); 													// 현재가리키고있는 아이템을 다음공정 'w' 대기상태로 insert ajax				
														},
														error : function(result){
															console.log("호출실패")
														}
													});													// 현재가리키고있는 아이템의 상태를 'C' 완료로 업데이트 ajax
													
												}														// 현재가리키고있는 아이템의 상태가 'w' 대기일때 조건 				
											} else{
												
												console.log("지시량만큼 돌았습니다 타이머 유닛1을 종료합니다");
												clearTimeout(unit1);
											}														// 유닛 카운트가 생산목표보다 작을때까지 조건
												console.log("성공성공");
										},
										error : function(result){
											console.log("mmmmmmmmmmmmmmmmmmmmmmmmm장비리스트 호출 실패")
										}
										
									
									});																// RscClot table을 조회해 작동가능한 아이템을 읽어온다   
		
//------------------------------------------------------------------------------------------------------------------------------- 			 						
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
 			 							
 			 							let complete = false;
 			 							
 			 							const endTm = new Date();
 			 							var eqmETime = msToHMS(endTm);
 			 							var eqmSTime = msToHMS(endTm-u4);
 			 							console.log(eqmSTime+"공정시작시간");
 			 							console.log(eqmETime+"공정끝난시간");
 			 							console.log("-----------------완료시점")	
//------------------------------------------------------------------------------------------------------------------------------- 
 			 							let prcsSeq = prcsFlow.PRCSFLOW[3].prcsOrd;
										let thisUnitCd = prcsFlow.PRCSFLOW[3].eqmCd;
										let itemSt = prcsFlow.PRCSFLOW[3].lowSt;
										let items = [];
										let targetItems = [];
						
										$.ajax({																			// RscClot table을 조회해 작동가능한 아이템을 읽어온다
										url:'${pageContext.request.contextPath}/prcs/prcsItem',
										data : {
											'indicaDetaNo':pIndicaDetaNo,
										},
										dataType: 'JSON',
										async: false,
										contentType: 'application/json',
										success : function(result){
											items = result.data.contents;
											console.log(items.length);
											console.log(prcsSeq);
											
											for(let item of items){
												//if(prcsSeq-1 == item.prcsOrd && prcsPrM.wkNo == item.wkNo){
													if(prcsSeq-1 == item.prcsOrd){
													targetItems.push(item);
												}		
											}
											
											if(unit4Count < tAmount){												// 유닛 카운트가 생산목표보다 작을때까지 조건
											console.log(targetItems[unit4Count].prdtLot);
											console.log(unit4Count);
												if(targetItems[unit4Count].lowSt === 'W'){									// 현재가리키고있는 아이템의 상태가 'w' 대기일때 조건
													$.ajax({															// 현재가리키고있는 아이템의 상태를 'C' 완료로 update ajax
														url:"${pageContext.request.contextPath}/prcs/updateRscClot",
														data : {
															'prdtLot':targetItems[unit4Count].prdtLot	
														},
														dataType: 'JSON',
														async: false,
														contentType: 'application/json',
														success : function(result){
															console.log(targetItems[unit4Count].prdtLot+" 랏 장비 상태 업데이트 성공")
															
															$.ajax({													// 현재가리키고있는 아이템을 다음공정 'w' 대기상태로 insert ajsx
									 								url:"${pageContext.request.contextPath}/prcs/insertRscClot",
									 								data : {
									 									'prdtLot':targetItems[unit4Count].prdtLot,	
									 									'prcsCd': prcsEqmList.PRCS[3].prcsCd,		//공정코드  << 장비목록 0번
									 									'eqmCd': prcsFlow.PRCSFLOW[3].eqmCd,		//설비코드 << 장비목록 0번
									 									'wkNo': prcsPrM.wkNo,						//작업번호 << 리턴받은 기본값
									 									'prcsFrTm': eqmSTime,						//공정시작시간 << 계산된 시간 일단 임시로 쓰기
									 									'prcsToTm': eqmETime 						//공정종료시간 << 계산된 시간 일단 임시로 쓰기
									 								},
									 								dataType: 'JSON',
									 								async: false,
									 								contentType: 'application/json',
									 								success : function(result){
									 									//console.log("네번째 공정완료");
									 									unit4Count++;
									 									console.log("4번장비 "+unit4Count+"번 완료");
									 									wkQty.value = wkQty.value*1+1;
									 									console.log(wkQty);
									 									console.log("카운트가 네번째 설비의 다음 아이템을 가리킵니다")
 									 									setProgress(4,unit4Count,tAmount);
									 								},
									 								error : function(result){
									 									console.log("등록실패")
									 								}
									 							}); 													// 현재가리키고있는 아이템을 다음공정 'w' 대기상태로 insert ajax				
														},
														error : function(result){
															console.log("호출실패")
														}
													});													// 현재가리키고있는 아이템의 상태를 'C' 완료로 업데이트 ajax
													
												}														// 현재가리키고있는 아이템의 상태가 'w' 대기일때 조건 				
											} else{
												
												console.log("마지막 설비가 지시량횟수만큼 공정을 완료했습니다");
												
												clearTimeout(unit1);
	 			 			 					clearTimeout(unit2);
	 			 			 					clearTimeout(unit3);
	 			 			 					clearTimeout(unit4);
	 			 			 					clearInterval(timer);
	 			 			 	 			    starFlag = true;
		 			 			 	 			
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
		 			 		 					
		 			 		 					alert("마지막 설비가 완료되어 공정을 종료합니다 실적등록을 해주세요");
												
		 			 		 					complete = true;
												
												
											
											}														// 유닛 카운트가 생산목표보다 작을때까지 조건
												console.log("성공성공");
										},
										error : function(result){
											console.log("mmmmmmmmmmmmmmmmmmmmmmmmm장비리스트 호출 실패")
										}
										
									
									});																// RscClot table을 조회해 작동가능한 아이템을 읽어온다   
							
										if(!complete){
											unit4 = setTimeout(tick, u4);
										}
									
//------------------------------------------------------------------------------------------------------------------------------- 			 						
 			 							 // (*)
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

 				$("#btnAddRslt").on("click", function(){			// 실적 등록 버튼 이벤트 
 					
 					console.log(pIstQty);
 					console.log(pPrdtCd);
 					console.log(pPrcsCd);
 					
 					
 					$.ajax({
						url:"${pageContext.request.contextPath}/prcs/insertRslt",
						data : {
							'prcsCd':prcsCd,
							'empId':empId,
							'prcsCd':prcsCd,
							'istQty':itsQty,
							'rsltQty':rsltQty,
							'inferQty':inferQty,
							'frTm':frTm,
							'toTm':toTm,
							'wkNo':wkNo,
							'wkDt':wkDt
						},
						dataType: 'JSON',
						async: false,
						contentType: 'application/json',
						success : function(result){
												
						},
						error : function(result){
							console.log("실적등록 실패")
						}
					});	
 					
 				});
 				
 				
 				
 				
	}	// 공정타이머 함수 끝	
	
	
	
	$("#btnTest1").on("click", function(ev){
		console.log(document.getElementById("wkQty").value);
		console.log(wkQty);
		
	});
	
	$("#btnTest2").on("click", function(ev){
		let prcsSeq = prcsFlow.PRCSFLOW[0].prcsOrd;
		let thisUnitCd = prcsFlow.PRCSFLOW[0].eqmCd;
		let itemSt = prcsFlow.PRCSFLOW[0].lowSt;
		let items = [];
		let targetItems = [];
		
		console.log("두번째부터 테스트 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ")
		console.log(unit1Count);
		console.log(tAmount);
		console.log(pIndicaDetaNo);
		console.log(prcsSeq);
		console.log(thisUnitCd);
		console.log("두번째부터 테스트 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ")
		

		$.ajax({																			// RscClot table을 조회해 작동가능한 아이템을 읽어온다
		url:'${pageContext.request.contextPath}/prcs/prcsItem',
		data : {
			'indicaDetaNo':pIndicaDetaNo,
		},
		dataType: 'JSON',
		async: false,
		contentType: 'application/json',
		success : function(result){
			console.log("mmmmmmmmmmmmmmmmmmmmmmmmm장비리스트 호출 성공")
			console.log(result.data.contents);
			items = result.data.contents;
			console.log(items.length);
			console.log(items[12].prcsOrd);
			console.log(items[12].prcsOrd-1);
			console.log(prcsSeq);
			
			console.log("중요테스트입니다 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ")
			
			console.log(prcsPrM.wkNo)
			
			
			for(let item of items){
				//if(prcsSeq == item.prcsOrd && prcsPrM.wkNo == item.wkNo){
					if(prcsSeq-1 == item.prcsOrd){
					targetItems.push(item);
				}
			}	
			
					console.log(targetItems);
			
			console.log("중요테스트입니다 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ")
			
			if(unit2Count < tAmount){												// 유닛 카운트가 생산목표보다 작을때까지 조건
			console.log(targetItems[unit2Count].prdtLot);
			console.log(unit2Count);
				if(targetItems[unit2Count].lowSt === 'W'){									// 현재가리키고있는 아이템의 상태가 'w' 대기일때 조건
					$.ajax({															// 현재가리키고있는 아이템의 상태를 'C' 완료로 update ajax
						url:"${pageContext.request.contextPath}/prcs/updateRscClot",
						data : {
							'prdtLot':items[unit2Count].prdtLot	
						},
						dataType: 'JSON',
						async: false,
						contentType: 'application/json',
						success : function(result){
							console.log(targetItems[unit2Count].prdtLot+" 랏 장비 상태 업데이트 성공")
							
							$.ajax({													// 현재가리키고있는 아이템을 다음공정 'w' 대기상태로 insert ajsx
	 								url:"${pageContext.request.contextPath}/prcs/insertRscClot",
	 								data : {
	 									'prdtLot':targetItems[unit2Count].prdtLot,	
	 									'prcsCd': prcsEqmList.PRCS[1].prcsCd,		//공정코드  << 장비목록 0번
	 									'eqmCd': prcsFlow.PRCSFLOW[1].eqmCd,		//설비코드 << 장비목록 0번
	 									'wkNo': prcsPrM.wkNo,						//작업번호 << 리턴받은 기본값
	 									'prcsFrTm': eqmSTime,						//공정시작시간 << 계산된 시간 일단 임시로 쓰기
	 									'prcsToTm': eqmETime 						//공정종료시간 << 계산된 시간 일단 임시로 쓰기
	 								},
	 								dataType: 'JSON',
	 								async: false,
	 								contentType: 'application/json',
	 								success : function(result){
	 									console.log("첫번째 공정완료");
	 									unit1Count++;
	 									console.log("카운트가 다음 장비를 가리킵니다")
	 									setProgress(1,unit1Count,10);
	 								},
	 								error : function(result){
	 									console.log("등록실패")
	 								}
	 							}); 													// 현재가리키고있는 아이템을 다음공정 'w' 대기상태로 insert ajax				
						},
						error : function(result){
							console.log("호출실패")
						}
					});													// 현재가리키고있는 아이템의 상태를 'C' 완료로 업데이트 ajax
					
				}														// 현재가리키고있는 아이템의 상태가 'w' 대기일때 조건 				
			} else{
				
				console.log("지시량만큼 돌았습니다 타이머 유닛1을 종료합니다");
				clearTimeout(unit1);
			}														// 유닛 카운트가 생산목표보다 작을때까지 조건
				console.log("성공성공");
		},
		error : function(result){
			console.log("mmmmmmmmmmmmmmmmmmmmmmmmm장비리스트 호출 실패")
		}
		
	
	});																// RscClot table을 조회해 작동가능한 아이템을 읽어온다   
		
		
		
		
	});
	$('#sensePrdtIn').resize(function(){
		if($('#sensePrdtIn').width()<1780){
			$('#sensePrdtInBody').css('paddingLeft','15px');
		}else{
			$('#sensePrdtInBody').css('paddingLeft','40px');
		}
	})
 		
	</script>
</html>