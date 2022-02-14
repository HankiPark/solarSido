<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<label>제품명</label> <input type="text" id="prdNmFind">
<label>제품코드</label> <input type="text" id="prdCdFind">
<button type="button" id="btnNm">조회</button>
<div id="gridD"></div>
<script type="text/javascript">


		function NmList(){
			//미니 그리드(제품명단) 기본적으로 전체명단이 나옴
			const gridD = new tui.Grid({
				el : document.getElementById('gridD'), // 컨테이너 엘리먼트
				data : {api : {
					readData : {
						url : '${pageContext.request.contextPath}/grid/prdtNmList.do',
						method : 'GET'
					}
					
				},
				contentType : 'application/json'
			},
				bodyHeight : 500,
				columns : [ 
					{
					header : '제품코드',
					name : 'prdtCd',
					align : 'center'
				}, {
					header : '제품명',
					name : 'prdtNm',
					align : 'center'
				}, {
					header : '규격',
					name : 'prdtSpec',
					align : 'center'
					
				}, {
					header : '단위',
					name : 'prdtUnit',
					align : 'center'
				}, {
					header : '금액',
					name : 'prdtAmt',
					align : 'center'
				},

				],

			});
			
			//찾기버튼눌렀을때
			$('#btnNm').on('click',function(){
				
				var prdNm = $("#prdNmFind").val();
				var prdCd = $("#prdCdFind").val();
				var params ={
						'prdNm':prdNm,
						'prdCd':prdCd
						}
				
				$.ajax({
					url:'${pageContext.request.contextPath}/grid/prdtNmList.do',
					data: params,
					contentType: 'application/json; charset=utf-8',
					
					
				}).done(function(res){
					var sres = JSON.parse(res);
					gridD.resetData(sres["data"]["contents"]);
				})
				
			 });
			
			//그리드 내부 더블클릭시
			gridD
			.on(
					'dblclick',
					function(ev) {
						$('#prdNm').val(gridD.getValue(ev["rowKey"], "prdtNm"));
						dialog.dialog("close");
						 
					});
			
			
			
			
			
			
			gridD.on('onGridUpdated', function() {
				gridD.refreshLayout();
			});
		}
	</script>
</body>
</html>