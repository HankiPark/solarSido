<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>
	<label>제품코드</label>
	<input type="text" id="prdtCdFind">
	<label>제품명</label>
	<input type="text" id="prdtNmFind">
	<button type="button" id="btnfind">검색</button>
	<button type="button" id="btnReset">초기화</button>
	
	<div id="prdtCdGrid"></div>
</body>

<script type="text/javascript">
function prdtCdList(){
	const prdtCdGrid = new tui.Grid(
			{
				el : document.getElementById('prdtCdGrid'),
				data : {
					api : {
						readData : {
							url : '${pageContext.request.contextPath}/grid/findPrdtCd.do',
							method : 'GET'
						}
					},
					contentType : 'application/json'
				},
				scrollX : false,
				scrollY : true,
				bodyHeight : 500,
				columns : [ {
					header : '제품코드',
					name : 'prdtCd',
				}, {
					header : '제품명',
					name : 'prdtNm'
				}, {
					header : '규격',
					name : 'prdtSpec',
				}, {
					header : '단위',
					name : 'prdtUnit'
				} ]
			});

	//검색버튼
	$('#btnfind').on('click', function() {
		var prdtNm = $("#prdtNmFind").val();
		var prdtCd = $("#prdtCdFind").val();
		var params = {
			'prdtNm' : prdtNm,
			'prdtCd' : prdtCd
		}
		$.ajax({
			url : '${pageContext.request.contextPath}/grid/findPrdtCd.do',
			data : params,
			contentType : 'application/json; charset=utf-8'
		}).done(function(res) {
			var sres = JSON.parse(res);
			prdtCdGrid.resetData(sres["data"]["contents"]);
		})
	});

	//그리드 내부 더블클릭
	prdtCdGrid.on('dblclick', function(ev) {
		$('#prdtCd').val(prdtCdGrid.getValue(ev["rowKey"], "prdtCd"));
		prdtCdDialog.dialog("close");
	});

	prdtCdGrid.on('onGridUpdated', function() {
		prdtCdGrid.refreshLayout();
	});
}
</script>

</html>