<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산계획조회</title>
</head>

<body>
<h2>생산계획조회</h2>
<hr/>

<!-- 검색모달 -->
<div id="coCdModal" title="업체 목록"></div>
<div id="prdtCdModal" title="제품 목록"></div>

<!-- 검색테이블 -->
<div>
	<form action="planListFrm" name="planListFrm">
		<input type="hidden" id="planNo" name="planNo" value="planNo">
		<table>
			<tr>
				<th>계획일자</th>
				<td colspan="3">
					<input type="date" id="planStartDt" name="planStartDt">
					~<input type="date" id="planEndDt" name="planEndDt">
				</td>
			</tr>
			<tr>
				<th>업체코드</th>
				<td>
					<input type="text" id="coCd" name="coCd" readonly>
					<button type="button" id="coCdFind">🔍</button>
				</td>
				<th>제품코드</th>
				<td>
					<input type="text" id="prdtCd" name="prdtCd" readonly>
					<button type="button" id="prdtCdFind">🔍</button>
				</td>
			</tr>
		</table>
		<div align="center">
			<button type="button" id="btnSearch">조회</button>
			<button type="button" id="btnReset">초기화</button>
			<button type="button" id="btnExcel">Excel</button>
		</div>
	</form>
</div>
<hr/>

<!-- 생산계획 상세 그리드-->
<div id="planDgrid"></div>

<!-- 스크립트 -->
<script type="text/javascript">
	let coCd;
	let prdtCd;
	
	//계획일자 Default: sysdate
	let pEndDt = new Date();
	let pSrtDt = new Date(pEndDt.getFullYear(), pEndDt.getMonth(), pEndDt.getDate() - 7);
	document.getElementById('planStartDt').value = pSrtDt.toISOString().substring(0, 10);
	document.getElementById('planEndDt').value = pEndDt.toISOString().substring(0, 10);
	 
	//업체검색 모달
	let coCdDialog = $("#coCdModal").dialog({
		autoOpen: false,
		modal: true,
		height: 600,
		width: 600
	});

	$("#coCdFind").on("click", function(){
		console.log("업체검색")
		coCdDialog.dialog("open");
		$("#coCdModal").load("${pageContext.request.contextPath}/modal/findCoCd", function(){ coCdList() })
	});

 	//제품검색 모달  
 	let prdtCdDialog = $("#prdtCdModal").dialog({
		autoOpen : false,
		modal : true,
		width : 600,
		height : 600
	});
  
 	$('#prdtCdFind').on('click', function(){
 		console.log("제품검색")
		prdtCdDialog.dialog("open");
		$("#prdtCdModal").load("${pageContext.request.contextPath}/modal/findPrdtCd")
	});
   
  //계획 조회 그리드
	const planDdataSource = {
		  api: {
		    	readData: { url: '${pageContext.request.contextPath}/grid/planGrid.do', 
					    	method: 'GET'
		    				},
				}, 
			contentType: 'application/json'
		};
	
	const planDgrid = new tui.Grid({
		el: document.getElementById('planDgrid'),
		data: planDdataSource,
		scrollX: false,
		scrollY: true,
		bodyHeight: 500,
		columns: [
					  {
					    header: '계획번호',
					    name: 'planNo',
					    sortingType: 'desc',
				        sortable: true
					  },
					  {
					    header: '계획일자',
					    name: 'planDt',
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
				    	sortingType: 'desc',
				        sortable: true
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
					    header: '계획량',
					    name: 'planQty',
					  },
					  {
					    header: '작업일자',
					    name: 'wkDt',
					    sortingType: 'desc',
				        sortable: true
					  },
					  {
					    header: '작업순서',
					    name: 'wkOrd',
					  },
			 		 ],
			 		summary: {
				        position: 'bottom',
				        height: 50,
				        columnContent: {
				        	planDt: {
				        		template: function(valueMap) {
				        			return '합계';
				        			},
				        		align:'center'
							},
							orderQty: {
								template: function(valueMap) {
									return valueMap.sum;
									}
							},
							planQty: {
								template: function(valueMap) {
									return valueMap.sum;
									}
							}
				        }
				    }
			});
	
	//조회 버튼: 조건별(기간, 업체, 제품) 생산계획 조회
	$('#btnSearch').click(function() {
		var planStartDt = document.getElementById('planStartDt').value
		var planEndDt = document.getElementById('planEndDt').value
		var coCd = document.getElementById('coCd').value
		var prdtCd = document.getElementById('prdtCd').value
		console.log(planStartDt + "~" + planEndDt + "& coCd:" + coCd + "& prdtCd:" + prdtCd);
		var params = {
				'planStartDt': planStartDt,
				'planEndDt': planEndDt,
				'coCd': coCd,
				'prdtCd': prdtCd
		}
		$.ajax({
			url : '${pageContext.request.contextPath}/grid/planGrid.do',
			data : params,
			dataType:"json",
			contentType : 'application/json; charset=utf-8',
		}).done(function(pln) {
			planDgrid.resetData(pln["data"]["contents"]);
		})
	})
	
	//초기화 버튼: 계획폼, 계획상세 그리드 초기화
	$('#btnReset').click(function() {
		planListFrm.reset();
		planDgrid.resetData([]);
	})
			
	planDgrid.on('onGridUpdated', function() {
		planDgrid.refreshLayout();
	});
	
	//Excel 버튼
	
</script>
</body>
</html>