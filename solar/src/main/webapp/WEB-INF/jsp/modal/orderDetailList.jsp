<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

</head>
<body>

<div id="gridD"></div>
<script type="text/javascript">


		function newgrid(odno){
			let dataSourceD={
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/grid/orderDetailList.do',
					method : 'GET',
					initParams: { orderNo: odno }
				}
			},

			contentType : 'application/json'
		};
			const gridD = new tui.Grid({
				el : document.getElementById('gridD'), // 컨테이너 엘리먼트
				data : dataSourceD,
				bodyHeight : 400,
				columns : [ 
					{
					header : '제품코드',
					name : 'prdtCd',
					width : 130,
					align : 'center'
				}, {
					header : '제품명',
					name : 'prdtNm',
					align : 'center'
				}, {
					header : '주문량',
					name : 'orderQty',
					width : 100,
					align : 'center'
					
				}, {
					header : '지시량',
					name : 'indicaQty',
					width : 100,
					align : 'center'
				}, {
					header : '출고량',
					name : 'oustQty',
					width : 100,
					align : 'center'
				}, {
					header : '현재고',
					name : 'prdtStc',
					width : 100,
					align : 'center'
				},

				],

			});
			
			gridD.on('onGridUpdated', function() {
				gridD.refreshLayout();
			});
		}
	</script>
</body>
</html>