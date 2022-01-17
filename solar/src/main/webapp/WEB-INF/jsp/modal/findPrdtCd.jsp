<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>
	<label>제품명</label>
	<input type="text" id="prdNmFind">
	<label>제품코드</label>
	<input type="text" id="prdCdFind">
	<button type="button" id="btnNm">검색</button>

	<div id="prdtCdGrid"></div>
</body>

<script type="text/javascript">
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
	$('#btnNm').on('click', function() {
		var prdtNm = $("#prdNmFind").val();
		var prdtCd = $("#prdCdFind").val();
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
</script>

</html>