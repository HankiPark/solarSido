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
<div>
	<button type="button" id="btnAdd">추가</button>
	<button type="button" id="btnDel">삭제</button>
	<button type="button" id="btnSave">저장</button>
</div>
<div><input type = "text" id="cmmnNminfo"></div>
<div><button type="button" id="btnfind">검색</button></div>
<div id= "grid"></div>
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
	  
	  
var detailgridinfo = {
		  api: {
		    	readData: { url: '${pageContext.request.contextPath}/grid/cmmndataDetail.do', 
					    	method: 'GET' ,
					    	initParams : {cmmnCdId : 'prcs'}
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
				name : 'cmmnCdDetaId'
			},
			{
				header : '공통코드ID',
				name : 'cmmnCdId',
			},
			{
				header : '코드명',
				name : 'cmmnCdNm',
			},
			{
				header : '설명',
				name : 'cmmnCdDesct',
			}	
		 ]
	  });
	  
detailgridinfo.on('onGridUpdated', function() {
	detailgridinfo.refreshLayout(); 
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
	
btnAdd.addEventListener("click", function(){
	grid.appendRow({})
})
btnDel.addEventListener("click", function(){
	grid.removeCheckedRows(true);
})
btnSave.addEventListener("click", function(){
	grid.request('modifyData');
})
</script>
</body>

</html>