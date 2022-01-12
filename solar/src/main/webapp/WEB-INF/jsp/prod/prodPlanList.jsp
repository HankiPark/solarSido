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
	<div>
		<form id ="inputfrm" name="inputfrm">
			<input type="hidden" id="planNo" name="planNo" value="planNo">
				<table>
					<tr>
						<th>계획일자<span style="color: red">*</span></th>
						<td><input type="date" id="planDt" name="planDt" required></td>
					</tr>
					<tr>
						<th>생산계획명<span style="color: red">*</span></th>
						<td><input type="text" id="planNm" name="planNm" required></td>
					</tr>
									
				</table>
		</form>
	</div>
	<div>
		<button type="button" id="searchBtn">조회</button>
		<button type="reset"  id="resetBtn">초기화</button>
		<button type="button" id="searchBtn">저장</button>
		<button type="button" id="searchBtn">삭제</button>
	</div>
	<br />
	<hr>
</body>
</html>