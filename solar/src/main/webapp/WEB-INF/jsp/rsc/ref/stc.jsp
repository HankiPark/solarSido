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
 <div class="row" id="senseStc">
		<div  id="senseStcBody"  class="card card-pricing card-primary card-white card-outline col-3" style="margin-left: 50px;margin-right: 30px;margin-top: 150px;padding-left: 40px;margin-bottom: 300px; height:350px">
		<div class="card-body" >
  <form id="ordrQueryFrm" name="ordrQueryFrm">
    <div style="margin-top: 60px; margin-bottom: 30px;"><label>자재코드</label> <input type="text" id="rsc" name="rsc"><button type="button" id="rscSearchBtn">🔍</button></div>
    
  </form>
  </div>
  	<div class="card-footer" style="margin-bottom: 30px;" >
  <button type="button" id="ordrQueryBtn" style="margin-left:120px">조회</button>
  </div>
  </div>
  <div id="grid" class="col-8" style=" margin-top:100px;"></div>
</body>

<script>
	let ordrDataSource = {
			  api: {
				    readData: { url: '${pageContext.request.contextPath}/grid/rsc/stcData', method: 'GET'}
				  },
				  contentType : 'application/json',
				};
			
	var Grid = tui.Grid;
	Grid.setLanguage('ko');
	
  var grid = new Grid({
    el: document.getElementById('grid'),
    scrollX: false,
    scrollY: false,
    data: ordrDataSource,
    pageOptions : {
		useClient : true,
		perPage : 12
	},
	bodyHeight: 480,
    columns: [
      {
        header: '자재명',
        name: 'rscNm',
        width: 220,
        sortable: true,
        align: 'center',
      },
      {
        header: '자재코드',
        name: 'rscCd',
        sortable: true,
        align: 'center',
      },
      {
        header: '재고',
        name: 'rscStc',
        sortable: true,
        align: 'center',
      },
      {
        header: '안전재고',
        name: 'safStc',
        sortable: true,
        align: 'center',
      },
      {
        header: '규격',
        name: 'rscSpec',
        align: 'center',
      },
      {
        header: '관리단위',
        name: 'rscUnit',
        align: 'center',
      },
      {
        header: '단가',
        name: 'rscUntprc',
        sortable: true,
        align: 'center',
      }
    ]
  });
  
  grid.on('response',function(ev){
      grid.refreshLayout();
    });
  
  grid.on('onGridUpdated',function(){
	  rowColor();
  });

  
  function rowColor(){
	  let rowCnt = grid.getRowCount();
	  for(let i = 0; i<rowCnt-1; i++){
		  let rscStc = grid.getValue(i, 'rscStc');
		  let safStc = grid.getValue(i, 'safStc');
		  if(parseInt(rscStc)<parseInt(safStc)){
			  console.log(i, parseInt(rscStc), parseInt(safStc));
			  $('td[data-row-key="'+i+'"][data-column-name="rscStc"]').css('backgroundColor','#f7dad5');
		  }
	  }
  }
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
	width : 1000,
	height : 600
  });

  $("#rscSearchBtn").on("click", function () {
    rscDialog.dialog("open");
    $("#rscModal").load("${pageContext.request.contextPath}/modal/rsc");
  });
	$('#senseStc').resize(function(){
		if($('#senseStc').width()<1780){
			$('#senseStcBody').css('paddingLeft','15px');
		}else{
			$('#senseStcBody').css('paddingLeft','40px');
		}
	})
	
	document.addEventListener('click',function(ev){
		if(ev.target.className.includes('tui-page-btn'))
			rowColor();
	});
	
</script>

</html>