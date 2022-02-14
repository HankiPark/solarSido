<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<!-- 생산지시 전체 기간별 조회 그리드 -->
	<div id="indicaListGrid2">

	</div>

</body>

<script type="text/javascript">
window.onload = function(){
}

function endList2(){
	//생산지시 상세 그리드
	const indicaListGrid2 = new tui.Grid({
		el: document.getElementById('indicaListGrid2'),
		data: {
			  api: {
			    	readData: { url: '${pageContext.request.contextPath}/grid/indicaGrid2', 
						    	method: 'GET'
			    				},
					}, 
				contentType: 'application/json'
			},
		scrollX: false,
		scrollY: true,
		bodyHeight: 300,
		columns: [
					
					  {
					    header: '지시번호',
					    name: 'indicaNo',
					    align: 'center',
					  },
					  {
					    header: '제품코드',
					    name: 'prdtCd',  
					    align: 'center',
					  },		  
					  {
					    header: '제품명',
					    name: 'prdtNm',
				    	align: 'center'
					  },
					  {
					    header: '지시량',
					    name: 'indicaQty',
					    align: 'center'
					  },
					  {
					    header: '작업일자',
					    name: 'wkDt',
					    align: 'center',
					  }
			 		 ],

			});
		indicaListGrid2.on('onGridUpdated', function() {
			indicaListGrid2.refreshLayout();
		});

		
		indicaListGrid2.on('dblclick',function(ev){
			$("#indica").val(indicaListGrid2.getValue(ev["rowKey"],"indicaNo"));
			grid.readData(1,{'indicaNo' :indicaListGrid2.getValue(ev["rowKey"],"indicaNo")},true);
			dialog.dialog("close");
			
		})
		
		
}
</script>
</html>