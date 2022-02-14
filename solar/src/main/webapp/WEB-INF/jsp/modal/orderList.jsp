<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div id="gridOrd"></div>
<script type="text/javascript">



function ordList(ordNo){
	//미니 그리드(주문명단) 재고가있고 그 재고를 요구하는 주문번호만 출력
	const gridOrd = new tui.Grid({
		el : document.getElementById('gridOrd'), // 컨테이너 엘리먼트
		data : {api : {
			readData : {
				url : '${pageContext.request.contextPath}/grid/outOrderList.do',
				method : 'GET'
			}
			
		},
		contentType : 'application/json'
	},
		bodyHeight : 500,
		columns : [ 
			{
			header : '주문번호',
			name : 'orderNo',
			align : 'center'
		}, {
			header : '접수일자',
			name : 'recvDt',
			align : 'center'
		}, {
			header : '회사코드',
			name : 'coCd',
			align : 'center'
			
		}, {
			header : '회사명',
			name : 'coNm',
			align : 'center'
			
		}, {
			header : '납기일자',
			name : 'paprdDt',
			align : 'center'
		}
		],

	});
	
	//그리드 내부 더블클릭시
	gridOrd
	.on(
			'dblclick',
			function(ev) {
				
				for(let i = outGrid.getRowCount()-1 ; i>0;i--){
					if(outGrid.getValue(i,"orderNo")==ordNo && ordNo!=""){
						outGrid.removeRow(i);
					}
				}
				
				$.ajax({
					url: "${pageContext.request.contextPath}/ajax/prdList.do",
					data : {'orderNo' : gridOrd.getValue(ev["rowKey"],"orderNo")},
					method:"get",
					dataType : "json",
					contentType : 'application/json; charset=utf-8',
				}).done((li)=>{
					for(let i =0 ; i<li["data"]["contents"].length;i++){
						if(i==0){
							
						 	outGrid.setValue(rowKeyNm+i,"orderNo",gridOrd.getValue(ev["rowKey"],"orderNo"));
							outGrid.setValue(rowKeyNm+i,"coNm",gridOrd.getValue(ev["rowKey"],"coNm"));
							outGrid.setValue(rowKeyNm+i,"prdtCd",li["data"]["contents"][i].prdtCd); 
							outGrid.setValue(rowKeyNm+i,"prdtNm",li["data"]["contents"][i].prdtNm); 
							outGrid.setValue(rowKeyNm+i,"orderQty",li["data"]["contents"][i].orderQty); 
							outGrid.setValue(rowKeyNm+i,"prdtStc",li["data"]["contents"][i].prdtStc); 
							outGrid.setValue(rowKeyNm+i,"prdtAmt",li["data"]["contents"][i].prdtAmt); 
							outGrid.setValue(rowKeyNm+i,"restQty",li["data"]["contents"][i].restQty); 
						}else{
							outGrid.appendRow({'slipNo':$("#slipNm").val(),'slipDetaNo':tempNo++,'prdtDt':d.toISOString().slice(0, 10)}, {
								extendPrevRowSpan : true,
								focus : true,
								at : 0
							});
							outGrid.setValue(rowKeyNm+i,"orderNo",gridOrd.getValue(ev["rowKey"],"orderNo"));
							outGrid.setValue(rowKeyNm+i,"coNm",gridOrd.getValue(ev["rowKey"],"coNm"));
							outGrid.setValue(rowKeyNm+i,"prdtCd",li["data"]["contents"][i].prdtCd); 
							outGrid.setValue(rowKeyNm+i,"prdtNm",li["data"]["contents"][i].prdtNm); 
							outGrid.setValue(rowKeyNm+i,"orderQty",li["data"]["contents"][i].orderQty); 
							outGrid.setValue(rowKeyNm+i,"prdtStc",li["data"]["contents"][i].prdtStc); 
							outGrid.setValue(rowKeyNm+i,"prdtAmt",li["data"]["contents"][i].prdtAmt); 
							outGrid.setValue(rowKeyNm+i,"restQty",li["data"]["contents"][i].restQty); 
						}
					}
					for(let i = outGrid.getRowCount()-1 ; i>0;i--){
						if(outGrid.getValue(i,"orderNo")==""){
							outGrid.removeRow(i);
						}
					}
					if(ev["rowKey"]!=null){
						dialog4.dialog("close"); 
					}
				})
		/* 		outGrid.getValue()
	 			$('#coNm').val(gridCo.getValue(ev["rowKey"], "coNm"));
				dialog4.dialog("close");  */
			
			});
	
	
	
	
	
	
	gridOrd.on('onGridUpdated', function() {
		gridOrd.refreshLayout();
	});
}
	</script>
</body>
</html>