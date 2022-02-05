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
function planDList(){
	$(function(){
	      $("div:contains('planModal') button:contains('확인')").on('click',function(ev){
	         indicaDgrid.appendRows(planDgrid.getCheckedRows(ev));
	         indicaDgrid.refreshLayout();
	         $.ajax({
	            url:'${pageContext.request.contextPath}/ajax/makeDno.do',
	            dataType: 'json',
	            contentType: 'application/json; charset=utf-8',
	            async: false,
	         }).done((res)=>{
	            console.log(res.num2)
	            let idx = 0;
	            for(i=0; i<indicaDgrid.getRowCount(); i++){
	               if ( indicaDgrid.getValue (i, 'indicaNo') !=null ){
	                  console.log(idx)
	               } else {
	                  indicaDgrid.setValue(i, 'indicaDetaNo', Number(res.num2)+1*idx)
	                  idx = Number(idx) +1
	               }
	            }
	         })
	      });
	   })
	   
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
			    //hidden: true
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
			    hidden: true
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