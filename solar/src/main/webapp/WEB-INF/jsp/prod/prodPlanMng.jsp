<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산계획관리</title>

</head>

<body>
	<h2>생산계획 관리</h2>
	<hr />
	
	<!-- 모달 -->
	<div id="prodPlanModal" title="생산계획서 목록"></div>
	<div id="orderListModal" title="제품 목록"></div>
	<div id="orderModal" title="생산할 제품 검색"></div>
	
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

	<!-- 스크립트 -->
	<script type="text/javascript">
	//계획일자 Default: sysdate
	let pEndDt = new Date();
	let pSrtDt = new Date(pEndDt.getFullYear(), pEndDt.getMonth(), pEndDt.getDate() - 7);
	document.getElementById('planStartDt').value = pSrtDt.toISOString().substring(0, 10);
	document.getElementById('planEndDt').value = pEndDt.toISOString().substring(0, 10);
	
	let pDt = new Date();
	document.getElementById('planDt').value = pDt.toISOString().substring(0, 10);

	//생산계획 상세 그리드
	let planDdataSource = {
		api: {
			readData: { 
				url: '${pageContext.request.contextPath}/grid/planGrid.do', 
				method: 'GET'
				},
			modifyData: { 
				url: '${pageContext.request.contextPath}/grid/planModify.do', 
				method: 'POST'}
				},
		contentType: 'application/json',
		initialRequest: false //초기에 안보이게 함
	}
	
	let planDgrid = new tui.Grid({
		el: document.getElementById('planDgrid'),
		data: planDdataSource, 
		scrollX: false,
		scrollY: true,
		width: 1250,
		bodyHeight: 500,
		rowHeaders: ['checkbox'],
		columns: [
			 {
			    header: '계획상세번호',
			    name: 'planDetaNo',
			    hidden: true
			  },
			  {
			    header: '계획일자',
			    name: 'planNo',
			    hidden: true
			  },
			  {
			    header: '계획명',
			    name: 'planNm',
			    hidden: true
			  },
			  {
			    header: '계획번호',
			    name: 'planNo',
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
			  { //주문없는 계획 불가
			    header: '주문번호',
			    name: 'orderNo',
			    validation: {
	    	        required: true
	    	      }
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
			    name: 'orderQty'
			  },
			 {
			    header: '작업량',
			    name: 'planQty',
			    editor : 'text',
			    onAfterChange(e) {
	    			console.log(e.rowKey)
	    	    	planDgrid.setValue(e.rowKey, 'prodDay',
	    	    					e.value / planDgrid.getValue(e.rowKey, 'dayOutput'));
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
			    header: '작업일자',
			    name: 'wkDt',
			    editor :'datePicker',
				filter: {
		            type: 'date',
		            format: 'YYYY-MM-DD'
		          }
			  },
			  {
			    header: '작업순서',
			    name: 'wkOrd',
			    editor : 'text'
			  }
	 		 ]
	});	
	
	planDgrid.on('onGridUpdated', function() {
		planDgrid.refreshLayout();
	});

	planDgrid.on('click', (ev) => {
		console.log(ev);
	})

	// 성공 실패와 관계 없이 응답을 받았을 경우
	planDgrid.on('response', function(ev) { 
		console.log(ev);
		let res = JSON.parse(ev.xhr.response);
		if (res.mod =='upd'){
			planDgrid.clear();
		}
	})
	
	//그리드 추가 버튼
	rowAdd.addEventListener("click", function(){
		planDgrid.appendRow({
			extendPrevRowSpan : true,
			focus : true,
			at : 0
		});
	});
	
	//그리드 삭제 버튼
	//false면 확인 안하고 삭제함
	rowDel.addEventListener("click", function(){
		planDgrid.removeCheckedRows(true);
	});
	
	//조회 버튼: 계획서 모달
	let prodPlanDialog = $("#prodPlanModal").dialog({
		autoOpen : false,
		modal : true,
		width : 900,
		height : 600
	});
  
 	$('#btnSearch').on('click', function(){
 		console.log("생산계획서 검색")
		prodPlanDialog.dialog("open");
		$("#prodPlanModal").load("${pageContext.request.contextPath}/modal/findProdPlan", function() { planList() })
	});
			
	//초기화 버튼: 계획폼, 계획상세 그리드 초기화
	$('#btnReset').click(function() {
		planMngFrm.reset();
		planDgrid.resetData([]);
	})
	
	//저장 버튼: 계획 + 계획상세 그리드 저장(수정, 입력, 삭제)
	$('#btnSave').on("click", function(){
		/* planDgrid.blur(); */
		planDgrid.request('modifyData'); //planDdataSource - modifyData의 url 호출
	})
	
	//삭제 버튼: 계획 + 계획상세그리드 삭제
	$('#btnDel').click(function(){
		if (planNm != null) {
			var result = confirm("삭제하시겠습니까?");
			if (result) { 
				planDgrid.resetData([]);
				planMngFrm.reset();
				console.log("result:" + planNm)
				$.ajax({
					async: false,
					url: '${pageContext.request.contextPath}/deletePlan.do',
					type: 'get',
					data: {
						planNm : planNm
					},
					datatype: 'json',
					success: function(){
						planNm = null;
					}
				})
			    alert("삭제되었습니다.")
			}
		} else {
			alert("삭제할 데이터가 없습니다.")
		}
	})
	
	//주문번호 클릭: 주문서 조회 모달
	let orderDialog = $("#orderModal").dialog({
			autoOpen : false,
			modal : true,
			width : 900,
			height : 600
		});
	
	planDgrid.on('click', function(ev) {
		console.log(planDgrid.getValue(ev["rowKey"], "orderNo"));
		if ( ev["columnName"] == "orderNo" ) {
			orderDialog.dialog("open");
			$("#orderModal").load("${pageContext.request.contextPath}/modal/findOrder", 
					function() { orderList() })
		} 
	}); 

</script>
</body>

</html>