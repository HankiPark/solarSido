<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>gongjung_info</title>
<link rel="stylesheet"	href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<link rel="stylesheet"	href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<script	src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
</head>
<body>
<h3>공정정보관리</h3>
	<div id="grid">
	</div>
<script>
var Grid = tui.Grid;

const columns = [
	
	{
		header : '공정코드',
		name : 'prcs_cd'
	},
	{
		header : '공정구분',
		name : 'prcs_fg'
	},
	{
		header : '공정명',
		name : 'prcs_nm'
	},
	{
		header : '작업설명',
		name : 'prcs_desct'
	},
	{
		header : '관리단위',
		name : 'prcs_unit'
	},
	{
		header : '생산일수',
		name : 'prod_pd'
	}
]

const dataSource = {
	  api: {
	    	readData: { url: '${pageContext.request.contextPath}/grid/fairSelect', 
				    	method: 'GET', 
				    	initParams: { param: 'param' } },
			modifyData: { url: '${pageContext.request.contextPath}/modifyData', 
						method: 'PUT' }
			},
			initialRequest : false, // 조회버튼 누르면 값을 불러오겠다
			contentType: 'application/json'
	};

const grid = new Grid({
	  el: document.getElementById('grid'),
	  data:dataSource, 
	  scrollY : true,
	  rowHeaders : [ 'rowNum','checkbox' ],
	  columns, //필드명:값, 같은 경우 생략가능
	  columnOptions: {
	  	}  
	  });
grid.on('click', (ev) => {
		console.log(ev);
	  	console.log('clicked!!');	
	})
grid.on('response', function(ev) {
		  // 성공/실패와 관계 없이 응답을 받았을 경우
		console.log(ev);
		grid.resetOriginData(); //변경된 데이터로 확정
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
btnFind.addEventListener("click", function(){
	//grid.request('modifyData');
})

</script>
</body>
</html>