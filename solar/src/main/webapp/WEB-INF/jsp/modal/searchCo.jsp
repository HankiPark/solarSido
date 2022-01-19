<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<label>업체명</label>
	<input type="text" id="coNm">
	<label>업체코드</label>
	<input type="text" id="coCd">
	<button type="button" id="btnfindCo">조회</button>
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
        header: '사업자등록번호',
        name: 'bizno'
      }
    ]
  });
  
  
  var btnfindCo = document.getElementById("btnfindCo");
  btnfindCo.addEventListener('click',function(){
	  let coNm = document.getElementById('coNm').value;
	  let coCd = document.getElementById('coCd').value;
	  request(coNm, coCd);
  });

  function request(coNm='', coCd=''){
	  $.ajax({
		    url: "../co/coData?coNm="+coNm+"&coCd="+coCd,
		    method: "GET",
		    dataType: "JSON"
		  }).done(function (result) {
			  console.log(result.co);
		    coGrid.resetData(result.co);
		    coGrid.refreshLayout();
		  });
  }
  request();
  coGrid.on('dblclick',function(ev){
	  document.ordrQueryFrm.co.value = coGrid.getValue(ev.rowKey, "coCd");
	  coDialog.dialog("close");
  });
</script>
</html>