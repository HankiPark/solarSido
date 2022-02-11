<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<label>업체코드</label>
	<input type="text" id="coCdFind">
	<label>업체명</label>
	<input type="text" id="coNmFind">
	<button type="button" id="btnfindCo">검색</button>
	<button type="button" id="btnReset">초기화</button>

	<div id="coCdGrid"></div>
</body>

<script type="text/javascript">
function coCdList(){
	const coCdGrid = new tui.Grid(
			{
				el : document.getElementById('coCdGrid'),
				data : {
					api : {
						readData : {
							url : '${pageContext.request.contextPath}/grid/coselectR',
							method : 'GET'
						}
					},
					contentType : 'application/json'
				},
				scrollX : false,
				scrollY : true,
				bodyHeight : 500,
				columns : [ {
					header : '업체코드',
					name : 'coCd'
				}, {
					header : '업체명',
					name : 'coNm'
				}, {
					header : '사업자등록번호',
					name : 'bizno'
				}, {
					header : '업체구분',
					name : 'coFg',
					hidden : true
				} ]
			});

	//검색버튼
	$('#btnfindCo').on('click', function() {
		var coNm = $("#coNmFind").val();
		var coCd = $("#coCdFind").val();
		var Params = {
			'coCd' : coCd,
			'coNm' : coNm
		}
		$.ajax({
			url : '${pageContext.request.contextPath}/grid/findCoCd.do',
			data : Params,
			contentType : 'application/json; charset=utf-8'
		}).done(function(res) {
			var sres = JSON.parse(res);
			coCdGrid.resetData(sres["data"]["contents"]);
		})
	});
	
	//그리드 내부 더블클릭
	coCdGrid.on('dblclick', function(ev) {
		$('#coCd').val(coCdGrid.getValue(ev["rowKey"], "coCd"));
		$('#coNm').val(coCdGrid.getValue(ev["rowKey"], "coNm"));
		coCdDialog.dialog("close");
	});

	coCdGrid.on('onGridUpdated', function() {
		coCdGrid.refreshLayout();
	});
	
}
</script>
</html>