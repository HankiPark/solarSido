<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산지시조회</title>
</head>

<body>
<h2>생산지시조회</h2>
<hr/>

<!-- 검색모달 -->
<div id="coCdModal" title="업체 목록"></div>
<div id="prdtCdModal" title="제품 목록"></div>

<!-- 검색테이블 -->
<div>
	<form action="idcListFrm" name="idcListFrm">
		<input type="hidden" id="planNo" name="planNo" value="planNo">
		<table>
			<tr>
				<th>지시일자</th>
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

<!-- 생산지시 상세 그리드-->
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
   

</script>
</body>
</html>