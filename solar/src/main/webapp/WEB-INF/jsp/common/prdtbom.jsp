<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품BOM 관리</title>
</head>
<body>

	<label>제품 검색</label><br> 
	<label>제품코드</label><input type = "text" id="prdtCd"><label>제품명</label><input type = "text" id="prdtNm">
	<label>규격</label><input type ="text" id="prdSpec">
	<button type="button" id="btnfind">검색</button><br>
	<input type = "text" id = prdtNm readonly = "readonly"> 
	<div id="grid"></div>
	<div id="dialog-form"></div>
	<script>
	let dialog = $("#dialog-form").dialog({
		autoOpen : false,
		modal : true,
		width : 700,
		height : 700
	});
	
	var dataSource = {
			  api: {
			    	readData: { url: '${pageContext.request.contextPath}/grid/prdtbomList.do', 
						    	method: 'GET'
						   }
					},
		/*			initialRequest : false, // 조회버튼 누르면 값을 불러오겠다 */
					contentType: 'application/json'
					};

	var grid = new tui.Grid({
		  el: document.getElementById('grid'),
		  data:dataSource, 
		  scrollY : true,
		  rowHeaders : [ 'rowNum','checkbox' ],
		  columns : 
			  [
				{
					header : '자재코드',
					name : 'rscCd'
				},
				{
					header : '자재명',
					name : 'rscNm',
				},
				{
					header : '제품코드',
					name : 'prdtCd',
				},				{
					header : '제품명',
					name : 'prdtNm',
				},				{
					header : '사용량',
					name : 'rscUseQty',
				},				{
					header : '규격',
					name : 'prdtSpec',
				}
			  ]
		  });
		  
	grid.on('onGridUpdate', function(){
		grid.refreshLayout();
	});

	grid.on('response', function(ev) { 
		console.log(ev);
		let res = JSON.parse(ev.xhr.response);
		if(res.mode=='upd'){
			grid.resetOriginData();
		}
		else {
			grid.refreshLayout()
			}
	});
	
	$('#prdtCd').on('click',function() {
			dialog.dialog("open");
			$("#dialog-form").load(
			"${pageContext.request.contextPath}modal/prdtlistbom",
			function() {
				prdtinfoList();
				});
			});
	</script>
</body>
</html>