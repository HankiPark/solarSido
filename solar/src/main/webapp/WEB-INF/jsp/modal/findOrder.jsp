<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="orderGrid"></div>
</body>

<script type="text/javascript">
	const orderGrid = new tui.Grid(
			{
				el : document.getElementById('orderGrid'),
				data : {
					api : {
						readData : {
							url : '${pageContext.request.contextPath}/grid/findOrder.do',
							method : 'GET',
						}
					},
					contentType : 'application/json'
				},
				bodyHeight : 500,
				columns : [ 
					{
					header : '주문번호',
					name : 'orderNo',
					}, 
					{
					header : '접수일자',
					name : 'recvDt',
					}, 
					{
					header : '업체코드',
					name : 'coCd'
					}, 
					{
					header : '진행정보',
					name : 'progInfo',
					}, 
					{
					header : '납기일자',
					name : 'paprdDt'
					}
				]
			});

	orderGrid.on('click', (ev) => {
		console.log(ev);
	})
	
	//그리드 내부 더블클릭
	orderGrid.on('dblclick', function(ev) {
		var orderNo = orderGrid.getValue(ev["rowKey"], "orderNo")
		console.log("orderNo:" + orderNo);
		var params = {
				'orderNo': orderNo
		}
		$.ajax({
			url : '${pageContext.request.contextPath}/grid/searchOrder.do',
			data : params,
			dataType:"json",
			contentType : 'application/json; charset=utf-8',
		}).done(function(pln) {
			console.log(pln.data)
			planDgrid.resetData(pln.data);
		}).fail(function(reject){
			console.log(reject);
		})
		prodPlanDialog.dialog("close");
	});
	
	orderGrid.on('onGridUpdated', function() {
		orderGrid.refreshLayout();
	});
</script>

</html>