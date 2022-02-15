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
				},
				modifyData : {
					url : '${pageContext.request.contextPath}/ajax/insertOw.do',
					method : 'POST',
					initParams: { 'indicaDetaNo' : outGrid.getValue(rowKeyNm,"slipDetaNo"),
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
						name : 'prdtLot',
						align : 'center'
				}, {
					header : '제품코드',
					name : 'prdtCd',
					align : 'center'
				},{
					header : '제품상태',
					name : 'prdtFg',
					hidden : true,
					align : 'center'
				},{
					header : '전표임시상세',
					name : 'indicaDetaNo',
					hidden : true,
					align : 'center'
				},
				
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
				var slParams = {
						'indicaDetaNo' : outGrid.getValue(rowKeyNm,"slipDetaNo")
					}
					//제거 ajax + 생성 ajax
					$.ajax({
						url:'${pageContext.request.contextPath}/ajax/resetOw.do',
						data: slParams,
						contentType: 'application/json; charset=utf-8',
						async: false,

					})
					if(gridOu.getCheckedRows().length<=outGrid.getValue(rowKeyNm,"orderQty")){
						gridOu.request("modifyData",{'checkedOnly': true,'modifiedOnly':false ,'showConfirm':false });
						outGrid.setValue(rowKeyNm,"oustQty",gridOu.getCheckedRows().length);
						outGrid.setValue(rowKeyNm,"prdtUntprc",outGrid.getValue(rowKeyNm,"prdtAmt")*outGrid.getValue(rowKeyNm,"oustQty"))
						dialog5.dialog("close");
						}else{
							alert("주문량보다 출고량이 "+(gridOu.getCheckedRows().length-outGrid.getValue(rowKeyNm,"orderQty"))+"개 많습니다.")
						}
					
/* 				for(let i of gridOu.getCheckedRowKeys()){
					var slParams = {
							,
							'prdtLot' : gridOu.getValue(i,"prdtLot")
						}
						$.ajax({
							url:'${pageContext.request.contextPath}/ajax/insertOw.do',
							data: slParams,
							contentType: 'application/json; charset=utf-8',
							async: false,
							
							
						}).done(function(res){
							 var sres = JSON.parse(res);
							gridSl.resetData(sres["data"]["contents"]); 
						})	
				} */
				
			})
		}
	</script>
</body>
</html>