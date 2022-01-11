<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="coGrid"></div>
</body>
<script>
var coGrid = new tui.Grid({
    el: document.getElementById('coGrid'),
    scrollX: false,
    scrollY: false,
    data: [],
    columns: [{
        header: '업체코드',
        name: 'coCd'
      },
      {
        header: '업체명',
        name: 'coNm'
      },
      {
        header: '업체구분',
        name: 'coFg'
      }
    ]
  });
  
$.ajax({
    url: "../co/coData",
    method: "GET",
    dataType: "JSON"
  }).done(function (result) {
	  console.log(result.co);
    coGrid.resetData(result.co);
    coGrid.refreshLayout();
  });
  
  coGrid.on('dblclick',function(ev){
	  document.ordrQueryFrm.co.value = coGrid.getValue(ev.rowKey, "coCd");
	  coDialog.dialog("close");
  });
</script>
</html>