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

	indicaGrid = new tui.Grid({
    el: document.getElementById('indicaGrid'),
    
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

	function getSelectedRows(){
		 
        var a = $(".tui-grid-table").find('.tui-grid-cell-selected');
        var c = []; 
        $.each(a, function(index, item){
            var b = Number($(item).data('row-key')); 
             
            var z = grid.getValue(b,'idx'); 

            var d = {'idx': z}; 
            c.push(d);  
        }); 
         
        if(c) return c;
        else return null;
     }
	
 
$.ajax({
    url: "${pageContext.request.contextPath}/modal/searchIndicaDetail/indica",
    method: "GET",
    dataType: "JSON"
  }).done(function (result) {
	console.log(result);
	indicaGrid.resetData(result.data.contents);
	indicaGrid.refreshLayout();
  });
 
indicaGrid.on('dblclick', (ev)=>{
	
	var rk = ev.rowKey; 
	console.log(rk);
	console.log(indicaGrid.getValue(rk,"indicaDetaNo"));
	
	
	
})
	

	
</script>