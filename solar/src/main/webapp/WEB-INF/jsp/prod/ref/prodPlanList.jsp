<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산계획조회</title>
</head>

<body>
	<h2>생산계획조회</h2>


	<!-- 검색모달 -->
	<div id="coCdModal" title="업체 목록"></div>
	<div id="prdtCdModal" title="제품 목록"></div>

	<!-- 검색테이블 -->
	<div class="row" id="senseIn">
		<div id="senseInBody"
			class="card card-pricing card-primary card-white card-outline col-3"
			style="margin-left: 50px; margin-right: 30px; margin-top: 150px; padding-left: 40px; margin-bottom: 300px; height: 400px">
			<div class="card-body">

				<form action="searchFrm" name="searchFrm">
					<input type="hidden" id="planNo" name="planNo" value="planNo">
					<div style="margin-bottom: 20px; margin-top: 50px;">
						<label>계획일&nbsp;&nbsp;&nbsp;&nbsp;</label> <input type="text"
							id="startT" name="startT" class="dtp">
					</div>
					<div style="margin-bottom: 20px;">
						<label>업체코드</label> <input type="text" id="coCd" name="coCd"
							readonly>
						<button type="button" id="btnCoCdFind">🔍</button>
					</div>
					<div style="margin-bottom: 20px;">
						<label>제품코드</label> <input type="text" id="prdtCd" name="prdtCd"
							readonly>
						<button type="button" id="btnPrdtCdFind">🔍</button>
					</div>

				</form>
			</div>

			<div class="card-footer" style="margin-bottom: 30px;">
				<button type="button" id="btnSearch">조회</button>
				<button type="button" id="btnReset">초기화</button>

			</div>
		</div>
		<div class="col-8" style="margin-top: 50px;">
			<button style="width: 100px; height: 40px; font-size: 20px; border-radius: 20px; padding: 6px 1px 6px 3px" type="button" id="btnExcel" class="float-right"><i class="far fa-file-excel"></i>&nbsp;Excel</button>
			<div id="planDgrid"></div>
		</div>
	</div>


	<!-- 생산계획 상세 그리드-->


</body>

<!-- 스크립트 -->
<script type="text/javascript">
	let coCd;
	let prdtCd;

	$(function() {
		$('input[name="startT"]').daterangepicker(
				{
					showDropdowns : true,
					opens : 'right',
					startDate : moment().startOf('hour').add(-7, 'day'),
					endDate : moment().startOf('hour'),
					minYear : 1990,
					maxYear : 2025,
					autoApply : true,
					locale : {
						format : 'YYYY-MM-DD',
						separator : " ~ ",
						applyLabel : "적용",
						cancelLabel : "닫기",
						prevText : '이전 달',
						nextText : '다음 달',
						monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
								'7월', '8월', '9월', '10월', '11월', '12월' ],
						daysOfWeek : [ '일', '월', '화', '수', '목', '금', '토' ],
						showMonthAfterYear : true,
						yearSuffix : '년'
					}
				},
				function(start, end, label) {
					console.log("A new date selection was made: "
							+ start.format('YYYY-MM-DD') + ' to '
							+ end.format('YYYY-MM-DD'));
				});
	});

	//업체검색 모달
	let coCdDialog = $("#coCdModal").dialog({
		autoOpen : false,
		modal : true,
		height : 600,
		width : 600
	});

	$("#btnCoCdFind").on(
			"click",
			function() {
				console.log("업체검색")
				coCdDialog.dialog("open");
				$("#coCdModal").load(
						"${pageContext.request.contextPath}/modal/findCoCd",
						function() {
							coCdList()
						})
			});

	//제품검색 모달  
	let prdtCdDialog = $("#prdtCdModal").dialog({
		autoOpen : false,
		modal : true,
		width : 600,
		height : 600
	});

	$('#btnPrdtCdFind').on(
			'click',
			function() {
				console.log("제품검색")
				prdtCdDialog.dialog("open");
				$("#prdtCdModal").load(
						"${pageContext.request.contextPath}/modal/findPrdtCd",
						function() {
							prdtCdList()
						})
			});

	//계획 조회 그리드
	const planDgrid = new tui.Grid(
			{
				el : document.getElementById('planDgrid'),
				data : {
					api : {
						readData : {
							url : '${pageContext.request.contextPath}/grid/planGrid.do',
							method : 'GET'
						}
					},
					contentType : 'application/json',
					initialRequest : false
				//초기에 안보이게 함
				},
				scrollX : false,
				scrollY : true,
				bodyHeight : 500,
				columns : [ {
					header : '계획번호',
					name : 'planNo',
					align : 'center',
					sortingType : 'desc',
					sortable : true
				}, {
					header : '계획일자',
					name : 'planDt',
					align : 'center',
					sortingType : 'desc',
					sortable : true
				}, {
					header : '업체코드',
					name : 'coCd',
					align : 'center',
					sortingType : 'desc',
					sortable : true
				}, {
					header : '제품코드',
					name : 'prdtCd',
					align : 'center',
					sortingType : 'desc',
					sortable : true
				}, {
					header : '제품명',
					name : 'prdtNm',
					align : 'center'
				}, {
					header : '주문번호',
					name : 'orderNo',
					align : 'center',
					sortingType : 'desc',
					sortable : true
				}, {
					header : '납기일자',
					name : 'paprdDt',
					align : 'center',
					sortingType : 'desc',
					sortable : true
				}, {
					header : '주문량',
					name : 'orderQty',
					align : 'center',
					sortingType : 'desc',
					sortable : true
				}, {
					header : '계획량',
					name : 'planQty',
					align : 'center'
				}, {
					header : '작업일자',
					name : 'wkDt',
					align : 'center',
					sortingType : 'desc',
					sortable : true
				}, {
					header : '작업순서',
					name : 'wkOrd',
					align : 'center'
				}, ],
				summary : {
					position : 'bottom',
					height : 50,
					columnContent : {
						planDt : {
							template : function(summary) {
								return '합계:';
							},
							align : 'center'
						},
						orderQty : {
							template : function(summary) {
								return summary.sum;
							}
						},
						planQty : {
							template : function(summary) {
								return summary.sum;
							}
						}
					}
				}
			});

	//조회 버튼: 조건별(기간, 업체, 제품) 생산계획 조회
	$('#btnSearch')
			.click(
					function() {
						var startT = $("#startT").val().substring(0, 10);
						var endT = $("#startT").val().substring(13, 23);
						var coCd = document.getElementById('coCd').value
						var prdtCd = document.getElementById('prdtCd').value
						console.log(startT + "~" + endT + "& coCd:" + coCd
								+ "& prdtCd:" + prdtCd);
						var params = {
							'startT' : startT,
							'endT' : endT,
							'coCd' : coCd,
							'prdtCd' : prdtCd
						}
						$
								.ajax(
										{
											url : '${pageContext.request.contextPath}/grid/planGrid.do',
											data : params,
											dataType : "json",
											contentType : 'application/json; charset=utf-8',
										})
								.done(
										function(pln) {
											planDgrid
													.resetData(pln["data"]["contents"]);
										})
					})

	//초기화 버튼: 계획폼, 계획상세 그리드 초기화
	$('#btnReset').click(function() {
		searchFrm.reset();
		planDgrid.resetData([]);
	})

	planDgrid.on('onGridUpdated', function() {
		planDgrid.refreshLayout();
	});
	$('#senseIn').resize(function(){
		if($('#senseIn').width()<1780){
			$('#senseInBody').css('paddingLeft','15px');
		}else{
			$('#senseInBody').css('paddingLeft','40px');
		}
	})
	//Excel 버튼
</script>
</html>