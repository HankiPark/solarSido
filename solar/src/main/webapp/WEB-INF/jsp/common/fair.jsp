<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>gongjung_info</title>

</head>
<body>
<h3>공정정보관리</h3>
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
		    	readData: { url: '${pageContext.request.contextPath}/grid/fairList.do', 
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
	  bodyHeight : 700,
	  columns : [
			{
				header : '공정코드',
				name : 'prcsCd'
			},
			{
				header : '공정구분',
				name : 'prcsFg'
			},
			{
				header : '공정명',
				name : 'prcsNm'
			},
			{
				header : '작업설명',
				name : 'prcsDesct'
			},
			{
				header : '관리단위',
				name : 'prcsUnit'
			},
			{
				header : '생산일수',
				name : 'prodPd'
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