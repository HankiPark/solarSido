<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
</head>


<body>
  <h1>자재 재고 조회</h1>
  <div id="coModal" title="업체 목록"></div>
  <div id="rscModal" title="자재 목록"></div>
   <div class="card card-pricing card-primary card-white">
		<div class="card-body" >
  <form id="ordrQueryFrm" name="ordrQueryFrm">
    <div><label>자재:</label> <input type="text" id="rsc" name="rsc"><button type="button" id="rscSearchBtn">🔍</button></div>
    <button type="button" id="ordrQueryBtn" style="margin-left:-10px">조회</button>
  </form>
  </div>
  </div>
  <div id="grid"></div>
</body>

<script>
	let ordrDataSource = {
			  api: {
				    readData: { url: '${pageContext.request.contextPath}/grid/rsc/stcData', method: 'GET'}
				  },
				  contentType : 'application/json',
				};
			
  var grid = new tui.Grid({
    el: document.getElementById('grid'),
    scrollX: false,
    scrollY: false,
    data: ordrDataSource,
    sortable: true,
    columns: [
      {
        header: '자재명',
        name: 'rscNm',
        width: 220,
      },
      {
        header: '자재코드',
        name: 'rscCd'
      },
      {
        header: '재고',
        name: 'rscStc'
      },
      {
        header: '안전재고',
        name: 'safStc'
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
  
  grid.on('response',function(ev){
      grid.refreshLayout();
    });
  
  grid.on('onGridUpdated',function(){
	  let rowCnt = grid.getRowCount();
	  
	  for(let i = 0; i<rowCnt; i++){
		  let rscStc = grid.getValue(i, 'rscStc');
		  let safStc = grid.getValue(i, 'safStc');
		  if(parseInt(rscStc)<parseInt(safStc)){
			  grid.setValue(i,'rscStc',"<font color='red' size='4'>"+rscStc+"</font>");
		  }
	  }
  });

//

  let ordrQueryBtn = document.getElementById("ordrQueryBtn");
  ordrQueryBtn.addEventListener("click", function () {
    rsc = document.ordrQueryFrm.rsc.value;
	grid.readData(1,{
		'rsc':rsc
	});
  });

//

  let coDialog = $("#coModal").dialog({
    modal: true,
    autoOpen: false,
	width : 600,
	height : 600
  });

  $("#coSearchBtn").on("click", function () {
    coDialog.dialog("open");
    $("#coModal").load("${pageContext.request.contextPath}/modal/co");
  });

//

  let rscDialog = $("#rscModal").dialog({
    modal: true,
    autoOpen: false,
	width : 600,
	height : 600
  });

  $("#rscSearchBtn").on("click", function () {
    rscDialog.dialog("open");
    $("#rscModal").load("${pageContext.request.contextPath}/modal/rsc");
  });
</script>

</html>