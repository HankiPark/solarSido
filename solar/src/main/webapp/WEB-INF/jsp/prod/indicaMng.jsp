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
	const indicaDdataSource = {
		  api: {
		    	readData: {
					url: '${pageContext.request.contextPath}/grid/indicaGrid.do', 
					method: 'GET'
		    				},
		    	modifyData: {
		    		url: '${pageContext.request.contextPath}/grid/indicaModify.do', 
					method: 'POST'
				}, 
			contentType: 'application/json',
			initialRequest: false //초기에 안보이게 함
		};
	
	const indicaDgrid = new tui.Grid({
		el: document.getElementById('indicaDgrid'),
		data: indicaDdataSource,
		scrollX: false,
		scrollY: true,
		bodyHeight: 500,
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
					    header: '지시량',
					    name: 'indicaQty',
					  },
					  {
					    header: '생산구분',
					    name: 'prodFg',
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
	
	//조회 버튼: 계획서 모달
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
	
 	//초기화 버튼: 계획폼, 계획상세 그리드 초기화
	$('#btnReset').click(function() {
		indicaMngFrm.reset();
		indicaDgrid.resetData([]);
	})
	
	</script>
</body>
</html>