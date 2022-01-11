<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"	href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<link rel="stylesheet"	href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<script	src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
</head>
<body>
<div>
 
</div>
<div>
	<div> 
		<label>설비코드</label><input type="text">
	</div>
</div>
<div id="grid"></div>
 
<script>
var Grid = tui.Grid;	  

const dataSource = {
	  api: {
	    	readData: { url: '${pageContext.request.contextPath}/grid/eqmList.do', 
				    	method: 'GET'
	    				},
			}, 
		contentType: 'application/json'
	};


const grid = new Grid({
	  el: document.getElementById('grid'),
	  data:dataSource,
	  columns: [
				  {
				    header: '설비코드',
				    name: 'eqmCd'
				  },
				  {
				    header: '설비구분',
				    name: 'eqmFg'
				  },
				  {
				    header: '설비명',
				    name: 'eqmNm'
				  },
				  {
				    header: '라인번호',
				    name: 'eqmMdl'                                                                                                           
				  },		  
				  {
				    header: '작업자',
				    name: 'empId'
				  },
				  {
				    header: '사용에너지',
				    name: 'energy'
				  },
				  {
				    header: '부하율',
				    name: 'lf',
				  },
				  {
				    header: '기준온도',
				    name: 'temp'
				  },
				  {
				    header: 'UPH',
				    name: 'uph',
				  },
				  {
				    header: '공정코드',
				    name: 'prcsCd',
				  },
		 		 ]
		 		
		});
		
grid.on('onGridUpdated', function() {
	grid.refreshLayout();
});

grid.on('click', (ev) => {
	console.log(ev);
  	console.log('clicked!!');
})

// 성공 실패와 관계 없이 응답을 받았을 경우
grid.on('response', function(ev) { 
	console.log(ev);
})
</script>
</body>
</html>