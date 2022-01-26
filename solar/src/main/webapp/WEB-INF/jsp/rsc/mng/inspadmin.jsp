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
	<div id="coModal" title="업체 목록"></div>
	<div id="rscModal" title="자재 목록"></div>
	<div id="inspModal" title="검수"></div>
		   <div class="card card-pricing card-primary card-white">
		<div class="card-body" >
		<form id="ordrQueryFrm" name="ordrQueryFrm">
			<div><label>발주일:</label> <input type="text" id="datePicker" name="datePicker" class="dtp">
			<label>미검수 자재만 표시</label><input type="checkbox" id="isNotInspected" name="isNotInspected"></div>
			
			<div><label>발주업체: </label><input type="text" id="co" name="co"><button type="button" id="coSearchBtn">🔍</button>
			<label>자재: </label><input type="text" id="rsc" name="rsc"><button type="button" id="rscSearchBtn">🔍</button></div>
			<button type="button" id="ordrQueryBtn" style="margin-left:-10px">조회</button>
			<button type="button" id="inspSaveBtn" >저장</button>
		</form>
		</div>
		</div>
	<div id="grid"></div>
</body>

<script>
	let cmmnCodes;
	let curRowKey;
	let sum;
	let date = new Date();
	let ordrDtEnd = date.toISOString().substr(0,10);
	date.setDate(date.getDate() - 7);
	let ordrDtStt = date.toISOString().substr(0,10);
	let co;
	let rsc;
	let inspCls;
    let rtngdResnCd;
	let inferDataSource = {
		api: {
			readData: { url: '${pageContext.request.contextPath}/rsc/inspData', method: 'GET'}
			}
	};
	let ordrDataSource = {
		api: {
				readData: { url: '${pageContext.request.contextPath}/rsc/ordrData', method: 'GET'},
				modifyData: {url: '${pageContext.request.contextPath}/rsc/ordrData',method: 'PUT'}
			},
			contentType : 'application/json',
			initialRequest: false,
	};
	
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

//공통코드 가져옴
	$.ajax({
	 url: '${pageContext.request.contextPath}/cmmn/codes',
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
        header: '자재명',
        name: 'rscNm',
        width: 220,
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
        name: 'inspCls',
        formatter: 'listItemText',
        editor: {
            type: 'select',
            options: {
              listItems:cmmnCodes.codes.rscst
            }
        }
      },
		{
			name: 'rtngdResnCd'
		},
		{
			name: 'rtngdDt'
		},
    ]
  });
  	grid.disableColumn('inspCls');
	grid.hideColumn('rtngdResnCd');
	grid.hideColumn('rtngdDt');
	
  
/*     grid.on('beforeChange',function(ev){
    	console.log('befgg')
    	if(ev.columnName == 'inspCls'){
    	return false;
    	}
    }); */
    
	grid.on('response',function(ev){
      if(ev.xhr.responseText =="201"){
    	  grid.readData();
      }
      grid.refreshLayout();
    });
	grid.on('onGridMounted',function(){
		grid.readData(1,{
			'ordrDtStt':ordrDtStt,
			'ordrDtEnd':ordrDtEnd,
			'co':co,
			'rsc':rsc,
			'inspCls':inspCls
		});
	});

	let inspDialog = $("#inspModal").dialog({
		modal: true,
		autoOpen: false,
		width : 600,
		height : 600,
		buttons: {"입력":function(){
			if(sum > grid.getValue(curRowKey,'rscIstQty')){
			  alert('총량보다 많은 불량량을 입력할 수 없습니다.');
			  return false;
			}

            //불량명 문자타입으로 나열
            rtngdResnCd = '';
			for(let i = 0; i < inferGrid.getRowCount(); i++){
				if(inferGrid.getValue(i,"rscInferQty")!=null && inferGrid.getValue(i,"rscInferQty")!=''){
                rtngdResnCd += ","+inferGrid.getValue(i,"cmmnCdNm");
				}
            }
			rtngdResnCd = rtngdResnCd.substr(1);
            //
            
			grid.setValue(curRowKey, 'inspCls', 'rs002');
			grid.setValue(curRowKey, 'rtngdResnCd', rtngdResnCd);
			//let d = new Date();
			//grid.setValue(curRowKey, 'rtngdDt', d.toISOString().slice(0, 10));
			grid.setValue(curRowKey, 'rscInferQty', sum);
			inspDialog.dialog("close");
		},
		"닫기":function(){inspDialog.dialog("close");}
		}
	});
	
	grid.on('click',function(ev){
	if(ev.columnName == "inspCls"){
		curRowKey = ev.rowKey;
		inspDialog.dialog("open");
		$("#inspModal").load("inspModal");
	}
	});

//

  let ordrQueryBtn = document.getElementById("ordrQueryBtn");
  ordrQueryBtn.addEventListener("click", function () {
    co = document.ordrQueryFrm.co.value;
    rsc = document.ordrQueryFrm.rsc.value;
    inspCls = document.ordrQueryFrm.isNotInspected.checked ? 'rs001' : null;
	grid.readData(1,{
		'ordrDtStt':ordrDtStt,
		'ordrDtEnd':ordrDtEnd,
		'co':co,
		'rsc':rsc,
		'inspCls':inspCls
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

  let saveBtn = document.getElementById('inspSaveBtn');
  saveBtn.addEventListener('click',function(){
	  grid.request('modifyData');
  });
</script>

</html>