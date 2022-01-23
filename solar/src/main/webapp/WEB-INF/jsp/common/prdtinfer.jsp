<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 불량내역 관리</title>

</head>
<body>
<h3>제품 불량내역 관리</h3>
<div>
	<button type="button" id="btnAdd">추가</button>
	<button type="button" id="btnDel">삭제</button>
	<button type="button" id="btnSave">저장</button>
	<input type = "text" id="prdtinferNminfo">
	<div><button type="button" id="btnfind">검색</button></div>
</div>
	<div id="grid">
		
	</div>
<script>
var dataSource = {
		  api: {
		    	readData: { url: '${pageContext.request.contextPath}/grid/prdtList.do', 
					    	method: 'GET' 
					   },
				modifyData: { url: '${pageContext.request.contextPath}/grid/prdtinferModify.do', 
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
				header : '불량코드',
				name : 'prdtInferCd',
				editor : 'text'
			},
			{
				header : '공정코드',
				name : 'prcsInferCd',
				editor : 'text'
			},
			{
				header : '불량명',
				name : 'prdtInferNm',
				editor : 'text'
			},
			{
				header : '불량내역',
				name : 'prdtInferDesct',
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
	grid.appendRow( {}, {
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
	var prdtInferNm = $("#prdtinferNminfo").val();
	var parameter = {
			'prdtInferNm' : prdtInferNm
	}
	$.ajax({
		url : '${pageContext.request.contextPath}/grid/prdtinferdataFind',
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