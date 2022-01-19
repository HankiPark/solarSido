<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자재정보관리</title>
</head>
<body>
	<label>자재명 검색</label>
	<input type="text" id="rscNmFind">
	<button type="button" id="btnFind">검색</button>
	<div id="grid"></div>
	<script>
		var dataSource = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/grid/rscinfoList.do',
					method : 'GET'
				}
			},
			contentType : 'application/json'
		};

		var grid = new tui.Grid({
			el : document.getElementById('grid'),
			data : dataSource,
			scrollY : true,
			rowHeaders : [ 'rowNum', 'checkbox' ],
			bodyHeight : 500,
			columns : 
			[ 
				{
					header : '자재코드',
					name : 'rscCd'
				}, 
				{
					header : '자재명',
					name : 'rscNm'
				},
				{
					header : '안전재고',
					name : 'safStc',
					hidden : true
				},
				{
					header : '업체코드',
					name : 'coCd',
					hidden : true
				},
				{
					header : '규격',
					name : 'rscSpec'
				},
				{
					header : '관리단위',
					name : 'rscUnit',
					hidden : true
				},
				{
					header : '이미지',
					name : 'rscImg',
					hidden : true
				},
				{
					header : '단가',
					name : 'rscUntprc',
					hidden : true
				}
			]
		});

		grid.on('onGridUpdate', function(){
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

		$('#btnFind').on('click', function(){
			var rscNm = $("#rscNmFind").val();
			var parameter = {
					'rscNm' : rscNm
			}
			$.ajax({
				url : '${pageContext.request.contextPath}/grid/rscinfoFind',
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