<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자재 불량 코드 관리</title>

</head>
<body>
<h3>자재 불량 코드관리</h3>
<div>
	<button type="button" id="btnAdd">추가</button>
	<button type="button" id="btnDel">삭제</button>
	<button type="button" id="btnSave">저장</button>
</div>
	<div id="grid">
		
	</div>
<script>
var dataSource = {
		  api: {
		    	readData: { url: '${pageContext.request.contextPath}/grid/rscinferList.do', 
					    	method: 'GET' 
					   },
				modifyData: { url: '${pageContext.request.contextPath}/grid/rscinferModify.do', 
							method: 'POST' }
					   
				},
/*				initialRequest : false, // 조회버튼 누르면 값을 불러오겠다 */
				contentType: 'application/json'
		};


var grid = new tui.Grid({
	  el: document.getElementById('grid'),
	  data:dataSource, 
	  scrollY : true,
	  rowHeaders : [ 'rowNum','checkbox' ],
	  bodyHeight : 700,
	  columns : 
		  [
			{
				header : '반품사유코드',
				name : 'rtngdResnCd',
				editor : 'text'
			},
			{
				header : '불량명',
				name : 'rscInferNm',
				editor : 'text'
			},
			{
				header : '불량내역',
				name : 'rscInferDesct',
				editor : 'text'
			}
		]
	  });
	  
grid.on('onGridUpdated', function() {
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
	grid.appendRow(null, {
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
</script>
</body>
</html>