<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공통자료관리</title>

</head>
<body>
<h2>공통자료관리</h2>
<label>공통코드ID 검색</label> <div><input type = "text" id="cmmnNminfo"></div>
<div><button type="button" id="btnfind">검색</button></div>
<div id= "grid"></div><br>
	<button type="button" id="btnDel">삭제</button>
	<button type="button" id="btnSave">저장</button>
<div id= "detailgrid"></div>
<script>
var dataSource = {
		  api: {
		    	readData: { url: '${pageContext.request.contextPath}/grid/cmmndataList.do', 
					    	method: 'GET'
					   }
				},
				contentType: 'application/json'
				};


var grid = new tui.Grid({
	  el: document.getElementById('grid'),
	  data:dataSource, 
	  scrollY : true,
	  rowHeaders : [ 'rowNum','checkbox' ],
	  bodyHeight : 500,
	  columns : 
		  [
			{
				header : '공통코드ID',
				name : 'cmmnCdId'
			},
			{
				header : '공통코드ID명',
				name : 'cmmnCdNm',
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

grid.on('click', function(ev){
	let JsonData = grid.getRowAt(ev.rowKey);
	let key1 = Object.values(JsonData);
	
	$('cmmnCdId').val(key1[0]);
	
	var GridParams = {
			'cmmnCdId' : key1[0]
	};
	
	detailgrid.readData(1, GridParams, true);
});

$('#btnfind').on('click', function(){
	var cmmnCdNm = $("#cmmnNminfo").val();
	var parameter = {
			'cmmnCdNm' : cmmnCdNm
	}
	$.ajax({
		url : '${pageContext.request.contextPath}/grid/cmmndataFind',
		data : parameter,
		contentType: 'application/json; charset=utf-8'
	}).done(function(res){
		var info = JSON.parse(res);
		grid.resetData(info["data"]["contents"]);
	})
	
});
	  
	  
var detailgridinfo = {
		  api: {
		    	readData: { url: '${pageContext.request.contextPath}/grid/cmmndataDetail.do', 
					    	method: 'GET'
					   },
				modifyData: { url: '${pageContext.request.contextPath}/modifyData', 
							method: 'PUT' }
				},
				initialRequest : false, // 조회버튼 누르면 값을 불러오겠다
				contentType: 'application/json'
		};


var detailgrid = new tui.Grid({
	  el: document.getElementById('detailgrid'),
	  data:detailgridinfo, 
	  scrollY : true,
	  rowHeaders : [ 'rowNum','checkbox' ],
	  bodyHeight : 500,
	  columns : 
		  [
			{
				header : '공통코드상세ID',
				name : 'cmmnCdDetaId',
				editor : 'text'
			},
			{
				header : '공통코드ID',
				name : 'cmmnCdId',
				editor : 'text'
			},
			{
				header : '코드명',
				name : 'cmmnCdNm',
				editor : 'text'
			},
			{
				header : '설명',
				name : 'cmmnCdDesct',
				editor : 'text'
			}	
		 ]
	  });
	  
detailgrid.on('onGridUpdated', function() {
	detailgrid.refreshLayout(); 
	grid.refreshLayout();
	});
	
detailgrid.on('response', function(ev) { 
		console.log(ev);
		let res = JSON.parse(ev.xhr.response);
		if(res.mode=='upd'){
			detailgrid.resetOriginData();
		}
		else {
			detailgrid.refreshLayout()
			}
	});

$('#btnSave').on('click', function appendRow(index){
	detailgrid.blur();
	detailgrid.request('modifyData');
});
$('#btnDel').on('click', function appendRow(index){
	detailgrid.blur();
	detailgrid.removeCheckedRows(true);
});


</script>
</body>

</html>