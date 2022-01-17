<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="gridEnd"></div>
<script type="text/javascript">


		function outEndList(){
			let dataSourceD={
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/grid/outEndList.do',
					method : 'GET',
					initParams: { indicaDetaNo : outGrid2.getValue(rowKeyNm,"slipDetaNo"),
									prdtCd : outGrid2.getValue(rowKeyNm,"prdtCd"),
									prdtNm : outGrid2.getValue(rowKeyNm,"prdtNm"),		
							
					}
				}
				
			},

			contentType : 'application/json'
		};
			console.log(outGrid2.getValue(rowKeyNm,"slipDetaNo"));
			console.log(outGrid2.getValue(rowKeyNm,"prdtCd"));
			const gridEnd = new tui.Grid({
				el : document.getElementById('gridEnd'), // 컨테이너 엘리먼트
				data : dataSourceD,
				bodyHeight : 500,
				rowHeaders : [ {
					type : 'rowNum',
					width : 100,
					align : 'left',
					valign : 'bottom'
				}],
				columns : [ 
					{
						header : '제품LOT',
						name : 'prdtLot'
				}, {
					header : '제품코드',
					name : 'prdtCd',
				}, {
					header : '제품명',
					name : 'prdtNm',
				},{
					header : '전표임시상세',
					name : 'indicaDetaNo',
					hidden : true
				},
				
				],

			});
			
			gridEnd.on('onGridUpdated', function() {
				gridEnd.refreshLayout();
			});
			
			

		}
	</script>
</body>
</html>