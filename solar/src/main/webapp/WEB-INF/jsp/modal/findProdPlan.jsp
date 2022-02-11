<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<label>진행상태</label>
		<select id="nowSt" name="nowSt">
			<option value="미진행">미지시</option> 	<!-- 지시가 내려지지 않은 계획 -->
			<option value="진행">지시진행</option>	<!-- 지시가 내려진 계획 -->
			<option value="전체">전체</option>		<!-- 전체 생산계획 상세 -->
		</select>
	</div>
	
	<!-- 미지시 계획서 조회 그리드 -->
	<div id="prodPlanGrid"></div>
	
	<!-- 생산계획 전체 기간별 조회 그리드 -->
	<div id="planListGrid" style="display: none">
		<label>계획기간</label>
		<input type="text" id="startT" name="startT">
		<button type="button" id="btnSearch">조회</button>
	</div>
</body>

<script type="text/javascript">
window.onload = function(){
}

function planList(){
	$('input[name="startT"]').daterangepicker({
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
		}, 
	function(start, end, label) {
		}
	)
	
	let nowSt = $("#nowSt option:selected").val();
	
	//지시진행별 계획서 조회 그리드 
	const prodPlanGrid = new tui.Grid(
			{
				el : document.getElementById('prodPlanGrid'),
				data : {
					api : {
						readData : {
							url : '${pageContext.request.contextPath}/grid/findProdPlan.do',
							method : 'GET',
							initParams : { 
								nowSt: 'nowSt'
							}
						}
					},
					contentType : 'application/json'
				},
				bodyHeight : 300,
				columns : [ {
					header : '생산계획번호',
					name : 'planNo'
				}, {
					header : '계획일자',
					name : 'planDt'
				}, {
					header : '생산계획명',
					name : 'planNm'
				}]
			});
	
	//지시진행별 계획서 조회 그리드 이벤트
	prodPlanGrid.on('dblclick', function(ev) {
		nowSt = $("#nowSt option:selected").val();
		if(nowSt == '미진행') {
			$('#planNo').val(prodPlanGrid.getValue(ev.rowKey, "planNo"));
	 		$('#planDt').val(prodPlanGrid.getValue(ev.rowKey, "planDt"));
			$('#planNm').val(prodPlanGrid.getValue(ev.rowKey, "planNm")); 
			
			var planNo = prodPlanGrid.getValue(ev.rowKey, "planNo")
			var params = {
					'planNo': planNo
			}
			$.ajax({
				url : '${pageContext.request.contextPath}/grid/searchPlan.do',
				data : params,
				dataType:"json",
				contentType : 'application/json; charset=utf-8',
			}).done(function(pln) {
				planDgrid.resetData(pln.data);
			}).fail(function(reject){
			})
		prodPlanDialog.dialog("close");
		}
	});
	
	prodPlanGrid.on('onGridUpdated', function() {
		prodPlanGrid.refreshLayout();
	});
	
	//생산계획 상세 그리드
	const planListGrid = new tui.Grid({
		el: document.getElementById('planListGrid'),
		data: {
			  api: {
			    	readData: { url: '${pageContext.request.contextPath}/grid/planGrid.do', 
						    	method: 'GET'
			    				}
					}, 
				contentType: 'application/json',
				initialRequest: false //초기에 안보이게 함
			},
		scrollX: false,
		scrollY: true,
		bodyHeight: 300,
		columns: [
					  {
					    header: '계획번호',
					    name: 'planNo',
					    align: 'center',
					    sortingType: 'desc',
				        sortable: true
					  },
					  {
					    header: '계획일자',
					    name: 'planDt',
					    align: 'center',
				    	sortingType: 'desc',
				        sortable: true
					  },
					  {
					    header: '업체코드',
					    name: 'coCd',
					    align: 'center',
				    	sortingType: 'desc',
				        sortable: true
					  },
					  {
					    header: '제품코드',
					    name: 'prdtCd',
					    align: 'center',
				    	sortingType: 'desc',
				        sortable: true
					  },		  
					  {
					    header: '제품명',
					    name: 'prdtNm',
					    align: 'center'
					  },
					  {
					    header: '주문번호',
					    name: 'orderNo',
					    align: 'center',
				    	sortingType: 'desc',
				        sortable: true
					  },
					  {
					    header: '납기일자',
					    name: 'paprdDt',
					    align: 'center',
					    sortingType: 'desc',
				        sortable: true
					  },
					  {
					    header: '주문량',
					    name: 'orderQty',
					    align: 'center',
					    sortingType: 'desc',
				        sortable: true
					  },
					  {
					    header: '계획량',
					    name: 'planQty',
					    align: 'center'
					  },
					  {
					    header: '작업일자',
					    name: 'wkDt',
					    align: 'center',
					    sortingType: 'desc',
				        sortable: true
					  },
					  {
					    header: '작업순서',
					    name: 'wkOrd',
					    align: 'center',
					    hidden: true
					  }],
 		summary: {
	        position: 'bottom',
	        height: 50,
	        columnContent: {
	        	planDt: {
	        		template: function(summary) {
	        			return '합계:';
	        			},
	        		align:'center'
				},
				orderQty: {
					template: function(summary) {
						return summary.sum;
						}
				},
				planQty: {
					template: function(summary) {
						return summary.sum;
						}
				}
	        }
	    }
	});
	
	//검색버튼
	$('#btnSearch').click(function() {
		var startT = $("#startT").val().substring(0,10);
		var endT = $("#startT").val().substring(13,23);
		var params = {
				'startT': startT,
				'endT': endT
		}
		$.ajax({
			url : '${pageContext.request.contextPath}/grid/planGrid.do',
			data : params,
			dataType:"json",
			contentType : 'application/json; charset=utf-8',
		}).done(function(pln) {
			planListGrid.resetData(pln["data"]["contents"]);
		})
	})
	
	planListGrid.on('onGridUpdated', function() {
		planListGrid.refreshLayout();
	});

	$("#nowSt").change(function(){
		// 선택한 option의 value
		var nowSt = $("#nowSt option:selected").val();
		
		if (nowSt == '미진행' || nowSt == '진행'){
			$("#prodPlanGrid").css("display", "block");
			$("#planListGrid").css("display", "none");
			var params = {
					'nowSt': nowSt
			}
			$.ajax({
				url : '${pageContext.request.contextPath}/grid/findProdPlan.do',
				data : params,
				dataType:"json",
				contentType : 'application/json; charset=utf-8',
			}).done(function(pln) {
				prodPlanGrid.resetData(pln["data"]["contents"]);
			})
		} else {
			$("#prodPlanGrid").css("display", "none");
			$("#planListGrid").css("display", "block");
		}
	})
}
</script>

</html>