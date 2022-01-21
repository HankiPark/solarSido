<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 리스트</title>
</head>
<body>
<div id = "grid"></div>
	<label>제품코드</label><input type="text" id="prdtCdFind">
	<label>제품명</label><input type="text" id="prdtNmFind">
	<button type="button" id="btnNm">검색</button>
	<div id="prdtCdGrid"></div>
<script>
function prdtinfoList(){

	prdtCdGrid = new tui.Grid(
		{
			el : document.getElementById('prdtCdGrid'),
			data : {
				api : {
					readData : {
						url : '${pageContext.request.contextPath}/grid/prdtmodalList.do',
						method : 'GET'
					}
				},
				contentType : 'application/json'
			},
			scrollX : false,
			scrollY : true,
			bodyHeight : 500,
			columns : 
				[ 
				{
				header : '제품코드',
				name : 'prdtCd'
				}, 
				{
				header : '제품명',
				name : 'prdtNm'
				}, 
				{
				header : '규격',
				name : 'prdtSpec',
				hidden : true
				}, 
				{
				header : '단위',
				name : 'prdtUnit',
				hidden : true
				},
				{
				header : '금액',
				name : 'prdtAmt',
				hidden : true
				},
				{
				header : '이미지',
				name : 'prdtImg',
				hidden : true
				}
				]
		});

//검색버튼
$('#btnNm').on('click', function() {
	var prdtCd = $("#prdCdFind").val();
	var prdtNm = $("#prdNmFind").val();
	var prdtSpec = $("prdtSpec").val();
	var params = {
		'prdtCd' : prdtCd,
		'prdtNm' : prdtNm,
		'prdtSpec' : prdtSpec
	}
	$.ajax({
		url : '${pageContext.request.contextPath}/grid/prdtinfoSearch',
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
</body>
</html>