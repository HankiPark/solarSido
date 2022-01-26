<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산지시 관리</title>
</head>

<body>
	<h2>생산지시 관리</h2>
	<hr />
	
	<!-- 모달 -->
	<div id="planModal" title="미지시계획 조회">
		<div id="planDgrid"></div>
	</div>
	<div id="indicaModal" title="생산지시서 목록"></div>
	<div id="indicaDetailModal" title="생산지시서 조회"></div>
	
	<!-- 생산지시 테이블 -->
	<div  class="row">
		<div class="col-9">
			<form action="indicaMngFrm" name="indicaMngFrm">
				<div>
					<label>지시일자<span style="color: red">*</span></label>
					<input type="date" id="indicaDt" name="indicaDt" required>
					<label>생산지시명<span style="color: red">*</span></label>
					<input type="text" id="indicaNm" name="indicaNm" required>
				</div>
				<div>
					<button type="button" id="btnReset">초기화</button>
					<button type="button" id="btnSave">저장</button>
					<!-- <button type="button" id="btnDel">삭제</button> -->
				</div>
			</form>
		</div>
		<div class="col-3">
			<label>생산지시서 조회</label>
			<button type="button" id="btnFind">🔍</button>
		</div>
	</div>
	<hr />

	<!-- 생산지시 상세 그리드--> 
	<div id="indicaDgrid" class="row">
		<div class="col-8">
			<label>지시번호</label>
			<input type="hidden" id="indicaNo" name="indicaNo" value="indicaNo">
		</div>
		<div id="btnMng" class="col-4">
			<button type="button" id="planSearch">계획🔍</button>
			<button type="button" id="indicaSearch">지시🔍</button>
			<button type="button" id="rowAdd">추가</button>
			<button type="button" id="rowDel">삭제</button>
		</div>
	</div>
	<hr />

	<div class="row">
		<!-- 소요자재 그리드 -->
		<div id="rscGrid" class="col-4" >
			<label>제품코드</label>
			<input type="text" id="prdtCd" name="prdtCd" readonly> 
			<label>제품명</label>
			<input type="text" id="prdtNm" name="prdtNm" readonly> 
		</div>
		<div id="rscLotGrid" class="col-7">
			<label>자재코드</label>
			<input type="text" id="rscCd" name="rscCd" readonly> 
			<label>자재명</label>
			<input type="text" id="rscNm" name="rscNm" readonly> 
		</div>
	</div>
	
	<!-- 소요자재 히든그리드 -->
	<div id="hiddenRscGrid"></div>
</body>

