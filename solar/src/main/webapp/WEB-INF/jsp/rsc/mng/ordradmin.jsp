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
 <div class="row" id="senseOrdr">
		<div id="senseOrdrBody" class="card card-pricing card-primary card-white card-outline col-3" style="margin-left: 50px;margin-right: 30px;margin-top: 150px;padding-left: 40px;margin-bottom: 300px; height:350px">
		<div class="card-body" >
  <form id="ordrQueryFrm" name="ordrQueryFrm">
   <div  style="margin-bottom: 20px; margin-top: 50px;"><label>발주일&nbsp;&nbsp;&nbsp;&nbsp;</label> <input type="text" id="datePicker" name="datePicker" class="dtp"></div>
   <div style="margin-bottom: 20px;"><label>발주업체</label> <input type="text" id="co" name="co"><button type="button" id="coSearchBtn">🔍</button></div>
   <div style="margin-bottom: 20px;"><label>자재코드</label> <input type="text" id="rsc" name="rsc"><button type="button" id="rscSearchBtn">🔍</button></div>
   
    
    </div>
    <div class="card-footer" style="margin-bottom: 30px;" >
     <button type="button" id="ordrQueryBtn" style="margin-left:120px">조회</button>
     </div>
    </div>
    <div class="col-8"  style=" margin-top:100px">
    <div style="margin-left: 30px; margin-top: -50px" class="float-right">
    <button type="button" id="prependRowBtn">추가</button>
    <button type="button" id="saveBtn">저장</button>
    <button type="button" id="deleteBtn">삭제</button>
    </div>
  </form>
<div  id="grid" ></div>
</div>
</body>

<script>
let d = new Date();
let date = new Date(+new Date() + 3240 * 10000);
let ordrDtEnd = date.toISOString().substr(0,10);
date.setDate(date.getDate()-7);
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
				    readData: { url: '${pageContext.request.contextPath}/grid/rsc/ordrData?inspCls=rs001', method: 'GET'},
					modifyData: {url: '${pageContext.request.contextPath}/grid/rsc/ordrData',method: 'PUT'}
				  },
				  contentType : 'application/json',
				  initialRequest: false
				};
	
	//공통코드 가져옴
	$.ajax({
	 url: '${pageContext.request.contextPath}/ajax/cmmn/codes',
	 dataType: 'JSON',
	 async: false,
	}).done(function(data){
	 cmmnCodes = data;
	});
			
	var Grid = tui.Grid;
	Grid.setLanguage('ko');
	
  var grid = new Grid({
    el: document.getElementById('grid'),
    scrollX: false,
    scrollY: false,
    data: ordrDataSource,
    rowHeaders: ['checkbox'],
    sortable: true,
    minBodyHeight : 500,
    columns: [{
        header: '발주일',
        name: 'ordrDt',
        sortable: true,
      },
      {
        header: '발주번호',
        name: 'ordrCd',
        sortable: true,
      },
      {
        header: '자재명',
        name: 'rscNm',
        width: 220,
        sortable: true,
      },
      {
        header: '자재코드',
        name: 'rscCd',
        sortable: true,
      },
      {
        header: '발주량',
        name: 'ordrQty',
        editor: 'text',
        sortable: true,
      },
      {
        header: '업체',
        name: 'coNm',
        sortable: true,
      },
      {
          header: '상태',
          name: 'inspCls',
          formatter: 'listItemText',
          sortable: true,
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
  function gridCss(){
	  let dsabTexts = document.querySelectorAll('.tui-grid-cell-disabled');
	  for(let dtx of dsabTexts){
		  dtx.style.backgroundColor = '#f4f4f4';
		  dtx.classList.remove('tui-grid-cell-disabled');
	  }
  }
  grid.on('onGridUpdated',function(){
	  gridCss();
  });
  grid.on('response',function(ev){
		if (ev.xhr.responseText == "201") {
			grid.readData();
		}
      grid.refreshLayout();
    });
  grid.on('click',function(ev){
      if((ev.columnName =='rscNm' || ev.columnName == 'rscCd' || ev.columnName == 'coNm')&&ev.targetType!='columnHeader'){
    	  evVar = ev;
    	  rscDialog.dialog("open");
	   	  $("#rscModal").load("${pageContext.request.contextPath}/modal/rsc");
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
  $('#senseOrdr').resize(function(){
		if($('#senseOrdr').width()<1780){
			$('#senseOrdrBody').css('paddingLeft','15px');
		}else{
			$('#senseOrdrBody').css('paddingLeft','40px');
		}
	})
</script>

</html>