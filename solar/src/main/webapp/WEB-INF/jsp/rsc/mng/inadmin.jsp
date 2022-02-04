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
	<h1>자재 입고 관리</h1><hr>
	<div id="coModal" title="업체 목록"></div>
	<div id="rscModal" title="자재 목록"></div>
	<div id="inspModal" title="입고"></div>
		<div class="card card-pricing card-primary card-white">
		<div class="card-body" >
			
	<form id="ordrQueryFrm" name="ordrQueryFrm">
		<div>
			<label>발주일:</label> <input type="text" id="datePicker" name="datePicker" class="dtp">
		</div>
		<div>
		<label>발주업체:</label> <input type="text" id="co" name="co"><button type="button" id="coSearchBtn">🔍</button>
		<label>	자재:</label> <input type="text" id="rsc" name="rsc"><button type="button" id="rscSearchBtn">🔍</button>
		</div>
		<button type="button" id="ordrQueryBtn" style="margin-left:-10px">조회</button>
		<button type="button" id="inspSaveBtn" style="margin-left:-10px">저장</button>
	</form>
	</div>
	</div>

	<div class="flex row">
		<div id="grid" class="col-8"></div>
		<div class="col-4">
			<div class="card card-pricing card-primary card-white">
				<div class="card-body" >
					<ul>
						<li>발주량:<br><input id="ordrQty" disabled></li><br>
						<li>검수합격량:<br><input id="rscPassedQty" disabled></li><br>
						<li>입고수량확인<br><input id="confirmedQty" placeholder="검수합격량"></li>
					</ul>
					<div align="center">
						<button type="button" id="btnIn">입고</button>
					</div>
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
					alert('총량보다 많은 불량량을 입력할 수 없습니다.');
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
		bodyHeight: 240,
		scrollX: false,
		columns: [{
				header: '발주일',
				name: 'ordrDt',
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
				sortable: true,
			},
			{
				header: '합격량',
				name: 'rscPassedQty',
				sortable: true,
			},
			{
				header: '발주번호',
				name: 'ordrCd',
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
			let ordrQty = document.getElementById("ordrQty");
			let rscPassedQty = document.getElementById("rscPassedQty");
			ordrQty.value = grid.getValue(grid.getFocusedCell().rowKey, 'ordrQty');
			rscPassedQty.value = grid.getValue(grid.getFocusedCell().rowKey, 'rscPassedQty');
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
		width : 600,
		height : 600
	});

	$("#rscSearchBtn").on("click", function () {
		rscDialog.dialog("open");
		$("#rscModal").load("${pageContext.request.contextPath}/modal/rsc");
	});

	let saveBtn = document.getElementById('inspSaveBtn');
	saveBtn.addEventListener('click', function () {
		grid.request('modifyData');
	});

	let btnIn = document.getElementById('btnIn');
	btnIn.addEventListener('click', function () {
		let date = new Date();
 		let confirmedQty = document.getElementById('confirmedQty');
		if (grid.getValue(grid.getFocusedCell().rowKey, 'rscPassedQty') != confirmedQty.value) {
			alert("정확한 입고량을 입력하십시오.");
			return false;
		}
		grid.setValue(grid.getFocusedCell().rowKey, 'inspCls', "rs003");
		grid.request('modifyData');
		
 		fetch("${pageContext.request.contextPath}/grid/rsc/in/rscin", {
			method: "POST",
			headers: {
				"Content-Type": "application/json",
			},
			body: JSON.stringify({
				rscSlipNo: "rin",
				rscCd: grid.getValue(grid.getFocusedCell().rowKey, 'rscCd'),
				rscQty: grid.getValue(grid.getFocusedCell().rowKey, 'rscPassedQty'),
				rscFg: 1,
			})
		});
	});
</script>

</html>