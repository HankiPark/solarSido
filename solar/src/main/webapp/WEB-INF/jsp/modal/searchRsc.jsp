<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<label>자재명</label>
	<input type="text" id="rscNm">
	<label>업체명</label>
	<input type="text" id="coNm">
	<button type="button" id="btnfindCo">조회</button>
	<div id="rscGrid"></div>
</body>
<script>
var evVar;
var Grid = tui.Grid;
Grid.setLanguage('ko');
var rscGrid = new Grid({
    el: document.getElementById('rscGrid'),
    scrollX: true,
    scrollY: true,
    data: [],
    columns: [{
        header: '자재코드',
        name: 'rscCd',
      },
      {
        header: '자재명',
        name: 'rscNm',
        width: 200
      },
      {
        header: '업체명',
        name: 'coNm'
      },
      {
        header: '업체코드',
        name: 'coCd',
      },
      {
		header: '규격',
		name: 'rscSpec'
      },
      {
		header: '관리단위',
		name: 'rscUnit',
      },
      {
  		header: '단가',
  		name: 'rscUntprc'
      }
    ]
  });
  
	var btnfindCo = document.getElementById("btnfindCo");
	btnfindCo.addEventListener('click',function(){
		  let coNm = document.getElementById('coNm').value;
		  let rscNm = document.getElementById('rscNm').value;
		  request(coNm, rscNm);
	});
	
	function request(coNm='', rscNm=''){
		  $.ajax({
			    url: "${pageContext.request.contextPath}/grid/rsc/rscData?coNm="+coNm+"&rscNm="+rscNm,
			    method: "GET",
			    dataType: "JSON"
			  }).done(function (result) {
			    rscGrid.resetData(result.rsc);
			    rscGrid.refreshLayout();
			  });
	}
	request();
  
  rscGrid.on('dblclick',function(ev){
	  if(evVar != undefined){
		  grid.setValue(evVar.rowKey,'rscNm',rscGrid.getValue(ev.rowKey,'rscNm'));
		  grid.setValue(evVar.rowKey,'rscCd',rscGrid.getValue(ev.rowKey,'rscCd'));
		  grid.setValue(evVar.rowKey,'coNm',rscGrid.getValue(ev.rowKey,'coNm'));
		  evVar = undefined;
	  }else{
		  document.ordrQueryFrm.rsc.value = rscGrid.getValue(ev.rowKey, "rscCd");
	  }
	  rscDialog.dialog("close");
	  
  });
</script>
</html>