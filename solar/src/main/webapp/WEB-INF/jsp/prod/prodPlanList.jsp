<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산계획조회</title>
<link rel="stylesheet"	href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<link rel="stylesheet"	href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<script	src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
</head>
<body>
<h2>생산계획조회</h2>
<hr/>

<!-- 검색모달 -->
<div id="coModal" title="업체 목록"></div>
<div id="prdtModal" title="제품 목록"></div>

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
				<th>업체명</th>
				<td>
					<input type="text" id="coNm" name="coNm" readonly>
					<button type="button" id="coNmSearch">찾기</button>
					
				</td>
				<th>제품코드</th>
				<td>
					<input type="text" id="prdtCd" name="prdtCd" readonly>
					<button type="button" id="prdtSearch">찾기</button>
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

<!-- 조회그리드 -->
<div id="planListGrid"></div>

<!-- 스크립트 -->
<script type="text/javascript">
	//계획일자 Default: sysdate
	let pEndDt = new Date();
	let pSrtDt = new Date(pEndDt.getFullYear(), pEndDt.getMonth(), pEndDt.getDate() - 7);
	document.getElementById('planStartDt').value = pSrtDt.toISOString().substring(0, 10);
	document.getElementById('planEndDt').value = pEndDt.toISOString().substring(0, 10);
  
  //업체검색 모달
  let coDialog = $("#coModal").dialog({
  	autoOpen: false,
  	modal: true
  	height: 600,
	width: 600
  });

  $("#coNmSearch").on("click", function(){
  	console.log("업체검색")
   	coDialog.dialog("open");
   	$("#coModal").load("${pageContext.request.contextPath}/modal/searchCo");
  });
  
  //제품검색 모달
  let dialog = $("#prdtModal").dialog({
		autoOpen : false,
		modal : true,
		width : 700,
		height : 700
	});
  
 	$('#prdtSearch').on('click', function(){
 		console.log("제품검색")
		prdtdialog.dialog("open");
		$("#prdtModal").load("${pageContext.request.contextPath}/modal/prdtNmList",
					function() { NmList() })
	});
  
  //조회버튼
  
  //계획 조회 그리드
  	var planListGrid = tui.Grid;	  

	const plDataSource = {
		  api: {
		    	readData: { url: '${pageContext.request.contextPath}/grid/planList.do', 
					    	method: 'GET'
		    				},
				}, 
			contentType: 'application/json'
		};
	
	const planListGrid = new Grid({
		  el: document.getElementById('planListGrid'),
		  data: plDataSource,
		  columns: [
					  {
					    header: '계획번호',
					    name: 'planNo'
					  },
					  {
					    header: '계획일자',
					    name: 'planDt'
					  },
					  {
					    header: '업체명',
					    name: 'coNm'
					  },
					  {
					    header: '제품코드',
					    name: 'prdtCd'                                                                                                           
					  },		  
					  {
					    header: '제품명',
					    name: 'prdtNm'
					  },
					  {
					    header: '주문번호',
					    name: 'orderNo'
					  },
					  {
					    header: '납기일자',
					    name: 'paprdDt',
					  },
					  {
					    header: '주문량',
					    name: 'orderQty'
					  },
					  {
					    header: '계획량',
					    name: 'planQty',
					  },
					  {
					    header: '작업일자',
					    name: 'wkDt',
					  },
					  {
					    header: '작업순서',
					    name: 'wkOrd',
					  },
			 		 ]
			});
			
	planListGrid.on('onGridUpdated', function() {
		planListGrid.refreshLayout();
	});
	
</script>
</body>
</html>