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
	<label>자재코드</label>
	<input type="text" id="rscCd">
	<button type="button" id="btnfindCo">조회</button>
	<div id="rscGrid"></div>
</body>
<script>
var evVar;
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
        header: '업체명',
        name: 'coNm'
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
  		name: 'rscUntprc'
      }
    ]
  });
  
	var btnfindCo = document.getElementById("btnfindCo");
	btnfindCo.addEventListener('click',function(){
		  let coNm = document.getElementById('coNm').value;
		  let rscCd = document.getElementById('rscCd').value;
		  request(coNm, rscCd);
	});
	
	function request(coNm='', rscCd=''){
		  $.ajax({
			    url: "../rsc/rscData?coNm="+coNm+"&rscCd="+rscCd,
			    method: "GET",
			    dataType: "JSON"
			  }).done(function (result) {
				  console.log(result.rsc);
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