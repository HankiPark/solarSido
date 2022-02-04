<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div>
	<div id="prcsEqmGrid" style="width: 900px"></div>
</div>

</body>

<script>

	prcsEqmDataSource = {
			api : {
				readData : {
					url : "${pageContext.request.contextPath}/modal/searchPrcsEqm/prcs",
					method : 'GET',	
				}
			}
	}

	prcsEqmGrid = new tui.Grid({
		el: document.getElementById('prcsEqmGrid'),
		data : prcsEqmDataSource,
		rowHeaders : ["rowNum"],	
		scrollX: false,
	    scrollY: true,
	    columns: [
	      {
		    header: '공정코드',
		    name: 'prcsCd'
		  },
	      {
	        header: '공정명',
	        name: 'prcsNm'
	      },
	      {
	        header: '공정설명',
	        name: 'prcsDesct', 
	      },
	    ]
	  });

	prcsEqmGrid.on('response',function(){
		prcsEqmGrid.refreshLayout();
	});
	
	prcsEqmGrid.on('dblclick', (ev)=>{
		var rk = ev.rowKey;
		
		var prcsNm = prcsEqmGrid.getValue(rk,"prcsNm");
		var prcsCd = prcsEqmGrid.getValue(rk,"prcsCd");
		//var eqmCd = prcsEqmGrid.getValue(rk,"eqmCd");
		var liNm = "1번 라인";
		
		if(prcsNm!=="null"){
			innPrcsEqm(prcsNm, prcsCd, liNm);
		}
		
		
		
	});



</script>




</html>