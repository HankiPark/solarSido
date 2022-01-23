<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<label>업체명</label> <input type="text" id="coNmFind">
<label>업체코드</label> <input type="text" id="coCdFind">
<button type="button" id="btnCoNm">조회</button>
<div id="gridCo"></div>
<script type="text/javascript">


		function CoList(){
			//미니 그리드(업체명단) 기본적으로 전체명단이 나옴
			const gridCo = new tui.Grid({
				el : document.getElementById('gridCo'), // 컨테이너 엘리먼트
				data : {api : {
					readData : {
						url : '${pageContext.request.contextPath}/grid/coNmList.do',
						method : 'GET'
					}
					
				},
				contentType : 'application/json'
			},
				bodyHeight : 500,
				columns : [ 
					{
					header : '업체코드',
					name : 'coCd',
				}, {
					header : '업체명',
					name : 'coNm'
				}, {
					header : '사업자등록번호',
					name : 'bizno',
					
				}, {
					header : '연락처',
					name : 'coNumber'
				}, {
					header : '업체구분',
					name : 'coFg',
					hidden : true
				}, 

				],

			});
			
			//찾기버튼눌렀을때
			$('#btnCoNm').on('click',function(){
				
				var coNm = $("#coNmFind").val();
				var coCd = $("#coCdFind").val();
				var coParams ={
						'coNm':coNm,
						'coCd':coCd,
						'coFg': 'P'
						}
				
				$.ajax({
					url:'${pageContext.request.contextPath}/grid/coNmList.do',
					data: coParams,
					contentType: 'application/json; charset=utf-8',
					
					
				}).done(function(res){
					var sres = JSON.parse(res);
					console.log(sres)
					gridCo.resetData(sres["data"]["contents"]);
				})
			/* 	fetch('${pageContext.request.contextPath}/grid/prdtInput.do?perPage=&startT='+startT+'&endT='+endT+'&prdNm='+prdNm+'&page=1')
				.then(res=>res.json())
				.then(response=>{inGrid.resetData(response["data"]["contents"]);console.log(response);inGrid.refreshLayout();}) */
				
			 });
			
			//그리드 내부 더블클릭시
			gridCo
			.on(
					'dblclick',
					function(ev) {
						$('#coNm').val(gridCo.getValue(ev["rowKey"], "coNm"));
						dialog3.dialog("close");
						 
					});
			
			
			
			
			
			
			gridCo.on('onGridUpdated', function() {
				gridCo.refreshLayout();
			});
		}
	</script>
</body>
</html>