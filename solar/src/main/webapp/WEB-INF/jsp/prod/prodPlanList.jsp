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
<div id="grid"></div>

<!-- 스크립트 -->
<script type="text/javascript">
	//계획일자 Default: sysdate
  document.getElementById('planStartDt').value = new Date().toISOString().substring(0, 10);
  document.getElementById('planEndDt').value = new Date().toISOString().substring(0, 10);
</script>
</body>
</html>