<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 리스트</title>
</head>

<body>
	<label>업체코드</label>
	<input type="text" id="prdtCdFind">
	<label>업체명</label>
	<input type="text" id="prdtNmFind">

	<button type="button" id="btnfind">조회</button>


	<div id="coCdGrid"></div>
</body>

<script type="text/javascript">
function prdtList(){
	const prdtGrid = new tui.Grid(
			{
				el : document.getElementById('prdtGrid'),
				data : {
					api : {
						readData : {
							url : '${pageContext.request.contextPath}/grid/findCoCd.do',
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
					name : 'prdtCd'
				}, {
					header : '제품명',
					name : 'prdtNm'
				}, {
					header : '규격',
					name : 'prdtSpec'
				}, {
					header : '단위',
					name : 'prdtUnit',
					hidden : true
				}, {
					header : '금액',
					name : 'prdtAmt',
					hidden : true
				}, {
					header : '이미지',
					name : 'prdtImg',
					hidden : true
				}]
			});

	//검색버튼
	$('#btnfind').on('click', function() {
		var prdtCd = $("#prdtCdFind").val();
		var prdtNm = $("#prdtNmFind").val();
		console.log(coCd);
		console.log(coNm);
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