<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산계획관리</title>
</head>
<style>
.card-outline2{
border-top:3px solid #FECEBB;
}
</style>
<body>
	<h2>생산계획 관리</h2>

	<!-- 모달 -->
	<div id="prodPlanModal" title="생산계획서 목록"></div>
	<div id="orderModal" title="미계획 주문서 목록"></div>

	<!-- 생산계획 테이블 -->
	<div class="card card-pricing card-primary card-white card-outline"
		style="margin-left: 30px; margin-right: 30px; padding-left: 40px; margin-bottom: 30px;">
		<div class="card-body">
			<div class="row">
				<div class="col-9">
					<form action="planMngFrm" name="planMngFrm">
						<div>
							<label>계획일자<span style="color: red">*</span></label> <input
								type="date" id="planDt" name="planDt" required> <label>생산계획명<span
								style="color: red">*</span></label> <input type="text" id="planNm"
								name="planNm" required>
						</div>
						<div>
							<button type="button" id="btnReset" style="margin-top:5px">초기화</button>
							<button type="button" id="btnSave" style="margin-top:5px">저장</button>
							<!--  <button type="button" id="btnDel">삭제</button> -->
						</div>
					</form>
				</div>
				<div class="col-3">
					<label>생산계획서 조회</label>
					<button type="button" id="btnFind">🔍</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 생산계획 상세 그리드-->
	<div class="card card-pricing card-primary card-white card-outline2"
		style="margin-left: 30px; margin-right: 30px; padding-left: 40px; margin-bottom: 30px;">
		<div class="card-body">
			<div id="planDgrid">
				<div class="row">
					<div class="col-7">
						<label>계획번호</label> <input type="text" id="planNo" name="planNo"
							readonly>
					</div>
					<div id="btnMng" class="col-5" style="margin-top: -10px">
						<button type="button" id="rowAdd">추가</button>
						<button type="button" id="rowDel">삭제</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- 자재 재고체크 그리드 -->
	<div class="card card-pricing card-primary card-white card-outline2 "
		style="margin-left: 30px; margin-right: 30px; padding-left: 40px; margin-bottom: 30px;">
		<div class="card-body">
			<div id="rStcGrid" class="row">
				<label>필요자재 재고 체크</label>
			</div>
		</div>
	</div>
	
	<div class="card card-pricing card-primary card-white card-outline2 "
		style="margin-left: 30px; margin-right: 30px; padding-left: 40px; margin-bottom: 30px;/*  display:none */" id="rstcDiv">
		<div class="card-body">
			<div id="hdRstcGrid" class="row">
				<div class="col-9">
					<label>발주요청 자재 목록</label>
				</div>
				<div class="col-3" style="margin-top: -10px; display:none; id="orderBtnDiv">
					<button type="button" id="rscOrder"
						style="box-shadow:2px 2px 2px #74a3b0; width: 150px; height: 40px; font-size: 20px; border-radius: 5px; padding: 6px 1px 6px 3px ;boxShadow:2px 2px 2px #74a3b0">
						<i class="far fa-folder-open"></i> &nbsp; 발주요청
					</button>
				</div>
			</div>
		</div>
	</div>
	
</body>

