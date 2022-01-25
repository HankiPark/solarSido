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
  <h1>자재 발주 관리</h1>
  <div id="coModal" title="업체 목록"></div>
  <div id="rscModal" title="자재 목록"></div>
  <form id="ordrQueryFrm" name="ordrQueryFrm">
    발주일: <input type="text" id="datePicker" name="datePicker" class="dtp"><br>
    발주업체: <input type="text" id="co" name="co"><button type="button" id="coSearchBtn">🔍</button>
    자재: <input type="text" id="rsc" name="rsc"><button type="button" id="rscSearchBtn">🔍</button>
    <button type="button" id="ordrQueryBtn">조회</button><br>
    <button type="button" id="prependRowBtn">행 삽입</button>
    <button type="button" id="saveBtn">저장</button>
    <button type="button" id="deleteBtn">삭제</button>
  </form>
  <div id="grid"></div>
</body>

<script>
let d = new Date();
let date = new Date();
let ordrDtEnd = date.toISOString().substr(0,10);
date.setDate(date.getDate() - 7);
let ordrDtStt = date.toISOString().substr(0,10);
$(function() {
   
     $('input[name="datePicker"]').daterangepicker({
        showDropdowns: true,
       opens: 'right',
       startDate: moment().startOf('hour').add(-7, 'day'),
        endDate: moment().startOf('hour'),
        minYear: 1990,
          maxYear: 2025,
        autoApply: true,
          locale: {
            format: 'YYYY-MM-DD',
               separator: " ~ ",
                applyLabel: "적용",
                cancelLabel: "닫기",
                prevText: '이전 달',
                nextText: '다음 달',
                monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                daysOfWeek: ['일', '월', '화', '수', '목', '금', '토'],
                showMonthAfterYear: true,
                yearSuffix: '년'
          }
     }, function(start, end, label) {
       ordrDtStt = start.format('YYYY-MM-DD');
       ordrDtEnd = end.format('YYYY-MM-DD');
     },
     
     );
   });
   
	let ordrDataSource = {
			  api: {
				    readData: { url: 'ordrData?inspCls=rs001', method: 'GET'},
					modifyData: {url: 'ordrData',method: 'PUT'}
				  },
				  contentType : 'application/json',
				  initialRequest: false
				};
	
	//공통코드 가져옴
	$.ajax({
	 url: '../cmmn/codes',
	 dataType: 'JSON',
	 async: false,
	}).done(function(data){
	 cmmnCodes = data;
	});
			
  var grid = new tui.Grid({
    el: document.getElementById('grid'),
    scrollX: false,
    scrollY: false,
    data: ordrDataSource,
    rowHeaders: ['checkbox'],
    sortable: true,
    columns: [{
        header: '발주일',
        name: 'ordrDt'
      },
      {
        header: '발주번호',
        name: 'ordrCd'
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
        name: 'ordrQty',
        editor: 'text'
      },
      {
        header: '업체',
        name: 'coNm'
      },
      {
          header: '상태',
          name: 'inspCls',
          formatter: 'listItemText',
          editor: {
              type: 'select',
              options: {
                listItems:cmmnCodes.codes.rscst
              }
          }
        }
    ]
  });
  
  grid.disableColumn('inspCls');
  grid.on('response',function(){
      grid.refreshLayout();
    });
  grid.on('click',function(ev){
      if(ev.columnName =='rscNm' || ev.columnName == 'rscCd' || ev.columnName == 'coNm'){
    	  evVar = ev;
    	  rscDialog.dialog("open");
	   	  $("#rscModal").load("../rsc");
      }
      /* if(ev.columnName == 'inspCls'){
    	  return false;
      } */
    });
	grid.on('onGridMounted',function(){
		grid.readData(1,{
			'ordrDtStt':ordrDtStt,
			'ordrDtEnd':ordrDtEnd,
			'co':co,
			'rsc':rsc,
		});
	});
//

  let ordrQueryBtn = document.getElementById("ordrQueryBtn");
  ordrQueryBtn.addEventListener("click", function () {
    co = document.ordrQueryFrm.co.value;
    rsc = document.ordrQueryFrm.rsc.value;
	grid.readData(1,{
		'ordrDtStt':ordrDtStt,
		'ordrDtEnd':ordrDtEnd,
		'co':co,
		'rsc':rsc
	});
  });
  let prependRowBtn = document.getElementById("prependRowBtn");
  prependRowBtn.addEventListener("click",function(){
	  grid.prependRow({
		  "ordrDt":d.toISOString().slice(0, 4)+"/"+d.toISOString().slice(5, 7)+"/"+d.toISOString().slice(8, 10),
		  "inspCls":"rs001"
	  });
  });
  let saveBtn = document.getElementById("saveBtn");
  saveBtn.addEventListener("click",function(){
	  let newRows = grid.getModifiedRows().createdRows;
	  for(let newRow of newRows){
		  if(newRow.rscCd == '' || newRow.ordrQty == '' || parseInt(newRow.ordrQty)+'' == 'NaN'){
			  alert('유효한 값을 입력하세요.');
			  return false;
		  }
	  }
	  grid.request('modifyData');
  });
  let deleteBtn = document.getElementById("deleteBtn");
  deleteBtn.addEventListener("click",function(){
	  let checkedRowKeys = grid.getCheckedRowKeys();
	  for(let rowkey of checkedRowKeys){
	  grid.removeRow(rowkey);
	  }
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