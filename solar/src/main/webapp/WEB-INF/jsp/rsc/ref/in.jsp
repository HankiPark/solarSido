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
  <div class="card card-pricing card-primary card-white">
		<div class="card-body" >
  <form id="ordrQueryFrm" name="ordrQueryFrm"><div>
   <label> 발주일:</label> <input type="text" id="datePicker" name="datePicker" class="dtp"></div>
  <div>  <label>발주업체:</label> <input type="text" id="co" name="co"><button type="button" id="coSearchBtn">🔍</button>
   <label>자재:</label> <input type="text" id="rsc" name="rsc"><button type="button" id="rscSearchBtn">🔍</button></div>
    <br>
    <button type="button" id="ordrQueryBtn">조회</button>
  </form>
  </div>
  </div>
  
  <div id="grid"></div>
</body>

<script>
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
				    readData: { url: '${pageContext.request.contextPath}/rsc/inData', method: 'GET'}
				  },
				  contentType : 'application/json',
				  initialRequest: false,
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
      grid.refreshLayout();
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