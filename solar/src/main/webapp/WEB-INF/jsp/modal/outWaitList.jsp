<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<button type="button" id="btnListOut">저장</button>
<div id="gridOu"></div>
<script type="text/javascript">


		function outWaitList(){
			let dataSourceD={
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/grid/outWaitList.do',
					method : 'GET',
					initParams: { indicaDetaNo : outGrid.getValue(rowKeyNm,"slipDetaNo"),
									prdtCd : outGrid.getValue(rowKeyNm,"prdtCd")
							
					}
				}
			},

			contentType : 'application/json'
		};
			const gridOu = new tui.Grid({
				el : document.getElementById('gridOu'), // 컨테이너 엘리먼트
				data : dataSourceD,
				bodyHeight : 500,
				rowHeaders : [ {
					type : 'rowNum',
					width : 100,
					align : 'left',
					valign : 'bottom'
				}, {
					type : 'checkbox'
				} ],
				columns : [ 
					{
						header : '제품LOT',
						name : 'prdtLot'
				}, {
					header : '제품코드',
					name : 'prdtCd',
				},{
					header : '제품상태',
					name : 'prdtFg',
					hidden : true
				}
				],

			});
			
			gridOu.on('onGridUpdated', function() {
				gridOu.refreshLayout();
				for(let i=0;i< gridOu.getRowCount();i++){
					if(gridOu.getValue(i,"prdtFg")=="OW"){
						gridOu.check(i);
					}
				}
			});
			
			
			$("#btnListOut").on("click",function(){
				for(let i of gridOu.getCheckedRowKeys()){
					console.log(i);
					//해당 OW상태(현 전표상세번호)를 모두 제거하고 새로운 OW상태를 만들기
					var slParams = {
							'indicaDetaNo' : outGrid.getValue(rowKeyNm,"slipDetaNo"),
							'prdtLot' : gridOu.getValue(i,"prdtLot")
						}
						//제거 ajax + 생성 ajax
						$.ajax({
							url:'${pageContext.request.contextPath}/ajax/resetOw.do',
							data: slParams,
							contentType: 'application/json; charset=utf-8',
							async: false,
							
							
						}).done(function(res){
							/* var sres = JSON.parse(res);
							gridSl.resetData(sres["data"]["contents"]); */
						})	
				}
				for(let i of gridOu.getCheckedRowKeys()){
					var slParams = {
							'indicaDetaNo' : outGrid.getValue(rowKeyNm,"slipDetaNo"),
							'prdtLot' : gridOu.getValue(i,"prdtLot")
						}
						$.ajax({
							url:'${pageContext.request.contextPath}/ajax/insertOw.do',
							data: slParams,
							contentType: 'application/json; charset=utf-8',
							async: false,
							
							
						}).done(function(res){
							/* var sres = JSON.parse(res);
							gridSl.resetData(sres["data"]["contents"]); */
						})	
				}
				if(gridOu.getCheckedRows().length<=outGrid.getValue(rowKeyNm,"orderQty")){
				outGrid.setValue(rowKeyNm,"oustQty",gridOu.getCheckedRows().length);
				outGrid.setValue(rowKeyNm,"prdtUntprc",outGrid.getValue(rowKeyNm,"prdtAmt")*outGrid.getValue(rowKeyNm,"oustQty"))
				dialog5.dialog("close");
				}else{
					alert("주문량보다 출고량이 "+(outGrid.getValue(rowKeyNm,"orderQty")-gridOu.getCheckedRows().length)+"개 많습니다.")
				}
			})
		}
	</script>
</body>
</html>