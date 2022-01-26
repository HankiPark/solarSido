<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="prodPlanGrid"></div>
</body>

<script type="text/javascript">
function planList(){
	const prodPlanGrid = new tui.Grid(
			{
				el : document.getElementById('prodPlanGrid'),
				data : {
					api : {
						readData : {
							url : '${pageContext.request.contextPath}/grid/findProdPlan.do',
							method : 'GET',
							initParams : { 
								startT: 'startT',
								endT: 'endT'
							}
						}
					},
					contentType : 'application/json'
				},
				bodyHeight : 500,
				columns : [ {
					header : '생산계획번호',
					name : 'planNo'
				}, {
					header : '계획일자',
					name : 'planDt'
				}, {
					header : '생산계획명',
					name : 'planNm'
				}]
			});
	
	//그리드 내부 더블클릭
	prodPlanGrid.on('dblclick', function(ev) {
		
		$('#planNo').val(prodPlanGrid.getValue(ev["rowKey"], "planNo"));
 		$('#planDt').val(prodPlanGrid.getValue(ev["rowKey"], "planDt"));
		$('#planNm').val(prodPlanGrid.getValue(ev["rowKey"], "planNm")); 
		$('#selPlanNo').val(prodPlanGrid.getValue(ev["rowKey"], "planNo")); 
		
		var planNo = prodPlanGrid.getValue(ev["rowKey"], "planNo")
		var params = {
				'planNo': planNo
		}
		$.ajax({
			url : '${pageContext.request.contextPath}/grid/searchPlan.do',
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
	
	prodPlanGrid.on('onGridUpdated', function() {
		prodPlanGrid.refreshLayout();
	});
}
</script>

</html>