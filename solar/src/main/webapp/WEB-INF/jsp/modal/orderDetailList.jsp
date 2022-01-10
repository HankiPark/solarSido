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

const dataSourceD = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/grid/orderDetailList.do',
					method : 'GET',
					initParams: { orderNo: 'on20220108001' },
					cache : false
				}
			},

			contentType : 'application/json'
		};

		const gridD = new tui.Grid({
			el : document.getElementById('gridD'), // 컨테이너 엘리먼트
			data : dataSourceD,
			columns : [ 
				{
				header : '제품코드',
				name : 'prdtCd',
			}, {
				header : '제품명',
				name : 'prdtNm'
			}, {
				header : '주문량',
				name : 'orderQty',
				
			}, {
				header : '지시량',
				name : 'indicaQty'
			}, {
				header : '출고량',
				name : 'oustQty'
			}, {
				header : '현재고',
				name : 'prdtStc'
			},

			],

		});
		gridD.on('onGridUpdated', function() {
			gridD.refreshLayout();
		});

	</script>
</body>
</html>