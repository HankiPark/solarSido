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
	<h1>자재 반품 조회</h1>
	<div id="coModal" title="업체 목록"></div>
	<div id="rscModal" title="자재 목록"></div>
	<div id="inspModal" title="입고"></div>
		  <div class="card card-pricing card-primary card-white">
		<div class="card-body" >
	<form id="ordrQueryFrm" name="ordrQueryFrm">
		<div><label>발주일:</label> <input type="text" id="datePicker" name="datePicker" class="dtp"></div>
 		<div><label>업체:</label> <input type="text" id="co" name="co"><button type="button" id="coSearchBtn">🔍</button>
		<label>자재:</label> <input type="text" id="rsc" name="rsc"><button type="button" id="rscSearchBtn">🔍</button></div>
		<button type="button" id="ordrQueryBtn" style="margin-left:-10px">조회</button>
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
				url: 'rtData',
				method: 'GET',
			}
		},
		initialRequest: false,
		contentType: 'application/json'
	};

	//공통코드 가져옴
	$.ajax({
		url: '../cmmn/codes',
		dataType: 'JSON',
		async: false,
	}).done(function (data) {
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
				header: '발주번호',
				name: 'ordrCd'
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
				header: '반품량',
				name: 'rscInferQty'
			},
			{
				header: '반품사유',
				name: 'rtngdResnCd',
			},
			{
				header: '발주일',
				name: 'ordrDt'
			},
			{
				header: '반품일',
				name: 'rtngdDt'
			}
		]
	});

	grid.on('response', function (ev) {
		if (ev.xhr.responseText == "201") {
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
		});
	});

	//

	let ordrQueryBtn = document.getElementById("ordrQueryBtn");
	ordrQueryBtn.addEventListener("click", function () {
		co = document.ordrQueryFrm.co.value;
		rsc = document.ordrQueryFrm.rsc.value;
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