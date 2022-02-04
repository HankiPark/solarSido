<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<label>공정코드</label> <input type = "text" id="prcsCdIn">
<label>공정명</label> <input type = "text" id="prcsNmIn">
<button type = "button" id ="btnFind">조회</button>
<div id = "gridPrcs">
</div>

<script type="text/javascript">
function prcsinfoList(key){

var dataSource = {
		  api: {
		    	readData: { url: '${pageContext.request.contextPath}/grid/prcsinfoModal', 
					    	method: 'GET' 
					   },
				modifyData: { url: '${pageContext.request.contextPath}/grid/fairUpdateIn.do', 
							method: 'POST' }
				},
/*				initialRequest : false, // 조회버튼 누르면 값을 불러오겠다 */
				contentType: 'application/json'
				}
	const gridPrcs = new tui.Grid({
		el : document.getElementById('gridPrcs'), // 컨테이너 엘리먼트
		data : dataSource,
		scrollY : true,
		bodyHeight : 500,
		
		  columns : [
				{
					header : '공정코드',
					name : 'prcsCd'
				},
				{
					header : '공정구분',
					name : 'prcsFg',
					hidden : true
				},
				{
					header : '공정명',
					name : 'prcsNm'
				},
				{
					header : '작업설명',
					name : 'prcsDesct',
					hidden : true
				},
				{
					header : '관리단위',
					name : 'prcsUnit',
					hidden : true
				},
				{
					header : '생산일수',
					name : 'prodPd',
					hidden : true
				}
			]  
		  });

	gridPrcs.on('onGridUpdate', function(){
		gridPrcs.refreshLayout();
	});
	
	gridPrcs.on('response', function(ev) { 
		console.log(ev);
		let res = JSON.parse(ev.xhr.response);
		if(res.mode=='upd'){
			gridPrcs.resetOriginData();
		}
		else {
			gridPrcs.refreshLayout()
			}
	});

	$('#btnFind').on('click', function(){
		
		var prcsCd = $("#prcsCdIn").val();
		var prcsNm = $("#prcsNmIn").val();
		var parameter = {
				'prcsCd' : prcsCd,
				'prcsNm' : prcsNm
		}
		$.ajax({
			url : '${pageContext.request.contextPath}/grid/findPrcs',
			data : parameter,
			contentType: 'application/json; charset=utf-8'
		}).done(function(res){
			var info = JSON.parse(res);
			gridPrcs.resetData(info["data"]["contents"]);
		})
		
	});
	
		
	gridPrcs.on('dblclick', function(ev){
		if(ev["rowKey"]!=null){
			grid.setValue(key, 'prcsCd', gridPrcs.getValue(ev["rowKey"], "prcsCd"));
			grid.setValue(key, 'prcsNm', gridPrcs.getValue(ev["rowKey"], "prcsNm"));
			dialog3.dialog("close");
		}
	});
}
	
</script>
</html>