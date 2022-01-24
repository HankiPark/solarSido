<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품BOM 관리</title>
</head>
<body>
	<button type="button" id="btnAdd">추가</button>
	<button type="button" id="btnDel">삭제</button>
	<button type="button" id="btnSave">저장</button>
	<br>
	<label>제품 검색</label><br> 
	<label>제품코드</label><input type = "text" id="prdtCd">
	<label>제품명</label><input type = "text" id="prdtNm" readonly="readonly">
	<label>규격</label><input type ="text" id="prdtSpec" readonly="readonly">
	<button type="button" id="btnfindinfo">검색</button><br>
	<div id="grid"></div>
	<div id="dialog-form"></div>
	<div id="dialog-form2"></div>
	<script>
	let prdtGrid;
	
	let dialog = $("#dialog-form").dialog({
		autoOpen : false,
		modal : true,
		width : 700,
		height : 700
	});
	
	let dialog2 = $("#dialog-form2").dialog({
		autoOpen : false,
		modal : true,
		width : 700,
		height : 700
	});
	
	var dataSource = {
			  api: {
			    	readData: { url: '${pageContext.request.contextPath}/grid/prdtbomList.do', 
						    	method: 'GET'
						   },
					modifyData: { url: '${pageContext.request.contextPath}/grid/prdtbomUpdateIn.do', 
									method: 'POST' }
				},
				initialRequest : false, // 조회버튼 누르면 값을 불러오겠다 
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
					name : 'rscCd',
					
				},
				{
					header : '자재명',
					name : 'rscNm',
				},
				{
					header : '제품코드',
					name : 'prdtCd',
					editor : 'text'
				},				
				{
					header : '사용량',
					name : 'rscUseQty',
					editor : 'text'
				},				
				{
					header : '규격',
					name : 'prdtSpec',
					editor : 'text'
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
	$('#btnAdd').on('click', function appendRow(index){
		grid.appendRow({}, {
			extendPrevRowSpan : true,
			focus : true,
			at : 0
		});
	});
	$('#btnSave').on('click', function appendRow(index){
		grid.blur();
		grid.request('modifyData');
	});
	$('#btnDel').on('click', function appendRow(index){
		grid.blur();
		grid.removeCheckedRows(true);
	});
	
	$('#btnfindinfo').on('click', function(){
		var prdtCd = $("#prdtCd").val();
		var parameter = {
				'prdtCd' : prdtCd
		}
		$.ajax({
			url : '${pageContext.request.contextPath}/grid/prdtbomSearch',
			data : parameter,
			contentType: 'application/json; charset=utf-8'
		}).done(function(res){
			var info = JSON.parse(res);
			grid.resetData(info["data"]["contents"]);
		})
		
	});

	
	grid.on('click', function(ev){
		if(ev["columnName"] == "rscCd") {
			dialog2.dialog("open");
			$("#dialog-form2").load(
					"${pageContext.request.contextPath}/modal/rscinfoList",
								function(){
									rscinfoList(ev["rowKey"]);
									grid.refreshLayout();
			})
		}
	});	
	
	$('#prdtCd').on('click',function() {
			dialog.dialog("open");
			$("#dialog-form").load(
			"${pageContext.request.contextPath}/modal/prdtlistbom"
			);
	});
	</script>
</body>
</html>