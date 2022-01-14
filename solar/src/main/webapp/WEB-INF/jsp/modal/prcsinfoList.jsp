<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공정검색 modal</title>
</head>
<body>
<label>공정코드</label> <input type = "text" id="prcsCdIn">
<label>공정명</label> <input type = "text" id="prcsNmIn">
<button type = "button" id ="btnFind"></button>
<div id = "gridPrcs">
</div>

<script type="text/javascript">

var dataSource = {
		  api: {
		    	readData: { url: '${pageContext.request.contextPath}/grid/fairList.do', 
					    	method: 'GET' 
					   },
/*				initialRequest : false, // 조회버튼 누르면 값을 불러오겠다 */
				contentType: 'application/json'
		};

function prscIndata(key {
	const gridPrcs = new tui.Grid({
		el : document.getElementById('prscIndata'),
		data : null, // 수정할것
		bodyHeight : 450,		
		 columns : [
				{
					header : '공정코드',
					name : 'prcsCd'
				},
				{
					header : '공정구분',
					name : 'prcsFg',
					hidden: true
				},
				{
					header : '공정명',
					name : 'prcsNm'
				},
				{
					header : '작업설명',
					name : 'prcsDesct',
					hidden: true
				},
				{
					header : '관리단위',
					name : 'prcsUnit',
					hidden: true
				},
				{
					header : '생산일수',
					name : 'prodPd',
					hidden: true
				}
			]  
	});
	
	
})
</script>
</body>
</html>