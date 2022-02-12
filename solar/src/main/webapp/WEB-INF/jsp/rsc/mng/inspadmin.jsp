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
<style>
input#isNotInspected {
display : none;
}

input#isNotInspected+label{
display: inline-block;
        width: 15px;
        height: 15px;
        border:3px solid #e37c6b;
        margin-bottom:0px;
               position: relative;
      
}
input#isNotInspected:checked + label::after{
        content:'✔';
        font-size: 12px;
        width: 12px;
        height: 12px;
		position: absolute;
		top:-3px;
		left:0;
        background-color: #e37c6b;
        color:#fff;
         margin-bottom:0px;
      }

</style>

<body>
	<h1>자재 검수 관리</h1>
	<div id="coModal" title="업체 목록"></div>
	<div id="rscModal" title="자재 목록"></div>
	<div id="inspModal" title="검수"></div>
<div class="row" id="senseInspa">
		<div  id="senseInspaBody"  class="card card-pricing card-primary card-white card-outline col-3" style="margin-left: 50px;margin-right: 30px;margin-top: 150px;padding-left: 40px;margin-bottom: 300px; height:450px">

		<div class="card-body" >
		<form id="ordrQueryFrm" name="ordrQueryFrm">
			<div  style="margin-bottom: 20px; margin-top: 50px;"><label>발주일&nbsp;&nbsp;&nbsp;</label> <input type="text" id="datePicker" name="datePicker" class="dtp"></div>
			
			
			<div style="margin-bottom: 20px;"><label>발주업체</label><input type="text" id="co" name="co"><button type="button" id="coSearchBtn">🔍</button></div>
			<div style="margin-bottom: 20px;"><label>자재코드 </label><input type="text" id="rsc" name="rsc"><button type="button" id="rscSearchBtn">🔍</button></div>
			<div style="margin-bottom: 20px;"><label>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;미검수 자재만 표시</label><input type="checkbox" id="isNotInspected" name="isNotInspected"><label for="isNotInspected"></label></div>
		</form>
		</div>
		<div class="card-footer" style="margin-bottom: 30px;" >
		<button type="button" id="ordrQueryBtn" style="margin-left:30px">조회</button>
			<button type="button" id="inspSaveBtn" >저장</button>
			</div>
		</div>
	<div id="grid"  class="col-8" style=" margin-top:100px;">
		<button type="button" id="noInfer" >불량없음</button>
	</div>
</body>

<script>
	let cmmnCodes;
	let curRowKey;
	//let sum = 0;
	let date = new Date(+new Date() + 3240 * 10000);
	let ordrDtEnd = date.toISOString().substr(0,10);
	date.setDate(date.getDate()-7);
	let ordrDtStt = date.toISOString().substr(0,10);
	let co;
	let rsc;
	let inspCls;
    let rtngdResnCd;
	let inferDataSource = {
		api: {
			readData: { url: '${pageContext.request.contextPath}/grid/rsc/inspData', method: 'GET'}
			}
	};
	let ordrDataSource = {
		api: {
				readData: { url: '${pageContext.request.contextPath}/grid/rsc/ordrData', method: 'GET'},
				modifyData: {url: '${pageContext.request.contextPath}/grid/rsc/ordrData',method: 'PUT'}
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
    pageOptions : {
		useClient : true,
		perPage : 12
	},
	bodyHeight: 480,
    columns: [{
        header: '발주일',
        name: 'ordrDt',
        sortable: true,
        align: 'center',
      },
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
        header: '발주량',
        name: 'ordrQty',
        sortable: true,
        align: 'center',
      },
      {
        header: '받은 수량',
        name: 'rscIstQty',
        sortable: true,
        align: 'center',
      },
      {
        header: '불량량',
        name: 'rscInferQty',
        sortable: true,
        align: 'center',
      },
      {
        header: '발주번호',
        name: 'ordrCd',
        sortable: true,
        align: 'center',
      },
      {
        header: '업체',
        name: 'coNm',
        sortable: true,
        align: 'center',
      },
      {
        header: '검수여부',
        name: 'inspCls',
        formatter: 'listItemText',
        sortable: true,
        align: 'center',
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
	
	function gridCss(){
		  let dsabTexts = document.querySelectorAll('.tui-grid-cell-disabled');
		  for(let dtx of dsabTexts){
			  dtx.classList.remove('tui-grid-cell-disabled');
		  }
	  }
	grid.on('onGridUpdated',function(){
		gridCss();
	});
    
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
			'inspCls':inspCls,
			'whereParam':'inspadmin',
		});
	});

	let inspDialog = $("#inspModal").dialog({
		modal: true,
		autoOpen: false,
		width : 600,
		height : 600,
		buttons: {"입력":function(){
			let qty = grid.getValue(curRowKey,'rscIstQty');
			if(sum > qty){
			  toastr.error('총량보다 많은 불량량을 입력할 수 없습니다.');
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
		},
		close: function(){
			sum = 0;
		}
	});
	
	grid.on('click',function(ev){
	if(ev.columnName == "inspCls"){
		curRowKey = ev.rowKey;
		inspDialog.dialog("open");
		$("#inspModal").load("${pageContext.request.contextPath}/modal/rsc/inspModal");
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
		'inspCls':inspCls,
		'whereParam':'inspadmin',
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

  let saveBtn = document.getElementById('inspSaveBtn');
  saveBtn.addEventListener('click',function(){
	  grid.request('modifyData');
  });
	$('#senseInspa').resize(function(){
		if($('#senseInspa').width()<1780){
			$('#senseInspaBody').css('paddingLeft','15px');
		}else{
			$('#senseInspaBody').css('paddingLeft','40px');
		}
	})
	
	let noInfer	= document.getElementById('noInfer');
	noInfer.addEventListener('click',function(){
		for(let i of grid.getCheckedRowKeys()){
			console.log(i);
			grid.setValue(i, 'inspCls', 'rs002');
		}
	});
</script>

</html>