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
	<button type="button" id="btnfindCo">검색</button>
	<div id="coGrid"></div>
	<button type="button" id="btnSelectCompleted">선택완료</button>
</body>
<script>
var Grid = tui.Grid;
Grid.setLanguage('ko');
var coGrid = new Grid({
    el: document.getElementById('coGrid'),
    scrollX: false,
    scrollY: false,
    data: [],
    rowHeaders: ['checkbox'],
    columns: [
        {
          header: '업체명',
          name: 'coNm',
			align : 'center'
        },
  	  {
          header: '업체코드',
          name: 'coCd',
			align : 'center'
        },
        {
          header: '사업자등록번호',
          name: 'bizno',
			align : 'center'
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
		    url: "${pageContext.request.contextPath}/grid/co/coData?coNm="+coNm+"&coCd="+coCd,
		    method: "GET",
		    dataType: "JSON"
		  }).done(function (result) {
		    coGrid.resetData(result.co);
		    coGrid.refreshLayout();
		  });
  }
  request();
  
  var btnSelectCompleted = document.getElementById('btnSelectCompleted');
  btnSelectCompleted.addEventListener('click',function(){
	  let checkedRowKeys = coGrid.getCheckedRowKeys();
	  let coCds = '';
	  for(checkedRowKey of checkedRowKeys){
		  coCds += ","+coGrid.getValue(checkedRowKey, 'coCd');
	  }
	  coCds = coCds.substr(1);
	  let coCdsInput = document.getElementById("coCds");
	  coCdsInput.value = coCds;
	  //coDialog.dialog("close");
	  coDialog2.dialog("close");
  });
  
</script>
</html>