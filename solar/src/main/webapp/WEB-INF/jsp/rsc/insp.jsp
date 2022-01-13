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
	<h1>자재 검수 관리</h1>
	<div id="coModal" title="업체 목록">Loading..</div>
	<div id="rscModal" title="자재 목록">Loading..</div>
	<div id="inspModal" title="검수">Loading..</div>
		<form id="ordrQueryFrm" name="ordrQueryFrm">
			발주일: <input type="date" id="ordrDtStt" name="ordrDtStt">~<input type="date" id="ordrDtEnd" name="ordrDtEnd">
			미검수 자재만 표시<input type="checkbox" id="isNotInspected" name="isNotInspected">
			<br>
			발주업체: <input type="text" id="co" name="co"><button type="button" id="coSearchBtn">ㅇ-</button>
			자재: <input type="text" id="rsc" name="rsc"><button type="button" id="rscSearchBtn">ㅇ-</button>
			<button type="button" id="ordrQueryBtn">조회</button>
			<button type="button" id="inspSaveBtn">저장</button>
		</form>
	<div id="grid"></div>
</body>

<script>
	let curRowKey;
	let sum;
  let ordrDtStt;
  let ordrDtEnd;
  let co;
  let rsc;
  let isNotInspected;
  let inferDataSource = {
		  api: {
			    readData: { url: '../rsc/inspData', method: 'GET'}
			  }
			};
  let ordrDataSource = {
		  api: {
			    readData: { url: 'ordrData', method: 'GET'},
  				modifyData: {url: 'ordrData',method: 'PUT'}
			  },
			  contentType : 'application/json'
			};
  
  var grid = new tui.Grid({
    el: document.getElementById('grid'),
    scrollX: false,
    scrollY: false,
    data: ordrDataSource,
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
        header: '받은 수량',
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
  
    grid.on('response',function(ev){
      if(ev.xhr.responseText =="201"){
    	  console.log("201");
    	  grid.readData();
      }
      grid.refreshLayout();
    });

	let inspDialog = $("#inspModal").dialog({
		modal: true,
		autoOpen: false,
		buttons: {"입력":function(){
      if(sum > grid.getValue(curRowKey,'rscIstQty')){
        alert('총량보다 많은 불량량을 입력할 수 없습니다.');
        return false;
      }
			grid.setValue(curRowKey, 'inspCls', '입력됨');
			grid.setValue(curRowKey, 'rscInferQty', sum);
			inspDialog.dialog("close");
		},
		"닫기":function(){inspDialog.dialog("close");}
		}
	});
	
	grid.on('dblclick',function(ev){
	if(ev.columnName == "inspCls"){
		curRowKey = ev.rowKey;
		inspDialog.dialog("open");
		$("#inspModal").load("inspModal");
	}
	});

//

  let ordrQueryBtn = document.getElementById("ordrQueryBtn");
  ordrQueryBtn.addEventListener("click", function () {
    ordrDtStt = document.ordrQueryFrm.ordrDtStt.value;
    ordrDtEnd = document.ordrQueryFrm.ordrDtEnd.value;
    co = document.ordrQueryFrm.co.value;
    rsc = document.ordrQueryFrm.rsc.value;
    isNotInspected = document.ordrQueryFrm.isNotInspected.checked;
	grid.readData(1,{
		'ordrDtStt':ordrDtStt,
		'ordrDtEnd':ordrDtEnd,
		'co':co,
		'rsc':rsc,
		'isNotInspected':isNotInspected
	});
  });

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
    $("#rscModal").load("../rsc");
  });
  
  let saveBtn = document.getElementById('inspSaveBtn');
  saveBtn.addEventListener('click',function(){
	  grid.request('modifyData');
  })
</script>

</html>