<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="planDgrid">
</body>

<script type="text/javascript">
function planDList(){

	//미지시 생산계획 상세 그리드
	let planDgrid = new tui.Grid({
		el: document.getElementById('planDgrid'),
		data: {
			api: {
				readData: { 
					url: '${pageContext.request.contextPath}/grid/noIndicaGrid.do', 
					method: 'GET'
					}
				},
			contentType: 'application/json'
		}, 
		scrollX: false,
		scrollY: true,
		bodyHeight: 250,
		rowHeaders: [{
			type: 'checkbox',
			width: 40}],
		columns: [
			 {
			    header: '계획번호',
			    name: 'planNo',
			  },
		 	 {
			    header: '계획명',
			    name: 'planNm',
			    hidden: true
			  },
			  {
			    header: '계획일자',
			    name: 'planDt',
			    hidden: true
			  },
			  {
			    header: '계획상세번호',
			    name: 'planDetaNo',
			    hidden: true
			  },
			 
			  { 
			    header: '주문번호',
			    name: 'orderNo',
			  },
			  { header: '접수일자',
			    name: 'recvDt',
			   	hidden: true
			  },
			  {
			    header: '제품코드',
			    name: 'prdtCd',
			    sortingType: 'desc',
		        sortable: true
			  },		  
			  {
			    header: '제품명',
			    name: 'prdtNm'
			  },
			  {
			    header: '납기일자',
			    name: 'paprdDt',
			  },
			  {
			    header: '주문량',
			    name: 'orderQty',
			  },
			 {
			    header: '작업량',
			    name: 'planQty',
			    hidden: true
			  },
			  {
			    header: '생산일수',
			    name: 'prodDay',
			    hidden: true
			  },
			  {
			    header: '작업일자',
			    name: 'wkDt',
			  },
			  {
			    header: '작업순서',
			    name: 'wkOrd'
			  }
	 		 ]
	});	
	
	//선택버튼 : 체크된 계획 가져오기
	planDgrid.on('check', (ev) => {
		console.log(ev);
		console.log(planDgrid.getCheckedRows());
		let chkPlan = planDgrid.getCheckedRows()
	});
	
}
	</script>
</html>