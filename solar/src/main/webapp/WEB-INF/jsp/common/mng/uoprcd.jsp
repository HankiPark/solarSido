<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비가동코드 관리</title>
</head>
<body>
<h3>비가동코드 관리</h3>
<br>
<br>
<div>
	<button type="button" id="btnAdd">추가</button>
	<button type="button" id="btnDel">삭제</button>
	<button type="button" id="btnSave">저장</button><br>
</div>
	<label>비가동명 입력</label>
	<input type = "text" id="uoprNminfo">
	<div><button type="button" id="btnfind">검색</button></div>
	
	<div id="grid"></div>
	
	<div id="dialog-form" title="공정명단"></div>

<script>
let dialog = $("#dialog-form").dialog({
	autoOpen : false,
	modal : true,
	width : 700,
	height : 700
});

var dataSource = {
		  api: {
		    	readData: { url: '${pageContext.request.contextPath}/grid/uoprcdList.do', 
					    	method: 'GET' 
					   },
				modifyData: { url: '${pageContext.request.contextPath}/grid/uoprcdUpdate.do', 
							method: 'POST',
							cache:false			 
					}
				},
/*				initialRequest : false, // 조회버튼 누르면 값을 불러오겠다 */
				contentType: 'application/json'
		};


var grid = new tui.Grid({
	  el: document.getElementById('grid'),
	  data:dataSource, 
	  scrollX : true,
	  scrollY : true,
	  rowHeaders : [ 'rowNum','checkbox' ],
	  bodyHeight : 700,
	  columns : 
		  [
			{
				header : '비가동코드',
				name : 'uoprCd',
			    sortable: true
			},
			{
				header : '발생공정코드',
				name : 'prcsCd'
			},
			{
				header : '발생공정명',
				name : 'prcsNm'
			},
			{
				header : '비가동명',
				name : 'uoprNm',
				editor : 'text'
			},
			{
				header : '비가동내역',
				name : 'uoprDesct',
				editor : 'text'
			}
		]
	  });
	  
	
grid.on('onGridUpdated', function() {
	
	grid.refreshLayout(); //변경된 데이터로 확정
	
	});
	
grid.on('response', function(ev) {  // 성공/실패와 관계 없이 응답을 받았을 경우
		console.log(ev);
		let res = JSON.parse(ev.xhr.response);
		if(res.mode=='upd'){
			grid.resetOriginData();
			grid.refreshLayout();
			grid.readData(1,{},true);
		}
	});
	

grid.on('click', function(ev){
	/*
	console.log(ev["columnName"]);
	console.log(grid.getValue(ev["rowKey"], "prcsNm"));
	*/
	if(ev["columnName"] == "prcsCd") {
		dialog.dialog("open");
		$("#dialog-form").load(
				"${pageContext.request.contextPath}/modal/prcsinfoList",
							function(){
								prcsinfoList(ev["rowKey"]);
								grid.refreshLayout();
		})
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

$('#btnfind').on('click', function(){
	var uoprNm = $("#uoprNminfo").val();
	var parameter = {
			'uoprNm' : uoprNm
	}
	$.ajax({
		url : '${pageContext.request.contextPath}/grid/uoprcddataFind',
		data : parameter,
		contentType: 'application/json; charset=utf-8'
	}).done(function(res){
		var info = JSON.parse(res);
		grid.resetData(info["data"]["contents"]);
	})
	
});


</script>
</body>
</html>