<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산계획관리</title>
<link rel="stylesheet"
	href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<link rel="stylesheet"
	href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<script
	src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
</head>

<body>
	<h3>생산계획 관리</h3>
	<hr />
	<!-- 생산계획 테이블 -->
	<div>
		<form action="planMngFrm" name="planMngFrm">
			<input type="hidden" id="planNo" name="planNo" value="planNo">
			<table>
				<tr>
					<th>계획기간</th>
					<td colspan="3">
						<input type="date" id="planStartDt" name="planStartDt"> 
						~<input type="date" id="planEndDt" name="planEndDt">
						<button type="button" id="btnSearch">조회</button>
					</td>
				</tr>
				<tr>
					<th>계획일자<span style="color: red">*</span></th>
					<td><input type="date" id="planDt" name="planDt" required></td>
					<th>생산계획명<span style="color: red">*</span></th>
					<td><input type="text" id="planNm" name="planNm" required></td>
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

	<!-- 생산계획 상세 그리드-->
	<div id="planDgrid">
		<div align="right">
			<button type="button" id="rowAdd">추가</button>
			<button type="button" id="rowDel">삭제</button>
		</div>
	</div>

	<!-- 제품코드 클릭: 주문서에 있는 제품 조회 모달 -->
	<div id="orderPlan" title="생산할 제품 검색"></div>

	<!-- 스크립트 -->
	<script>
	//날짜 Default: sysdate
	document.getElementById('planDt').value = new Date().toISOString().substring(0, 10);
	 	
	//조회 버튼: 기간별 생산계획 조회
	$('#btnSearch').click(function() {
		planStartDt = document.getElementById('planStartDt').value
		planEndDt = document.getElementById('planEndDt').value
		console.log(planStartDt + "~" +planEndDt);
	})  
	
	//초기화 버튼: 계획폼, 계획상세 그리드 초기화
	$('#btnReset').click(function() {
		planMngFrm.reset();
		planDgrid.resetData([]);
	})  
	
	//저장 버튼: 계획 + 계획상세그리드 저장
	btnSave.addEventListener("click", function(){
		planDgrid.request('modifyData'); //planDdataSource - modifyData의 url 호출
	})
	
	//삭제 버튼
	
	//그리드 저장 버튼
	rowAdd.addEventListener("click", function(){
		planDgrid.request('modifyData');
	})
	
	//그리드 삭제 버튼
	//false면 확인 안하고 삭제함
	rowDel.addEventListener("click", function(){
		planDgrid.removeCheckedRows(true); 
	})
	
	//생산계획 ajax요청
	/* $.ajax({
		url: '${pageContext.request.contextPath}/resources/json/city.json',
		data : {}
		dataType: 'json',
		async : false
	}).don(function(datas){
		data = datas;
	}); */
	
	//생산계획 상세 그리드
	let data;
	
	const planDdataSource = {
		api: {
			readData: { 
				url: '${pageContext.request.contextPath}/grid/planDList.do', 
				method: 'GET'
				},
			modifyData: { 
				url: '${pageContext.request.contextPath}/modifyData', 
				method: 'PUT'}
				}, 
			},
		contentType: 'application/json'
		initialRequest: false //초기에 안보이게 함
	}
	
	const planDgrid = new tui.Grid({
		el: document.getElementById('planDgrid'),
		scrollX: false,
		scrollY: false,
		data: planDdataSource, 
		rowHeaders: ['checkbox'],
		//selectUnit : 'row',
		columns: [{
			header: '제품코드',
			name: 'productCode',
			editor: 'text',
			align: 'center',
			validation: {
				required: true
			},
			onAfterChange(ev) {
				findProductName(ev);
				valueInput(ev);
			}
		}, {
			header: '제품명',
			name: 'productName',
			align: 'center',
			onAfterChange(ev) {
				valueInput(ev);
			}
		}, {
			header: '주문번호',
			name: 'orderNo',
			align: 'center',
		}, {
			header: '납기일자',
			name: 'outDate',
			align: 'center',
		}, {
			header: '주문량',
			name: 'orderCount',
			align: 'right',
		}, {
			header: '기계획량',
			name: 'planCount',
			align: 'right',
		}, {
			header: '미계획량',
			name: 'unplanCount',
			align: 'right',
		}, {
			header: '작업량',
			name: 'workCount',
			align: 'right',
			editor: 'text',
			validation: {
				dataType: 'number',
				required: true
			},
			onAfterChange(ev) {
				valueInput(ev);
			}
		}, {
			header: '작업일자',
			name: 'workDate',
			align: 'center',
			editor: {
				type: 'datePicker',
				options: {
					language: 'ko',
					format: 'yyyy-MM-dd'
				}
			},
			validation: {
				required: true
			}
		}, {
			header: '순번',
			name: 'deplanIdx',
			hidden: true
		}, {
			header: '비고',
			name: 'comments',
			align: 'center',
			editor: 'text'
		}, {
			header: '생산계획번호',
			name: 'planCode',
			hidden: true
		}
		]
});
	
	let checkRow;
	
	planDgrid.on('check', function(ev){
		checkRow = grid.getData()[0];
		console.log(grid.getValue(ev.rowkey, ''));
		
	})
	
	//제품코드 클릭: 주문서 조회 모달
	let orderDialog = $( "#orderPlan" ).dialog({
		autoOpen: false,
		modal: true,
		height: 600,
		width: 600,
		buttons: {
			"확인" : function(){
				pladDgrid.resetData(checkRow); //체크한 값 그리드에 불러오기
				},
			"취소" : function(){
				dialog.dialog( "close" );
			}
		}
	});
	
	//제품코드셀 클릭이벤트
	$("선택한셀").on("click", function(){
		console.log("제품코드 클릭")
		orderDialog.dialog( "open" );
		$("#orderPlan").load("모달페이지.jsp", 
				function(){console.log("로드됨")})
	});
	
</script>
</body>

</html>