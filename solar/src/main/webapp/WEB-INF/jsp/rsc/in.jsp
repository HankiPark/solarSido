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
  <h1>자재 입고 조회</h1>
  <div id="coModal" title="업체 목록"></div>
  <div id="rscModal" title="자재 목록"></div>
  <form id="ordrQueryFrm" name="ordrQueryFrm">
    발주일: <input type="date" id="dtStt" name="dtStt">~<input type="date" id="dtEnd" name="dtEnd"><br>
    발주업체: <input type="text" id="co" name="co"><button type="button" id="coSearchBtn">🔍</button>
    자재: <input type="text" id="rsc" name="rsc"><button type="button" id="rscSearchBtn">🔍</button>
    <button type="button" id="ordrQueryBtn">조회</button>
  </form>
  <div id="grid"></div>
</body>

<script>
	let d = new Date();
	let nd = new Date(d.getFullYear(), d.getMonth(), d.getDate() - 7);
	document.getElementById('dtStt').value = nd.toISOString().slice(0, 10);
	document.getElementById('dtEnd').value = d.toISOString().slice(0, 10);

	let ordrDataSource = {
			  api: {
				    readData: { url: 'inData', method: 'GET'}
				  },
				  contentType : 'application/json',
				};
			
  var grid = new tui.Grid({
    el: document.getElementById('grid'),
    scrollX: false,
    scrollY: false,
    data: ordrDataSource,
    rowHeaders: ['checkbox'],
    sortable: true,
    columns: [{
        header: '입고일',
        name: 'rscDt'
      },
      {
        header: '자재명',
        name: 'rscNm'
      },
      {
        header: '자재코드',
        name: 'rscCd'
      },
      {
        header: '입고량',
        name: 'rscQty'
      },
      {
        header: '전표번호',
        name: 'rscSlipNo'
      },
      {
        header: 'LOT번호',
        name: 'rscLot'
      },
      {
        header: '금액',
        name: 'rscAmt'
      }
    ]
  });
  
  grid.on('response',function(ev){
	  console.log(ev.xhr)
      grid.refreshLayout();
    });

//

  let ordrQueryBtn = document.getElementById("ordrQueryBtn");
  ordrQueryBtn.addEventListener("click", function () {
    dtStt = document.ordrQueryFrm.dtStt.value;
    dtEnd = document.ordrQueryFrm.dtEnd.value;
    co = document.ordrQueryFrm.co.value;
    rsc = document.ordrQueryFrm.rsc.value;
	grid.readData(1,{
		'dtStt':dtStt,
		'dtEnd':dtEnd,
		'co':co,
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
    $("#coModal").load("../co");
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
    $("#rscModal").load("../rsc");
  });
</script>

</html>