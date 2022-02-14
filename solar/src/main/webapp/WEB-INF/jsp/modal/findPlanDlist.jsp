<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="planDgrid"></div>
</body>

<script type="text/javascript">
var planDgrid;
function planDList(){
	//미지시 생산계획 상세 그리드
	planDgrid = new tui.Grid({
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
				align : 'center'
			  },
		 	 {
			    header: '계획명',
			    name: 'planNm',
			    //hidden: true,
				align : 'center'
			  },
			  {
			    header: '계획일자',
			    name: 'planDt',
			    hidden: true,
				align : 'center'
			  },
			  {
			    header: '계획상세번호',
			    name: 'planDetaNo',
			    hidden: true,
				align : 'center'
			  },
			 
			  { 
			    header: '주문번호',
			    name: 'orderNo',
			    hidden: true,
				align : 'center'
			  },
			  { header: '접수일자',
			    name: 'recvDt',
			   	hidden: true,
				align : 'center'
			  },
			  {
			    header: '제품코드',
			    name: 'prdtCd',
			    sortingType: 'desc',
		        sortable: true,
				align : 'center'
			  },		  
			  {
			    header: '제품명',
			    name: 'prdtNm',
				align : 'center'
			  },
			  {
			    header: '납기일자',
			    name: 'paprdDt',
				align : 'center'
			  },
			  {
			    header: '주문량',
			    name: 'orderQty',
				align : 'center'
			  },
			 {
			    header: '작업량',
			    name: 'planQty',
			    hidden: true,
				align : 'center'
			  },
			  {
			    header: '생산일수',
			    name: 'prodDay',
			    hidden: true,
				align : 'center'
			  },
			  {
			    header: '작업일자',
			    name: 'wkDt',
				align : 'center'
			  },
			  {
			    header: '작업순서',
			    name: 'wkOrd',
			    hidden: true,
				align : 'center'
			  }
	 		 ]
	});	
	
	let list;
	//선택버튼 : 체크된 계획 가져오기
	planDgrid.on('check', (ev) => {
		let pick = planDgrid.getValue(ev["rowKey"], "prdtCd")
		console.log(pick);
		for ( i=0; i<planDgrid.getRowCount(); i++){
			if(planDgrid.getValue(i, "prdtCd") != pick) {
				planDgrid.disableRow(i, true);
			} 
		}
		indicaDgrid.resetData([]);
		//indicaDgrid.resetData(planDgrid.getCheckedRows());
		//indicaDgrid.appendRows(planDgrid.getCheckedRows(ev));
	});
	
	planDgrid.on('uncheck', (ev) => {
		console.log(ev);
		let unpick = planDgrid.getValue(ev["rowKey"], "prdtCd")
		console.log(planDgrid.getCheckedRows())
		for ( i=0; i<planDgrid.getRowCount(); i++){
			if(planDgrid.getValue(i, "prdtCd") != unpick) {
				planDgrid.enableRow(i, true);
			} 
		}
		indicaDgrid.removeRow(ev.rowKey);
	});
	
	planDgrid.on('onGridUpdated', (ev) => {
		indicaDgrid.refreshLayout();
		planDgrid.refreshLayout();
	});
}
	</script>
</html>