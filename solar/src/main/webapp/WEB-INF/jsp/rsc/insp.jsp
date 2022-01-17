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
		<form id="ordrQueryFrm" name="ordrQueryFrm">
			발주일: <input type="date" id="ordrDtStt" name="ordrDtStt">~<input type="date" id="ordrDtEnd" name="ordrDtEnd">
			미검수 자재만 표시<input type="checkbox" id="isNotInspected" name="isNotInspected">
			<br>
			발주업체: <input type="text" id="co" name="co"><button type="button" id="coSearchBtn">🔍</button>
			자재: <input type="text" id="rsc" name="rsc"><button type="button" id="rscSearchBtn">🔍</button>
			<button type="button" id="ordrQueryBtn">조회</button>
			<button type="button" id="inspSaveBtn">저장</button>
		</form>
	<div id="grid"></div>
</body>

<script>
	let cmmnCodes;
	let curRowKey;
	let sum;
	let ordrDtStt;
	let ordrDtEnd;
	let co;
	let rsc;
	let inspCls;
    let rtngdResnCd;
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

//공통코드 가져옴
	$.ajax({
	 url: '../cmmn/codes',
	 dataType: 'JSON',
	 async: false,
	}).done(function(data){
	 cmmnCodes = data;
	 console.log(data);
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
  
	grid.hideColumn('rtngdResnCd');
	grid.hideColumn('rtngdDt');
	
  
/*     grid.on('beforeChange',function(ev){
    	console.log('befgg')
    	if(ev.columnName == 'inspCls'){
    	return false;
    	}
    }); */
    
	grid.on('response',function(ev){
		console.log(ev.xhr.response);
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
    ordrDtStt = document.ordrQueryFrm.ordrDtStt.value;
    ordrDtEnd = document.ordrQueryFrm.ordrDtEnd.value;
    co = document.ordrQueryFrm.co.value;
    rsc = document.ordrQueryFrm.rsc.value;
    console.log(document.ordrQueryFrm.isNotInspected.checked);
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
  });
</script>

</html>