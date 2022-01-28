<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원관리 리스트</title>
</head>
<body>
	<label>사원번호</label>
	<input type="text" id="empNoFind">
	<label>사원명</label>
	<input type="text" id="empNmFind">

	<button type="button" id="btnfind">조회</button>


	<div id="empGrid"></div>
</body>


<script type="text/javascript">
	empGrid = new tui.Grid(
			{
				el : document.getElementById('empGrid'),
				data : {
					api : {
						readData : {
							url : '${pageContext.request.contextPath}/grid/empList.do',
							method : 'GET'
						}
					},
					contentType : 'application/json'
				},
				scrollX : true,
				scrollY : true,
				bodyHeight : 700,
				columns : 
				[ 
					{
						header : '아이디',
						name : 'empId'
					}, 
					{
						header : '비밀번호',
						name : 'empPw',
						hidden : true
					}, 
					{
						header : '사원명',
						name : 'empNm',
					}, 
					{
						header : '사원번호',
						name : 'empNo'
					}, 
					{
						header : '부서',
						name : 'dept'
					}, 
					{
						header : '직책',
						name : 'wkdty'
					},
					{
						header : '전화',
						name : 'phone',
						hidden : true
					},
					{
						header : '이메일',
						name : 'email',
						hidden : true
					},
					{
						header : '입사일',
						name : 'hireDate',
						hidden : true
					},
				]
			});

	//검색버튼
	$('#btnfind').on('click', function() {
		var empNo = $("#empNoFind").val();
		var empNm = $("#empNmFind").val();
		var Params = {
			'empNo' : empNo,
			'empNm' : empNm
		}
		$.ajax({
			url : '${pageContext.request.contextPath}/grid/empdataFind',
			data : Params,
			contentType : 'application/json; charset=utf-8'
		}).done(function(res) {
			var sres = JSON.parse(res);
			empGrid.resetData(sres["data"]["contents"]);
		})
	});

	//그리드 내부 더블클릭
	empGrid.on('dblclick', function(ev) {
		$('#empNm').val(empGrid.getValue(ev["rowKey"], "empNm"));
		empDialog.dialog("close");
	});

	empGrid.on('onGridUpdated', function() {
		empGrid.refreshLayout();
	});
</script>

</html>