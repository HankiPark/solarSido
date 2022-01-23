<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>
	<h2>생산지시 관리</h2>
	<hr />
	
	<!-- 모달 -->
	<div id="indicaModal" title="생산지시서 목록"></div>
	
	<!-- 생산지시 테이블 -->
	<div>
		<form action="indicaMngFrm" name="indicaMngFrm">
			<input type="hidden" id="indicaNo" name="indicaNo" value="indicaNo">
			<table>
				<tr>
					<th>지시기간</th>
					<td colspan="3">
						<input type="date" id="planStartDt" name="planStartDt"> 
						~<input type="date" id="planEndDt" name="planEndDt">
						<button type="button" id="btnSearch">🔍</button>
					</td>
				</tr>
				<tr>
					<th>지시일자<span style="color: red">*</span></th>
					<td><input type="date" id="indicaDt" name="indicaDt" required></td>
					<th>생산지시명<span style="color: red">*</span></th>
					<td><input type="text" id="indicaNm" name="indicaNm" required></td>
				</tr>
			</table>
			<div align="center">
				<button type="button" id="btnReset">초기화</button>
				<button type="button" id="btnSave">저장</button>
				<button type="button" id="btnDel">삭제</button>
			</div>
		</form>
	</div>
	<hr />

	<!-- 생산지시 상세 그리드-->
	<div id="indicaDgrid">
		<div align="right">
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
		<div id="rscLotGrid" class="col-7"  >
			<label>자재코드</label>
			<input type="text" id="rscCd" name="rscCd" readonly> 
			<label>자재명</label>
			<input type="text" id="rscNm" name="rscNm" readonly> 
		</div>
	</div>
	
</body>
<!-- 스크립트 -->
<script type="text/javascript">
	//지시일자 Default: sysdate
	let pEndDt = new Date();
	let pSrtDt = new Date(pEndDt.getFullYear(), pEndDt.getMonth(), pEndDt.getDate() - 7);
	document.getElementById('planStartDt').value = pSrtDt.toISOString().substring(0, 10);
	document.getElementById('planEndDt').value = pEndDt.toISOString().substring(0, 10);
	 
	let iDt = new Date();
	document.getElementById('indicaDt').value = iDt.toISOString().substring(0, 10);
	
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
		bodyHeight: 250,
		rowHeaders: [{
			type: 'checkbox',
			width: 70}],
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
				    			console.log("e.rowkey:"+e.rowKey+" & e.value:"+e.value)
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
	})
	
	//그리드 추가 버튼
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
	
	//조회 버튼: 지시서 모달
	let indicaDialog = $("#indicaModal").dialog({
		autoOpen : false,
		modal : true,
		width : 900,
		height : 600
	});
	
 	$('#btnSearch').on('click', function(){
 		console.log("작업지시서 검색")
		indicaDialog.dialog("open");
		$("#indicaModal").load("${pageContext.request.contextPath}/modal/findIndica", 
									function() { indicaList() })
	});
	
 	//초기화 버튼: 지시폼, 지시상세 그리드 초기화
	$('#btnReset').click(function() {
		indicaMngFrm.reset();
		indicaDgrid.resetData([]);
	})
	
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
		rowHeaders : [ 'rowNum','checkbox' ],
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
					    name: 'rscQty'
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
</script>
</html>