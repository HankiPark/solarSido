<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="indicaGrid"></div>
</body>

<script type="text/javascript">
function indicaList(){
	const indicaGrid = new tui.Grid(
			{
				el : document.getElementById('indicaGrid'),
				data : {
					api : {
						readData : {
							url : '${pageContext.request.contextPath}/grid/findIndica.do',
							method : 'GET',
						}
					},
					contentType : 'application/json'
				},
				bodyHeight : 500,
				columns : [ {
					header : '생산지시번호',
					name : 'indicaNo'
				}, {
					header : '지시일자',
					name : 'indicaDt'
				}, {
					header : '생산지시명',
					name : 'indicaNm'
				}]
			});

	indicaGrid.on('click', (ev) => {
		console.log(ev);
	})
	
	//그리드 내부 더블클릭
	indicaGrid.on('dblclick', function(ev) {
		$('#indicaNo').val(indicaGrid.getValue(ev["rowKey"], "indicaNo"));
		$('#indicaDt').val(indicaGrid.getValue(ev["rowKey"], "indicaDt"));
		$('#indicaNm').val(indicaGrid.getValue(ev["rowKey"], "indicaNm"));
		console.log("indicaDt:" + indicaDt + "&indicaNm:" + indicaNm);
		var indicaNo = indicaGrid.getValue(ev["rowKey"], "indicaNo")
		var params = {
				'indicaNo': indicaNo
		}
		$.ajax({
			url : '${pageContext.request.contextPath}/grid/searchIndica.do',
			data : params,
			dataType:"json",
			contentType : 'application/json; charset=utf-8',
		}).done(function(idc) {
			console.log(idc)
			console.log(idc.data)
			indicaDgrid.resetData(idc.data);
		}).fail(function(reject){
			console.log(reject);
		})
		indicaDialog.dialog("close");
	});
	
	indicaGrid.on('onGridUpdated', function() {
		indicaGrid.refreshLayout();
	});
}
</script>

</html>