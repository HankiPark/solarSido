<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="rscGrid"></div>
</body>
<script>
var rscGrid = new tui.Grid({
    el: document.getElementById('rscGrid'),
    scrollX: true,
    scrollY: true,
    data: [],
    columns: [{
        header: '자재코드',
        name: 'rscCd'
      },
      {
        header: '자재명',
        name: 'rscNm'
      },
      {
        header: '업체코드',
        name: 'coCd'
      },
      {
		header: '규격',
		name: 'rscSpec'
      },
      {
		header: '관리단위',
		name: 'rscUnit'
      },
      {
  		header: '단가',
  		name: 'rscUntPrc'
      }
    ]
  });
  
$.ajax({
    url: "../rsc/rscData",
    method: "GET",
    dataType: "JSON"
  }).done(function (result) {
	  console.log(result.rsc);
    rscGrid.resetData(result.rsc);
    rscGrid.refreshLayout();
  });
  
  rscGrid.on('dblclick',function(ev){
	  document.ordrQueryFrm.rsc.value = rscGrid.getValue(ev.rowKey, "rscCd");
	  rscDialog.dialog("close");
  });
</script>
</html>