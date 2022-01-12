<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>
	<div id="indicaGrid" style="width: 900px"></div>
</body>
<script>
function callIndica(){

var indicaGrid = new tui.Grid({
    el: document.getElementById('indicaGrid'),
    
    scrollX: false,
    scrollY: true,
    data: [],
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

	/* const data ={
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/modal/searchIndicaDetail/indica',
					method : 'GET',
					data : { sDate : sDate}
				}
			},
			contentType : 'application/json'
	}
	
	indicaGrid.on("response", function(){
		
		indicaGrid.refreshLayout();
	}) */
}
 
$.ajax({
    url: "${pageContext.request.contextPath}/modal/searchIndicaDetail/indica",
    method: "GET",
    dataType: "JSON"
  }).done(function (result) {
	console.log(result);
	indicaGrid.resetData(result.contents);
    indicaGrid.refreshLayout();
  }); 
</script>