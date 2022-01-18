<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>
	<h2>생산계획 관리</h2>
	<hr />
	
	<!-- 모달 -->
	<div id="prodindicaModal" title="생산계획서 목록"></div>
	
	<!-- 생산계획 테이블 -->
	<div>
		<form action="indicaMngFrm" name="indicaMngFrm">
			<input type="hidden" id="indicaNo" name="indicaNo" value="indicaNo">
			<table>
				<tr>
					<th>지시기간</th>
					<td colspan="3">
						<input type="date" id="indicaStartDt" name="indicaStartDt"> 
						~<input type="date" id="indicaEndDt" name="indicaEndDt">
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
	//계획일자 Default: sysdate
	let pEndDt = new Date();
	let pSrtDt = new Date(pEndDt.getFullYear(), pEndDt.getMonth(), pEndDt.getDate() - 7);
	document.getElementById('indicaStartDt').value = pSrtDt.toISOString().substring(0, 10);
	document.getElementById('indicaEndDt').value = pEndDt.toISOString().substring(0, 10);
	
	let pDt = new Date();
	document.getElementById('indicaDt').value = pDt.toISOString().substring(0, 10);
	
	</script>
</body>
</html>