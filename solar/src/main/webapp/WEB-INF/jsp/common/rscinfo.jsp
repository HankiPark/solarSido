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
	<button type="button" id="btnFind">검색</button><br>
	<button type="button" id="btnSave">저장</button><br>
	<button type="button" id="btnReset">정보리셋</button><br>
	<div id="grid"></div>	
	<br>
	<label>자재코드</label> <input type="text" id="rscCd" readonly = "readonly"><br>
	<label>자재명</label> <input type="text" id="rscNm"><br>
	<label>규격</label> <input type="text" id="rscSpec" ><br>
	<label>관리단위</label> <input type="text" id="rscUnit"><br>
	<label>업체코드</label> <input type="text" id="coCd" readonly = "readonly"><button type="button" id="coCdFind">조회</button><br>
	<label>업체명</label> <input type="text" id="coNm"><br>
	<label>단가</label> <input type="text" id="rscUntprc" ><br>
	<label>안전재고</label> <input type="text" id="safStc"><br>
	<div id="coCdModal" title="업체명단"></div>
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
			rowHeaders : [ 'rowNum'],
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
		
		grid.on('click', (ev) =>{
			var row = ev.rowKey;
			var code = grid.getValue(row, 'rscCd');
			$("#rscCd").prop('readonly', true);
			
				$.ajax({
					url : "${pageContext.request.contextPath}/rscinfo.do",
					type : "POST",
					dataType: "json",
					cache: false,
					data : {rscCd : code},
					success: function(data){
						var vo = data["result"];
						$("#rscCd").val(vo["rscCd"]);
						$("#rscNm").val(vo["rscNm"]);
						$("#rscSpec").val(vo["rscSpec"]);
						$("#rscUnit").val(vo["rscUnit"]);
						$("#rscNm").val(vo["rscNm"]);
						$("#coCd").val(vo["coCd"]);
						$("#coNm").val(vo["coNm"]);
						$("#rscUntprc").val(vo["rscUntprc"]);
						$("#safStc").val(vo["safStc"]);
					}
				})
		})

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
		
		//업체검색 모달
		let coCdDialog = $("#coCdModal").dialog({
			autoOpen: false,
			modal: true,
			height: 600,
			width: 600
		});

		$("#coCdFind").on("click", function(){
			console.log("업체검색")
			coCdDialog.dialog("open");
			$("#coCdModal").load("${pageContext.request.contextPath}/modal/findCoCd", function(){ coCdList() })
		});

		
	</script>
</body>
</html>