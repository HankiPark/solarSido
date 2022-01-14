<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="row">
			<div data-role="fieldcontain" class="col-7">
				<label for="defandroid">날짜 선택</label> <input name="startT"
					id="startT2" type="date" data-role="datebox"
					data-options='{"mode": "calbox"}'> ~ <input name="endT"
					id="endT2" type="date" data-role="datebox"
					data-options='{"mode": "calbox"}'>
			</div>
			<div data-role="fieldcontain" class="col-5">
				<label>업체명</label> 
				<select name="nowCo">
				 <c:forEach items="${coList}" var="co">
					<option value="${co.coNm}"></option>
				</c:forEach>
			</select>
			</div>
</div>
<button type="button" id="btnSlNm">찾기</button>
<div id="gridSl"></div>
<script type="text/javascript">
document.getElementById('startT2').value = nd.toISOString().slice(0, 10);
document.getElementById('endT2').value = d.toISOString().slice(0, 10);

		function slList(){
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
			$('#btnSlNm').on('click',function(){
				
				var coNm = $("#coNmFind").val();
				var coCd = $("#coCdFind").val();
				var coParams ={
						'copNm':coNm,
						'copCd':coCd,
						'coFg': 'P'
						}
				
				$.ajax({
					url:'${pageContext.request.contextPath}/grid/coNmList.do',
					data: coParams,
					contentType: 'application/json; charset=utf-8',
					
					
				}).done(function(res){
					var sres = JSON.parse(res);
					gridD.resetData(sres["data"]["contents"]);
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