<!-- 스크립트 -->
<script type="text/javascript">
	let iDt = new Date();
	document.getElementById('indicaDt').value = iDt.toISOString().substring(0, 10);
	let list = [];
	//지시 조회 그리드
	let indicaDgrid = new tui.Grid({
		el: document.getElementById('indicaDgrid'),
		data: {
			  api: {
			    	readData: {
						url: '${pageContext.request.contextPath}/grid/indicaGrid.do', 
						method: 'GET'
			    				},
			    	modifyData: {
			    		url: '${pageContext.request.contextPath}/grid/indicaModify.do', 
						method: 'POST'
								}
			  },
				contentType: 'application/json',
				initialRequest: false //초기에 안보이게 함
			},
		scrollX: false,
		scrollY: true,
		bodyHeight: 200,
		rowHeaders: [{
			type: 'checkbox',
			width: 40}],
		columns: [
					 {
					    header: '지시상세번호',
					    name: 'indicaDetaNo',
				        hidden: true
					  },
					  {
					    header: '지시번호',
					    name: 'indicaNo',
					    sortingType: 'desc',
				        sortable: true
					  },
					  {
					    header: '업체코드',
					    name: 'coCd',
				    	sortingType: 'desc',
				        sortable: true
					  },
					  {
					    header: '제품코드',
					    name: 'prdtCd',    
					    editor: 'text',
				    	sortingType: 'desc',
				        sortable: true,
				        validation: {
			    	        required: true
			    	      }
					  },		  
					  {
					    header: '제품명',
					    name: 'prdtNm'
					  },
					  {
					    header: '주문번호',
					    name: 'orderNo',
				    	sortingType: 'desc',
				        sortable: true
					  },
					  {
					    header: '납기일자',
					    name: 'paprdDt',
					    sortingType: 'desc',
				        sortable: true
					  },
					  {
					    header: '주문량',
					    name: 'orderQty',
					    sortingType: 'desc',
				        sortable: true
					  },
					  {
					    header: '지시량',
					    name: 'indicaQty',
					    editor : 'text',
					    validation: {
			    	        required: true
			    	      },
			    	      onAfterChange(e) {
				    			console.log("e.rowkey:"+e.rowKey+" & e.value:"+e.value);
				    	    	indicaDgrid.setValue(e.rowKey, 'prodDay',
				    	    					e.value / indicaDgrid.getValue(e.rowKey, 'dayOutput'));
				    	    }    	
					  },
					  {
					    header: '일생산량',
					    name: 'dayOutput',
					  },
					  {
					    header: '생산일수',
					    name: 'prodDay',
					  },
					  {
					    header: '생산구분',
					    name: 'prodFg',
					    formatter: 'listItemText',
				    	editor: {
				    		type:'select',
				    		options: {
				    			listItems: [
				    				{text:'정상', value:'정상'},
				    				{text:'재작업', value:'재작업'}
				    				]
					    		}
					  		}
					  },
					  {
					    header: '작업일자',
					    name: 'wkDt',
					    editor :'datePicker',
					    sortingType: 'desc',
				        sortable: true,
				        validation: {
			    	        required: true
			    	      }
					  },
					  {
					    header: '작업순서',
					    name: 'wkOrd',
					    editor: 'text'
					  },
					  {
					    header: '제품LOT_NO 생성',
					    name: 'prdt_lot'
					  }
			 		 ]
			});
	
	indicaDgrid.on('onGridUpdated', function() {
		indicaDgrid.refreshLayout();
	});
	
	indicaDgrid.on('click', (ev) => {
		console.log(ev);
	});
	
	//지시상세 그리드 내부 클릭 이벤트
	indicaDgrid.on('click', function(ev){
		let prdtCd = indicaDgrid.getValue(ev["rowKey"], "prdtCd")
		let prdtNm = indicaDgrid.getValue(ev["rowKey"], "prdtNm")
		
		console.log(prdtCd);
		$('#prdtCd').val(prdtCd);
		$('#prdtNm').val(prdtNm);
		
		var rscGridParams = {
				'prdtCd' : prdtCd,
				'prdtNm' : prdtNm
		};
		
		rscGrid.readData(1, rscGridParams, true);
	});
	
	//생산지시서 조회 버튼: 기간별 생산계획 조회
	let indicaDetailDialog = $("#indicaDetailModal").dialog({
		autoOpen : false,
		modal : true,
		width : 900,
		height : 600,
		buttons : {
			'확인': function(){
				indicaDetailDialog.dialog("close");
			}
		}
	});
  
 	$('#btnFind').on('click', function(){
 		console.log("생산지시서 조회")
		indicaDetailDialog.dialog("open");
		$("#indicaDetailModal").load("${pageContext.request.contextPath}/modal/findIndicaDetail", 
									function() { indicaDetailList() })
	});
 	
 	//계획조회 버튼: 미지시 계획상세 모달
	let planDetailDialog = $("#planModal").dialog({
		autoOpen : false,
		modal : true,
		width : 900,
		height : 400,
		buttons : {
			"확인" : function(){
				console.log('확인');
				console.log(chkPlan);
				indicaDgrid.appendRows(chkPlan);
				planDetailDialog.dialog("close");
			},
			'취소': function(){
				planDetailDialog.dialog("close");
			}
		}
	});
	
 	$('#planSearch').on('click', function(){
 		console.log("미지시 계획 검색")
		planDetailDialog.dialog("open");
		$("#planModal").load("${pageContext.request.contextPath}/modal/findPlanDlist", 
									function() { planDList() })
	});
 	
	//지시조회 버튼: 미공정 지시서 모달
	let indicaDialog = $("#indicaModal").dialog({
		autoOpen : false,
		modal : true,
		width : 900,
		height : 400,
		buttons : {
			'취소': function(){
				planDetailDialog.dialog("close");
			}
		}
	});
	
 	$('#indicaSearch').on('click', function(){
 		console.log("작업지시서 검색")
		indicaDialog.dialog("open");
		$("#indicaModal").load("${pageContext.request.contextPath}/modal/findIndica", 
									function() { indicaList() })
	});
 	
	//그리드 추가 버튼: 계획 없는 지시 등록
	rowAdd.addEventListener("click", function(){
		indicaDgrid.appendRow({
			extendPrevRowSpan : true,
			focus : true,
			at : 0
		});
	});
	
	//그리드 삭제 버튼
	//false면 확인 안하고 삭제함
	rowDel.addEventListener("click", function(){
		indicaDgrid.removeCheckedRows(true);
	});
	
 	//초기화 버튼: 지시폼, 지시상세 그리드 초기화
	$('#btnReset').click(function() {
		indicaMngFrm.reset();
		indicaDgrid.resetData([]);
		rscGrid.resetData([]);
		rscLotGrid.resetData([]);
	})
	
	//제품별 소요 자재 목록 그리드
	let rscGrid = new tui.Grid({
		el: document.getElementById('rscGrid'),
		data: {
			  api: {
			    	readData: {
						url: '${pageContext.request.contextPath}/grid/rscGrid.do', 
						method: 'GET',
						initParams : { prdtCd: 'prdtCd'}
			    				}
			  },
				contentType: 'application/json',
				initialRequest: false //초기에 안보이게 함
			},
		scrollX: false,
		scrollY: true,
		rowHeaders : [ 'rowNum' ],
		selectionUnit : 'row',
		bodyHeight: 250,
		columns: [
					 {
					    header: '제품코드',
					    name: 'prdtCd',
					    hidden: true
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
					    header: '소요량',
					    name: 'rscUseQty'
					  }
				]
	});
 	
	rscGrid.on('onGridUpdated', function() {
		rscGrid.refreshLayout(); 
		indicaDgrid.refreshLayout();
	});
	
	//자재목록 그리드 내부 클릭 이벤트
	rscGrid.on('click', function(ev){
		let rscCd = rscGrid.getValue(ev["rowKey"], "rscCd")
		let rscNm = rscGrid.getValue(ev["rowKey"], "rscNm")
		
		console.log(rscCd);
		$('#rscCd').val(rscCd);
		$('#rscNm').val(rscNm);
		
		var lotGridParams = {
				'rscCd' : rscCd,
				'rscNm' : rscNm
		};
		
		rscLotGrid.readData(1, lotGridParams, true);
	});
	
	//소요 자재 Lot 그리드
	let rscLotGrid = new tui.Grid({
		el: document.getElementById('rscLotGrid'),
		data:  {
			  api: {
			    	readData: {
						url: '${pageContext.request.contextPath}/grid/rscLotGrid.do', 
						method: 'GET',
						initParams : { rscCd: 'rscCd'}
			    				}
			  },
				contentType: 'application/json',
				initialRequest: false //초기에 안보이게 함
			},
		scrollX: false,
		scrollY: true,
		rowHeaders : [ 'checkbox', 'rowNum' ],
		bodyHeight: 200,
		columns: [
					 {
					    header: '자재코드',
					    name: 'rscCd',
					    hidden: true
					  },
					  {
					    header: '자재LOT_NO',
					    name: 'rscLot'
					  },
					  {
					    header: '재고량',
					    name: 'rscStc'
					  },
					  {
					    header: '투입량',
					    name: 'rscQty',
					    editor: 'text'
					  }
				],
		summary: {
	        position: 'bottom',
	        height: 50,
	        columnContent: {
	        	rscLot: {
	        		template: function(valueMap) {
	        			return '합계';
	        			},
	        		align:'center'
				},
				rscQty: {
					template: function(valueMap) {
						return valueMap.sum;
						}
				},
				rscQty: {
					template: function(valueMap) {
						return valueMap.sum;
						}
				}
	        }
	    }
	});
	
	//소요 자재 Lot 그리드 -> 소요 자재 목록 히든그리드
	rscLotGrid.on("checked", (rscEv) => {
		rscLotGrid.setSelectionRange({
		    start: [rscEv.rowKey, 0],
		    end: [rscEv.rowKey, rscLotGrid.getColumns().length-1]
		});
		
	
	})
	
	//소요 자재 목록 히든그리드
	let hiddenRscGrid = new tui.Grid({
		el: document.getElementById('hiddenRscGrid'),
		data: {
			  api: {
			    	readData: {
						url: '${pageContext.request.contextPath}/grid/rscGrid.do', 
						method: 'GET',
						initParams : { prdtCd: 'prdtCd'}
			    				}
			  },
				contentType: 'application/json',
				initialRequest: false //초기에 안보이게 함
			},
		scrollX: false,
		scrollY: true,
		rowHeaders : [ 'rowNum' ],
		bodyHeight: 250,
		columns: [
					 {
					    header: '생산지시상세번호',
					    name: 'indicaDetaNo',
					   // hidden: true
					  },
					  {
					 	header: '제품코드',
					    name: 'prdtCd',
					    //hidden: true
					  },
					  {
					    header: '자재코드',
					    name: 'rscCd'
					  },
					  {
					    header: '자재LOT_NO',
					    name: 'rscLot'
					  },
					  {
					    header: '소요량',
					    name: 'rscUseQty'
					  }
				]
	});
 	
	rscGrid.on('onGridUpdated', function() {
		rscGrid.refreshLayout(); 
		indicaDgrid.refreshLayout();
	});
	
	
 	
	//제품코드 입력시 제품명 입력 함수
	 
</script>
</html>