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
					
					<option value="제품잘사는집">제품잘사는집</option>
					<option value="제품싸게잘사는집">제품싸게잘사는집</option>
				</select>
			</div>
</div>
<button type="button" id="btnSlNm">조회</button>
<div id="gridSl"></div>
<script type="text/javascript">
var d2 = new Date();
var nd2 = new Date(d.getFullYear(), d.getMonth(), d.getDate() - 7);
document.getElementById('startT2').value = nd2.toISOString().slice(0, 10);
document.getElementById('endT2').value = d2.toISOString().slice(0, 10);

		function slList(){
		/* 	박한기 패배하고 하드코딩하다.. 2022/1/14
			var nowCo = $("select[name='nowCo']");
			nowCo.empty();
			for(let i=0;i<"${coList.size()}";i++){
				console.log("${coList[0].coNm}");

				nowCo.append(`<option value="${coList[i].coNm}">"${coList[i].coNm}"</option>`);
			} */

			//미니 그리드(전표명단) 기본적으로 전체전표명단이 나옴
			const gridSl = new tui.Grid({
				el : document.getElementById('gridSl'), // 컨테이너 엘리먼트
				data : {api : {
					readData : {
						url : '${pageContext.request.contextPath}/grid/slipList.do',
						method : 'GET'
					}
					
				},
				initialRequest: false,
				contentType : 'application/json'
			},
				bodyHeight : 500,
				columns : [ 
					{
					header : '전표번호',
					name : 'slipNo',
				}, {
					header : '출고일자',
					name : 'prdtDt'
				}, {
					header : '업체명',
					name : 'coNm',
					
				}, {
					header : '상세전표수',
					name : 'slNm',
					
				}
				],

			});
			
			//찾기버튼눌렀을때
			$('#btnSlNm').on('click',function(){
				
				var startT2 = $("#startT2").val();
				var endT2 = $("#endT2").val();
				var coNm2 = $("[name=nowCo] option:selected").val();
				var slParams = {
					'startT' : startT2,
					'endT' : endT2,
					'coNm' : coNm2
				}
				
				$.ajax({
					url:'${pageContext.request.contextPath}/grid/slipList.do',
					data: slParams,
					contentType: 'application/json; charset=utf-8',
					
					
				}).done(function(res){
					var sres = JSON.parse(res);
					gridSl.resetData(sres["data"]["contents"]);
				})
			/* 	fetch('${pageContext.request.contextPath}/grid/prdtInput.do?perPage=&startT='+startT+'&endT='+endT+'&prdNm='+prdNm+'&page=1')
				.then(res=>res.json())
				.then(response=>{inGrid.resetData(response["data"]["contents"]);console.log(response);inGrid.refreshLayout();}) */
				
			 });
			
			//그리드 내부 더블클릭시
			gridSl
			.on(
					'dblclick',
					function(ev) {
						$('#slipNm2').val(gridSl.getValue(ev["rowKey"], "slipNo"));
						
						$('#showDt').val(gridSl.getValue(ev["rowKey"], "prdtDt"));
						$('#showCoNm').val(gridSl.getValue(ev["rowKey"], "coNm"));
						var sendParams={
								'slipNo' : gridSl.getValue(ev["rowKey"], "slipNo")
						}
						
						$('#C').css('display','none');
						$('#noC').css('display','block');
						outGrid2.readData(1,sendParams,true);
						
						dialog3.dialog("close");
						 
					});
			
			
			
			
			
			
			gridSl.on('onGridUpdated', function() {
				gridSl.refreshLayout();
			});
		}
	</script>
</body>
</html>