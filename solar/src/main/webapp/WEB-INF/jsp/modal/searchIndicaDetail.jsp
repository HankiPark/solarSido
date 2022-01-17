<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html></html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>
<div>
	<form id="prscIndicaSearch" name="prscIndicaSearch">
	지시일 검색<input type="date" id="sDate" name="sDate">
	<button type="button" id="sDateSearchBtn">돋</button><br />
	</form>
	<div id="indicaGrid" style="width: 900px"></div>
</div>
</body>
<script>
	
	sDate = document.getElementById('sDate').value;
	sDate = new Date().toISOString().substring(0,10);
	document.getElementById('sDate').value = new Date().toISOString().substring(0,10);
	

	indicaDataSource = {
			api: {
				readData : {
					url : "${pageContext.request.contextPath}/modal/searchIndicaDetail/indica",
					method : 'GET',
					initParams: { sDate: sDate}
				}
			}
	}
	

	indicaGrid = new tui.Grid({
	    el: document.getElementById('indicaGrid'),
	    data : indicaDataSource,
	    scrollX: false,
	    scrollY: true,
	    columns: [{
	        header: '생산지시번호',
	        name: 'indicaNo'
	      },
	      {
	        header: '생산지시상세번호',
	        name: 'indicaDetaNo'
	      },
	      {
	        header: '생산지시명',
	        name: 'indicaNm', 
	      },
	      {
	        header: '제품코드',
	        name: 'prdtCd', 
	      },
	      {
	        header: '생산구분',
	        name: 'prodFg', 
	      },
	      {
	        header: '지시량',
	        name: 'indicaQty',
	      },
	      {
	        header: '작업순서',
	        name: 'wkOrd', 
	      },
	      {
	        header: '작업일자',
	        name: 'wkDt', 
	      },    
	    ]
	  });
	 
/* 	$.ajax({
	    url: "${pageContext.request.contextPath}/modal/searchIndicaDetail/indica",
	    method: "GET",
	    dataType: "JSON"
	  }).done(function (result) {
		console.log(result);
		indicaGrid.resetData(result.data.contents);
		indicaGrid.refreshLayout();
	  }); */
 
	indicaGrid.on('response',function(){
		indicaGrid.refreshLayout();
	});
	  
	indicaGrid.on('dblclick', (ev)=>{
		
		var rk = ev.rowKey; 
		console.log(rk);
		console.log(indicaGrid.getValue(rk,"indicaDetaNo"));
		
		var indicaNo = indicaGrid.getValue(rk,"indicaNo");
		var indicaDetaNo = indicaGrid.getValue(rk,"indicaDetaNo");
		var prdtNm = indicaGrid.getValue(rk,"prdtNm");
		
		
		var inddd = indicaNo + "-" + indicaDetaNo;
		var prd = indicaGrid.getValue(rk,"prdtCd");
		var prdNm = indicaGrid.getValue(rk,"prdtNm");
		
		console.log(inddd);
		console.log(prd);
		console.log(prdNm);
		
		// 더블클릭하여 선택된 row의 지시번호가 null이 아닐때 공정페이지에 정보넘어가면서 이벤트발생
		if(inddd!=="null-null"){
			innIndica(inddd, prd, indicaDetaNo);
		}
		
	});

	sDateSearchBtn = document.getElementById("sDateSearchBtn");
	sDateSearchBtn.addEventListener("click", function(){
		
		sDate = document.getElementById('sDate').value;
		console.log(sDate);
		
 		var readParams = {
				'sDate':sDate
		}
		
		indicaGrid.readData(1,readParams,true);
		indicaGrid.refreshLayout();
		 
	});
	

	
</script>