<!-- 스크립트 -->
<script type="text/javascript">
	let pDt = new Date();
	document.getElementById('planDt').value = pDt.toISOString().substring(0, 10);
	
	tui.Grid.setLanguage('ko');
	
	//변수
	let odCnt= 0; //발주요청 여부 확인
	console.log(odCnt);
	//------------------------------그리드생성------------------------------------------------
	//생산계획 상세 그리드
	let planDgrid = new tui.Grid({
		el: document.getElementById('planDgrid'),
		data: {
			api: {
				readData: { 
					url: '${pageContext.request.contextPath}/grid/planGrid.do', 
					method: 'GET'
					},
				modifyData: { 
					url: '${pageContext.request.contextPath}/grid/planModify.do', 
					method: 'POST'
					}
				},
			contentType: 'application/json',
			initialRequest: false //초기에 안보이게 함
		}, 
		scrollX: false,
		scrollY: true,
		bodyHeight: 250,
		rowHeaders: [{
			type: 'checkbox',
			width: 40}],
		columns: [
			 {
			    header: '계획번호',
			    name: 'planNo',
			    hidden: true
			  },
		 	 {
			    header: '계획명',
			    name: 'planNm',
			    hidden: true
			  },
			  {
			    header: '계획일자',
			    name: 'planDt',
			    hidden: true
			  },
			  {
			    header: '계획상세번호',
			    name: 'planDetaNo',
			    hidden: true
			  },
			  { //주문없는 계획 불가
			    header: '주문번호',
			    name: 'orderNo',
			    validation: {
	    	        required: true
	    	      }
			  },
			  { header: '접수일자',
			    name: 'recvDt',
			   	hidden: true
			  },
			  {
			    header: '제품코드',
			    name: 'prdtCd',
			    validation: {
	    	        required: true
	    	      }
			  },		  
			  {
			    header: '제품명',
			    name: 'prdtNm'
			  },
			  {
			    header: '납기일자',
			    name: 'paprdDt',
			    filter: {
		            type: 'date',
		            format: 'YYYY-MM-DD'
		          }
			  },
			  {
			    header: '주문량',
			    name: 'orderQty',
			    align: 'right',
			  },
			 {
			    header: '계획량',
			    name: 'planQty',
			    align: 'right',
			    editor : 'text',
			    validation: {
	    	        required: true
	    	      },
			    onAfterChange(e) {
	    			console.log("e.rowkey:"+e.rowKey+" & e.value:"+e.value)
	    	    	calProdDay( e, "planQty", "dayOutput" ); 
	    	    	for ( i=0; i< rStcGrid.getRowCount(); i++){
	    	    		rStcGrid.setValue(i, 'ndStc',
	    	    				e.value * rStcGrid.getValue(i, 'rscUseQty'));
	    	    	}
	    	    }    	
			  },
			  {
			    header: '일생산량',
			    name: 'dayOutput',
			    align: 'right',
			  },
			  {
			    header: '생산일수',
			    name: 'prodDay',
			    align: 'right'
			  },
			  {
			    header: '작업시작일',
			    name: 'wkDt',
			    editor :'datePicker',
			    validation: {
	    	        required: true
	    	      },
				filter: {
		            type: 'date',
		            format: 'YYYY-MM-DD'
		          }
			  },
			  {
			    header: '작업순서',
			    name: 'wkOrd',
			    editor : 'text',
			    hidden : true
			  }
	 		 ]
	});	
	
	//자재재고 체크 그리드
	let rStcGrid = new tui.Grid({
		el: document.getElementById('rStcGrid'),
		data: {
			  api: {
			    	readData: {
						url: '${pageContext.request.contextPath}/grid/rStcGrid.do', 
						method: 'GET',
						initParams : { 
							orderNo: 'orderNo',
							prdtCd: 'prdtCd'
						}
			    	}
			  },
				contentType: 'application/json',
				initialRequest: false //초기에 안보이게 함
			},
		scrollX: false,
		scrollY: true,
		bodyHeight: 250,
		rowHeaders : [ 'rowNum','checkbox' ],
		columns: [
					 {
					    header: '제품코드',
					    name: 'prdtCd',
					  },
					  {
					    header: '제품명',
					    name: 'prdtNm',
					  },
					  {
					    header: '자재코드',
					    name: 'rscCd'
					  },
					  {
					    header: '자재명',
					    name: 'rscNm'
					  },
					  {
					    header: '소요량(개당)',
					    name: 'rscUseQty',
					    align: 'right'
					  },
					  {
					    header: '필요량',
					    name: 'ndStc',
					    align: 'right'
					  },
					  {
					    header: '재고량',
					    name: 'rscStc',
					    align: 'right'
					  },
					  {
					    header: '부족량',
					    name: 'lackStc',
					    align: 'right'
					  }
				]
	});
	
	//발주요청 자재목록 그리드
	let hdRstcGrid = new tui.Grid({
		el: document.getElementById('hdRstcGrid'),
		data: null,
		scrollX: false,
		scrollY: true,
		bodyHeight: 250,
		rowHeaders : [ 'rowNum' ],
		columns: [
					 {
					    header: '제품코드',
					    name: 'prdtCd',
					  },
					  {
					    header: '제품명',
					    name: 'prdtNm',
					  },
					  {
					    header: '자재코드',
					    name: 'rscCd'
					  },
					  {
					    header: '자재명',
					    name: 'rscNm'
					  },
					  {
					    header: '발주요청량',
					    name: 'lackStc',
					    align: 'right'
					  }
				]
	});
	//------------------------------모달------------------------------------------------------
	//생산계획서 모달
	let prodPlanDialog = $("#prodPlanModal").dialog({
		autoOpen : false,
		modal : true,
		width : 900,
		height : 600,
		buttons : {
			'확인': function(){
				prodPlanDialog.dialog("close");
			}
		}
	});
	
	//미계획 주문서 모달
	let orderDialog = $("#orderModal").dialog({
			autoOpen : false,
			modal : true,
			width : 900,
			height : 600,
			buttons : {
				'확인': function(){
					orderDialog.dialog("close");
				}
			}
		});
	
	//------------------------------그리드이벤트------------------------------------------------
	//계획상세 그리드 이벤트	
	planDgrid.on('editingFinish', function(ev){
		if(ev.columnName == "planQty") {
			let orderQty = planDgrid.getValue(ev.rowKey, "orderQty");
			let planQty = planDgrid.getValue(ev.rowKey, "planQty");
			if(orderQty != planQty){
				toastr.warning("주문량과 계획량이 다릅니다.");
				planDgrid.setValue(ev.rowKey, "planQty", planDgrid.getValue(ev.rowKey, "orderQty")); 
			} else {  
				let prdtCd = planDgrid.getValue(ev.rowKey, "prdtCd")
				let prdtNm = planDgrid.getValue(ev.rowKey, "prdtNm")
				let orderNo = planDgrid.getValue(ev.rowKey, "orderNo")
				
				$('#prdtCd').val(prdtCd);
				$('#prdtNm').val(prdtNm);
				$('#orderNo').val(orderNo);
				
				var stcGridParams = {
						'prdtCd' : prdtCd,
						'prdtNm' : prdtNm,
						'orderNo' : orderNo
				};
				rStcGrid.readData(1, stcGridParams, true)
				//fetch
				//settimeout -> delay
				setTimeout(function(){
				for ( i=0; i< rStcGrid.getRowCount(); i++){
		    		rStcGrid.setValue(i, 'ndStc',
		    				planDgrid.getValue(ev.rowKey, "planQty") * rStcGrid.getValue(i, 'rscUseQty'));
					rStcGrid.setValue(i, 'lackStc',
							rStcGrid.getValue(i, 'ndStc')-rStcGrid.getValue(i, 'rscStc'))}
				}, 1600); //실행시킬 함수, 딜레이시간;
			}	
		}
		if(ev.columnName == "wkDt") {
			let paprdDt = planDgrid.getValue(ev.rowKey, "paprdDt");
			let wkDt = planDgrid.getValue(ev.rowKey, "wkDt");
			let prodDay = planDgrid.getValue(ev.rowKey, "prodDay");
			if(paprdDt < wkDt){
				toastr.warning("작업일이 납기일보다 늦습니다.");
				planDgrid.setValue(ev.rowKey, "wkDt", "");
			} else if(paprdDt < dayAdd(wkDt, Number(prodDay)) ){
				toastr.warning("작업시간이 부족합니다.");
				planDgrid.setValue(ev.rowKey, "wkDt", "");
			} 
		}
	});
	
	planDgrid.on('dblclick', function(ev){
		if(ev.columnName != "wkDt" || ev.columnName != "planQty") {
			let prdtCd = planDgrid.getValue(ev.rowKey, "prdtCd")
			let prdtNm = planDgrid.getValue(ev.rowKey, "prdtNm")
			let orderNo = planDgrid.getValue(ev.rowKey, "orderNo")
			
			$('#prdtCd').val(prdtCd);
			$('#prdtNm').val(prdtNm);
			$('#orderNo').val(orderNo);
			
			var stcGridParams = {
					'prdtCd' : prdtCd,
					'orderNo' : orderNo
			};
			rStcGrid.readData(1, stcGridParams, true)
			setTimeout(function(){
			for ( i=0; i< rStcGrid.getRowCount(); i++){
	    		rStcGrid.setValue(i, 'ndStc',
	    				planDgrid.getValue(ev.rowKey, "planQty") * rStcGrid.getValue(i, 'rscUseQty'));
				rStcGrid.setValue(i, 'lackStc',
						rStcGrid.getValue(i, 'ndStc')-rStcGrid.getValue(i, 'rscStc'))}
			}, 1600); //실행시킬 함수, 딜레이시간;
		}
	});
	
	planDgrid.on('onGridUpdated', function() {
		planDgrid.refreshLayout();
		 for(let p = 0; p < planDgrid.getRowCount(); p++){
				planDgrid.setValue(p, "planQty", planDgrid.getValue(p, "orderQty"));
				calProdDay( p, "planQty", "dayOutput" )	;	
			}
	});

	planDgrid.on('response', function(ev) { 
		console.log("응답완료");
		let res = JSON.parse(ev.xhr.response);
		console.log(res);
		if (res.mod =='upd'){
			planDgrid.clear();
		}
	})
	
	//필요자재 재고체크 이벤트
	rStcGrid.on('response',function(ev){
     	rStcGrid.refreshLayout(); 
   	});
	 
	rStcGrid.on('onGridUpdated', function(ev) {
		setTimeout(function(){
			stcCheck()}, 1600)
	});
	
	rStcGrid.on("check", (rscEv) => {
		if(hdRstcGrid.getColumnValues('rscCd').includes(rStcGrid.getValue(rscEv.rowKey,'rscCd'))){
			var key = hdRstcGrid.findRows({'rscCd':rStcGrid.getValue(rscEv.rowKey,'rscCd')})[0].rowKey;
			hdRstcGrid.setValue(key,'prdtCd', hdRstcGrid.getValue(key, 'prdtCd')+", "+rStcGrid.getValue(rscEv.rowKey,'prdtCd'));
			hdRstcGrid.setValue(key,'lackStc', hdRstcGrid.getValue(key, 'lackStc')+rStcGrid.getValue(rscEv.rowKey,'lackStc'));
		}else{
			hdRstcGrid.appendRow({
				'prdtCd':rStcGrid.getValue(rscEv.rowKey,'prdtCd'),
				'prdtNm':rStcGrid.getValue(rscEv.rowKey,'prdtNm'),
			   'rscCd':rStcGrid.getValue(rscEv.rowKey,'rscCd'),
			   'rscNm': rStcGrid.getValue(rscEv.rowKey,'rscNm'),
			   'ndStc':rStcGrid.getValue(rscEv.rowKey,'ndStc'),
			   'lackStc':rStcGrid.getValue(rscEv.rowKey,'lackStc')},{
			   extendPrevRowSpan : true,
			   focus : true,
			   at : 0
  			});
	     } 
	 })

 	hdRstcGrid.on('onGridUpdated', function(ev) {
 		$("#hdRstcGrid").css("display", "block");	
	});
	//------------------------------버튼------------------------------------------------
	//생산계획서 조회버튼: 생산계획서 조회모달 호출
 	$('#btnFind').on('click', function(){
 		console.log("생산계획서 조회")
		prodPlanDialog.dialog("open");
		$("#prodPlanModal").load("${pageContext.request.contextPath}/modal/findProdPlan", 
									function() { planList() })
	});
 	
	//초기화 버튼: 계획폼, 계획상세 그리드 초기화
	$('#btnReset').click(function() {
		planMngFrm.reset();
		$('#planNo').val('');
		planDgrid.resetData([]);
		rStcGrid.resetData([]);
	})
	
	//저장 버튼: 계획 + 계획상세 그리드 저장(수정, 입력, 삭제)
	$('#btnSave').on("click", function(){
		planNm = $('#planNm').val();
		planDt = $('#planDt').val();
		
		if (planNm == null || planNm == ""){
			toastr.error("생산계획명을 입력해주세요.")
			$('#planNm').focus();
		} else if (planDgrid.getRowCount() == 0 ) {
			toastr.error("생산계획 상세내용이 없습니다.")
		} else if (hdRstcGrid.getRowCount() != 0 && odCnt == 0){
			console.log(odCnt)
			toastr.error("자재가 부족합니다. 발주요청 해주세요.")
		}	else {
				for ( i =0 ; i <= planDgrid.getRowCount(); i++) {
					planDgrid.setValue(i,'planNm',planNm);
					planDgrid.setValue(i,'planDt',planDt);
				}
				if(blankCheck()){
					if (confirm("계획을 저장하시겠습니까?")) { 
						//발주요청 그리드 데이터 담기
						let obj = {}
						obj.dmnd = hdRstcGrid.getData();
						fetch('${pageContext.request.contextPath}/ajax/planModified.do',{
				            method:'POST',
				            headers:{
				               "Content-Type": "application/json",
				            },
				        body:JSON.stringify(obj)
				         }) 
						//planDgrid.blur();
						planDgrid.request('modifyData'); // modifyData의 url 호출
						toastr.success("생산계획이 저장되었습니다.")
					}
				}
		}  
	});
	
	/* //삭제 버튼: 계획 + 계획상세그리드 삭제
	$('#btnDel').click(function(){
		planNo = $('#planNo').val();
		planDt = $('#planDt').val();
		planNm = $('#planNm').val();
		console.log(planNo);
		if (planNo == null || planNo == '') {
			alert("삭제할 데이터가 없습니다.")
		} else {
			var result = confirm("계획을 삭제하시겠습니까?");
			if (result) { 
				planDgrid.resetData([]);
				planMngFrm.reset();
				console.log("planNo:" + planNo)
				$.ajax({
					async: false,
					url: '${pageContext.request.contextPath}/deletePlan.do',
					type: 'POST',
					data: {
						planNo : planNo
					},
					datatype: 'json',
					success: function(){
						 alert("계획이 삭제되었습니다.");
						 //resetPage();
					}
				});
			}
		}
	}) */
	
	//그리도 추가 버튼
	rowAdd.addEventListener("click", function(){
		orderDialog.dialog("open");
		$("#orderModal").load("${pageContext.request.contextPath}/modal/findOrder", 
								function() { orderList() })
	});
	
	//그리드 삭제 버튼 
	rowDel.addEventListener("click", function(){
		planDgrid.removeCheckedRows(true); //false면 확인 안하고 삭제함
	});
	
	//발주요청 버튼
	$('#rscOrder').on("click", function(){
		odCnt = 0; 
		console.log(odCnt);
		if (hdRstcGrid.getRowCount() != 0) {
			sendMsgToParent('발주요청 확인요망', '/rsc/mng/ordradmin')
			odCnt = 1;
		}
		console.log(odCnt);
	});
	//------------------------------함수------------------------------------------------
	//생산일수 계산 함수
	function calProdDay( rowKey, a, b ) { // 생산일수계산
		a = Number(planDgrid.getValue( rowKey, a ));
		b = Number(planDgrid.getValue( rowKey, b ));
		result = (Number(a) / Number(b)).toFixed(1);
		planDgrid.setValue( rowKey, "prodDay" , result);
	} 
	
	//날짜 계산 함수
	function dayAdd(value, num){
		let wkdate = new Date(value);
		wkdate.setDate(wkdate.getDate()+num);
		
		let wYear = wkdate.getFullYear();
		let wMonth = wkdate.getMonth() +1;
		let wDate = wkdate.getDate() +1; // 납기일 전 날까지 작업완료
		wMonth = wMonth > 9 ? wMonth : "0" + wMonth;
	    wDate  = wDate > 9 ? wDate : "0" + wDate;
	    return wYear + "-" + wMonth + "-" + wDate;
	}
	
	//그리드 필수입력칸 체크 함수
	function blankCheck(){
		 for (let i=0; i<planDgrid.getRowCount(); i++){
			if(planDgrid.getRowAt(i).orderNo == null || planDgrid.getRowAt(i).orderNo == ""){
				toastr.error("주문번호가 지정되지 않았습니다.");
				return false;
			}  else if(planDgrid.getRowAt(i).prdtCd == null || planDgrid.getRowAt(i).prdtCd == ""){
				toastr.error("제품코드가 지정되지 않았습니다.");
				return false;
			} else if(planDgrid.getRowAt(i).planQty == null || planDgrid.getRowAt(i).planQty == ""){
				toastr.error("계획량이 지정되지 않았습니다.");
				return false;
			} else if(planDgrid.getRowAt(i).wkDt == null || planDgrid.getRowAt(i).wkDt == ""){
				toastr.error("작업시작일이 지정되지 않았습니다.");
				return false;
			} else { 
				console.log(i)
			}
		}
		return true;
	}
	
	//재고부족 자재 체크 함수
	function stcCheck(){
		for ( i=0; i< rStcGrid.getRowCount(); i++){
			let lackStc = rStcGrid.getValue(i, 'lackStc');
			  if(rStcGrid.getValue(i, 'lackStc') > 0){
				  rStcGrid.check(i)
			  }
		 }
	}
</script>

</html>