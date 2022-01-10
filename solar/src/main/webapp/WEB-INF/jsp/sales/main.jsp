<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
</head>
<body>

asdasgfdf
<div id="grid"></div>

<script type="text/javascript">
console.log("${list}");
const grid = new tui.Grid({
	  el: document.getElementById('grid'), // 컨테이너 엘리먼트
	  columns: [ 
		  		{
			    header: '주문번호',
			    name: 'orderNo'
			  },
			  {
			    header: '접수일자',
			    name: 'recvDt',
			  },
			  {
			    header: '업체명',
			    name: 'cdNm'
			  }
	  ],

	});

</script>
</body>
</html>