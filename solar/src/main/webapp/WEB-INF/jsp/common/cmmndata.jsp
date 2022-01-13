<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공통자료관리</title>
<link rel="stylesheet"	href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css"/>
<link rel="stylesheet"	href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<script	src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
</head>
<body>
<h2>공통자료관리</h2>
<div>
	<button type="button" id="btnAdd">추가</button>
	<button type="button" id="btnDel">삭제</button>
	<button type="button" id="btnSave">저장</button>
</div>
<div id= "grid">
</div>
<div id= "detailgrid"></div>
<script>
var dataSource = {
		  api: {
		    	readData: { url: '${pageContext.request.contextPath}/grid/cmmndataList.do', 
					    	method: 'GET' 
					   },
				modifyData: { url: '${pageContext.request.contextPath}/modifyData', 
							method: 'PUT' }
				},
/*				initialRequest : false, // 조회버튼 누르면 값을 불러오겠다 */
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
					    	method: 'GET' 
					   },
				modifyData: { url: '${pageContext.request.contextPath}/modifyData', 
							method: 'PUT' }
				},
/*				initialRequest : false, // 조회버튼 누르면 값을 불러오겠다 */
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
				name : 'cmmnDtCdNm',
			},
			{
				header : '설명',
				name : 'cmmnCdDesct',
			}	
		 ]
	  });
	  
	  
grid.on('click', (ev) => {
		console.log(ev);
	  	console.log('clicked!!'); 
	})
grid.on('response', function(ev) {
		  // 성공/실패와 관계 없이 응답을 받았을 경우
		console.log(ev);
		grid.refreshLayout(); //변경된 데이터로 확정
	})

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