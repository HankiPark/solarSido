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
	<h1>자재검수</h1>
	<div id="coModal" title="업체 목록">Loading..</div>
	<div id="rscModal" title="자재 목록">Loading..</div>
	<div id="inspModal" title="검수">Loading..</div>
		<form id="ordrQueryFrm" name="ordrQueryFrm">
			발주일: <input type="date" id="ordrDtStt" name="ordrDtStt">~<input type="date" id="ordrDtEnd" name="ordrDtEnd">
			미검수 자재만 표시<input type="checkbox" id="isNotInspected" name="isNotInspected">
			<br>
			발주업체: <input type="text" id="co" name="co"><button type="button" id="coSearchBtn">ㅇ-</button>
			자재: <input type="text" id="rsc" name="rsc"><button type="button" id="rscSearchBtn">ㅇ-</button>
			<input type="hidden" id="sum" name="sum">
			<input type="hidden" id="curRowKey" name="curRowKey">
			<input type="hidden" id="curColumnName" name="curColumnName">
			<button type="button" id="ordrQueryBtn">조회</button>
			<button type="button" id="inspSaveBtn">저장</button>
		</form>
	<div id="grid"></div>
</body>

<script>
  //그리드
  var grid = new tui.Grid({
    el: document.getElementById('grid'),
    scrollX: false,
    scrollY: false,
    data: [],
    columns: [{
        header: '발주일',
        name: 'ordrDt'
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
        header: '발주량',
        name: 'ordrQty'
      },
      {
        header: '입고량',
        name: 'rscIstQty'
      },
      {
        header: '불량량',
        name: 'rscInferQty'
      },
      {
        header: '발주번호',
        name: 'ordrCd'
      },
      {
        header: '업체',
        name: 'coNm'
      },
      {
        header: '검수여부',
        name: 'inspCls'
      }
    ]
  });

	$.ajax({
		url: "ordrData",
		method: "GET",
		dataType: "JSON"
	}).done(function (result) {
		console.log(result);
		grid.resetData(result.rscOrdr);
		grid.refreshLayout();
	});

	let inspDialog = $("#inspModal").dialog({
		modal: true,
		autoOpen: false,
		buttons: {"저장":function(){
			grid.setValue(document.ordrQueryFrm.curRowKey.value, 'inspCls', 1);
			console.log(document.ordrQueryFrm.curRowKey.value);
			grid.setValue(document.ordrQueryFrm.curRowKey.value, 'rscInferQty', document.ordrQueryFrm.sum.value);
			
			inspDialog.dialog("close");
		},
		"닫기":function(){inspDialog.dialog("close");}
		}
	});

	grid.on('dblclick',function(ev){
	if(ev.columnName == "inspCls"){
		document.ordrQueryFrm.curRowKey.value = ev.rowKey;
		document.ordrQueryFrm.curColumnName.value = ev.columnName;
		inspDialog.dialog("open");
		$("#inspModal").load("inspModal");
	}
	});

//

  let ordrQueryBtn = document.getElementById("ordrQueryBtn");
  ordrQueryBtn.addEventListener("click", function () {

    let ordrDtStt = document.ordrQueryFrm.ordrDtStt.value;
    let ordrDtEnd = document.ordrQueryFrm.ordrDtEnd.value;
    let co = document.ordrQueryFrm.co.value;
    let rsc = document.ordrQueryFrm.rsc.value;
    let isNotInspected = document.ordrQueryFrm.isNotInspected.checked;

    $.ajax({
      url: "ordrData?ordrDtStt=" + ordrDtStt + "&ordrDtEnd=" + ordrDtEnd + "&co=" + co + "&rsc=" + rsc + "&isNotInspected=" + isNotInspected,
      method: "GET",
      dataType: "JSON"
    }).done(function (result) {
      console.log(result);
      grid.resetData(result.rscOrdr);
      grid.refreshLayout();
    });
  })

//

  let coDialog = $("#coModal").dialog({
    modal: true,
    autoOpen: false
  });

  $("#coSearchBtn").on("click", function () {
    coDialog.dialog("open");
    $("#coModal").load("../co");
  });

//

  let rscDialog = $("#rscModal").dialog({
    modal: true,
    autoOpen: false
  });

  $("#rscSearchBtn").on("click", function () {
    rscDialog.dialog("open");
    $("#rscModal").load("inspData");
  });
</script>

</html>