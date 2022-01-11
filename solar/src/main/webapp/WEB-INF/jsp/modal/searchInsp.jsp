<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="inferGrid"></div>
</body>
<script>
var inferGrid = new tui.Grid({
    el: document.getElementById('inferGrid'),
    scrollX: true,
    scrollY: true,
    data: [],
    columns: [{
        header: '불량코드',
        name: 'cmmnCdDetaId'
      },
      {
        header: '불량명',
        name: 'cmmnCdNm'
      },
      {
        header: '불량량',
        name: 'rscInferQty',
        editor: 'text'
      }
    ]
  });
  
$.ajax({
    url: "../rsc/inspData",
    method: "GET",
    dataType: "JSON"
  }).done(function (result) {
	  console.log(result.insp);
    inferGrid.resetData(result.insp);
    inferGrid.refreshLayout();
  });
</script>
</html>