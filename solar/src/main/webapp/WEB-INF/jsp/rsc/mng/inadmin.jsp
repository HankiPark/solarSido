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
	<h1>자재 입고 관리</h1>
	<div id="coModal" title="업체 목록"></div>
	<div id="rscModal" title="자재 목록"></div>
	<div id="inspModal" title="입고"></div>
<div class="row" id="senseIn">
		<div  id="senseInBody"  class="card card-pricing card-primary card-white card-outline col-3" style="margin-left: 50px;margin-right: 30px;margin-top: 150px;padding-left: 40px;margin-bottom: 300px; height:400px">

		<div class="card-body">
			
	<form id="ordrQueryFrm" name="ordrQueryFrm">
		<div  style="margin-bottom: 20px; margin-top: 50px;">
			<label>발주일 &nbsp;&nbsp;&nbsp;&nbsp;</label> <input type="text" id="datePicker" name="datePicker" class="dtp">
		</div>
		<div style="margin-bottom: 20px;">
		<label>발주업체&nbsp;</label> <input type="text" id="co" name="co"><button type="button" id="coSearchBtn">🔍</button></div>
		<div style="margin-bottom: 20px;"><label>	자재코드&nbsp;</label> <input type="text" id="rsc" name="rsc"><button type="button" id="rscSearchBtn">🔍</button>
		</div>
		
	</form>
	</div>
	<div class="card-footer" style="margin-bottom: 30px;" >
	<button type="button" id="ordrQueryBtn" style="margin-left:120px">조회</button>
	</div>
	</div>

	<div class="col-8" style=" margin-top:100px;">
		<div id="grid" ></div>
		
			<div class="card card-pricing card-primary card-white card-outline" style="width:100% ;margin-top:50px;margin-left:-3px">
				<div class="card-body" >
					<div style="margin-top:20px; padding-left:30px;margin-bottom:20px" class="row">
						<div class="col-4">발주량<input id="ordrQty" disabled></div>
						<div class="col-4">검수합격량<input id="rscPassedQty" disabled></div>
						<div class="col-4">입고수량확인<input id="confirmedQty" placeholder="검수합격량"></div>
					</div>
				</div>
				<div class="card-footer" style="cursor:pointer;background-color:#e37c6b;color:#ffffff;text-align:center;font-size:25px ;border-radius:0px 0px 10px 10px" id="btnIn" ><i class="fas fa-truck-loading"></i>&nbsp; 입고
					</div>
			</div>
		</div>
	</div>
</body>

<script>
	let cmmnCodes;
	let curRowKey;
	let sum;
	let date = new Date(+new Date() + 3240 * 10000);
	let ordrDtEnd = date.toISOString().substr(0,10);
	date.setDate(date.getDate()-7);
	let ordrDtStt = date.toISOString().substr(0,10);
	let co;
	let rsc;
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
			readData: {
				url: '${pageContext.request.contextPath}/grid/rsc/ordrData?inspCls=rs002',
				method: 'GET',
			},
			modifyData: {
				url: '${pageContext.request.contextPath}/grid/rsc/ordrData',
				method: 'PUT'
			}
		},
		contentType: 'application/json',
		initialRequest: false,
	};

	//공통코드 가져옴
	$.ajax({
		url: '${pageContext.request.contextPath}/ajax/cmmn/codes',
		dataType: 'JSON',
		async: false,
	}).done(function (data) {
		cmmnCodes = data;
	});

	let inspDialog = $("#inspModal").dialog({
		modal: true,
		autoOpen: false,
		width : 600,
		height : 600,
		buttons: {
			"입력": function () {
				if (sum > grid.getValue(curRowKey, 'rscIstQty')) {
					toastr.error('총량보다 많은 불량량을 입력할 수 없습니다.');
					return false;
				}
				grid.setValue(curRowKey, 'inspCls', 'rs002');
				grid.setValue(curRowKey, 'rscInferQty', sum);
				inspDialog.dialog("close");
			},
			"닫기": function () {
				inspDialog.dialog("close");
			}
		}
	});

	var Grid = tui.Grid;
	Grid.setLanguage('ko');
	var grid = new Grid({
		el: document.getElementById('grid'),
		scrollX: true,
		scrollY: false,
		data: ordrDataSource,
		rowHeaders: ['checkbox'],
		bodyHeight: 320,
	    pageOptions : {
			useClient : true,
			perPage : 8
		},
		scrollX: false,
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
				header: '합격량',
				name: 'rscPassedQty',
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
				header: '상태',
				name: 'inspCls',
				formatter: 'listItemText',
				sortable: true,
		        align: 'center',
				editor: {
					type: 'select',
					options: {
						listItems: cmmnCodes.codes.rscst
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
	grid.on('response', function (ev) {
		if (ev.xhr.responseText == "201") {
			grid.readData(1,{
				'ordrDtStt':ordrDtStt,
				'ordrDtEnd':ordrDtEnd,
				'co':co,
				'rsc':rsc,
			});
		}
		grid.refreshLayout();
	});

	grid.on('click', function (ev) {
		//if (ev.columnName == "inspCls") {
			curRowKey = ev.rowKey;

		//}
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
		rtngdResnCd = '';
		rtngdDt = '';
		grid.readData(1, {
			'ordrDtStt': ordrDtStt,
			'ordrDtEnd': ordrDtEnd,
			'co': co,
			'rsc': rsc,
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

/* 	let saveBtn = document.getElementById('inspSaveBtn');
	saveBtn.addEventListener('click', function () {
		grid.request('modifyData');
	}); */

	let btnIn = document.getElementById('btnIn');
	btnIn.addEventListener('click', function () {
		let date = new Date();
 		let passedQty = document.getElementById("rscPassedQty").value;
 		let confirmedQty = document.getElementById('confirmedQty').value;
 		let arr = [];
		if (passedQty != confirmedQty) {
			toastr.error("정확한 입고량을 입력하십시오.");
			return false;
		}
		for(let i of grid.getCheckedRowKeys()){
			grid.setValue(i, 'inspCls', "rs003");
			let obj = {
				rscSlipNo: "rin",
				rscCd: grid.getValue(i, 'rscCd'),
				rscQty: grid.getValue(i, 'rscPassedQty'),
				rscFg: 1,
			}
			arr.push(obj);
		}
		grid.request('modifyData');
		
 		fetch("${pageContext.request.contextPath}/grid/rsc/in/rscin", {
			method: "POST",
			headers: {
				"Content-Type": "application/json",
			},
			body: JSON.stringify(arr)
		});
	});
	
	$('#senseIn').resize(function(){
		if($('#senseIn').width()<1780){
			$('#senseInBody').css('paddingLeft','15px');
		}else{
			$('#senseInBody').css('paddingLeft','40px');
		}
	})
	
    grid.on('check',function(ev){
    	checkedRowsSum();
    })
    grid.on('uncheck',function(ev){
    	checkedRowsSum();
    })
    grid.on('checkAll',function(ev){
    	checkedRowsSum();
    })
    grid.on('uncheckAll',function(ev){
    	checkedRowsSum();
    })
    
    function checkedRowsSum(){
		let ordrSum = 0;
		let passedSum = 0;
		for(let row of grid.getCheckedRows()){
			ordrSum += parseInt(row.ordrQty);
			passedSum += parseInt(row.rscPassedQty);
		}
		document.getElementById("ordrQty").value = ordrSum;
		document.getElementById("rscPassedQty").value = passedSum;
	}
</script>

</html>