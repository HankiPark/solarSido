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
			<option value="미진행">미공정</option> 	<!-- 공정이 시작되지 않은 지시 -->
			<option value="진행">공정진행</option>	<!-- 공정이 시작된 지시 -->
			<option value="전체">전체</option>		<!-- 전체 생산지시 상세 -->
		</select>
	</div>
	
	<!-- 미공정 생산지시서 조회 그리드 -->
	<div id="indicaGrid"></div>
	
	<!-- 생산지시 전체 기간별 조회 그리드 -->
	<div id="indicaListGrid" style="display: none">
		<label>계획기간</label>
		<input type="text" id="startT" name="startT">
		<button type="button" id="btnSearch">조회</button>
	</div>
</body>

<script type="text/javascript">
window.onload = function(){
}

function indicaList(){
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
	
	//공정진행별 지시서 조회 그리드
	const indicaGrid = new tui.Grid(
			{
				el : document.getElementById('indicaGrid'),
				data : {
					api : {
						readData : {
							url : '${pageContext.request.contextPath}/grid/findIndica.do',
							method : 'GET',
						}
					},
					contentType : 'application/json'
				},
				bodyHeight : 300,
				columns : [ {
					header : '생산지시번호',
					name : 'indicaNo'
				}, {
					header : '지시일자',
					name : 'indicaDt'
				}, {
					header : '생산지시명',
					name : 'indicaNm'
				}]
			});

	//공정진행별 지시서 조회 그리드 이벤트
	indicaGrid.on('dblclick', function(ev) {
		nowSt = $("#nowSt option:selected").val();
		if(nowSt == '미진행') {
			$('#indicaNo').val(indicaGrid.getValue(ev.rowKey, "indicaNo"));
			$('#indicaDt').val(indicaGrid.getValue(ev.rowKey, "indicaDt"));
			$('#indicaNm').val(indicaGrid.getValue(ev.rowKey, "indicaNm"));
			
			var indicaNo = indicaGrid.getValue(ev.rowKey, "indicaNo")
			var params = {
					'indicaNo': indicaNo
			}
			$.ajax({
				url : '${pageContext.request.contextPath}/grid/searchIndica.do',
				data : params,
				dataType:"json",
				contentType : 'application/json; charset=utf-8',
			}).done(function(idc) {
				indicaDgrid.resetData(idc.data);
			}).fail(function(reject){
			})
		indicaDialog.dialog("close");
		}
	});
	
	indicaGrid.on('onGridUpdated', function() {
		indicaGrid.refreshLayout();
	});
	
	//생산지시 상세 그리드
	const indicaListGrid = new tui.Grid({
		el: document.getElementById('indicaListGrid'),
		data: {
			  api: {
			    	readData: { url: '${pageContext.request.contextPath}/grid/indicaGrid.do', 
						    	method: 'GET'
			    				},
					}, 
				contentType: 'application/json',
				initialRequest: false //초기에 안보이게 함
			},
		scrollX: false,
		scrollY: true,
		bodyHeight: 300,
		columns: [
					 {
					    header: '지시상세번호',
					    name: 'indicaDetaNo',
					    align: 'center',
					    hidden: true
					  },
					  {
					    header: '지시번호',
					    name: 'indicaNo',
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
					    header: '지시량',
					    name: 'indicaQty',
					    align: 'center'
					  },
					  {
					    header: '생산구분',
					    name: 'prodFg',
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
					  },
			 		 ],
			 		summary: {
				        position: 'bottom',
				        height: 50,
				        columnContent: {
				        	indicaDt: {
				        		template: function(summary) {
				        			return '합계';
				        			},
				        		align:'center'
							},
							orderQty: {
								template: function(summary) {
									return summary.sum;
									}
							},
							indicaQty: {
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
				url : '${pageContext.request.contextPath}/grid/indicaGrid.do',
				data : params,
				dataType:"json",
				contentType : 'application/json; charset=utf-8',
			}).done(function(pln) {
				indicaListGrid.resetData(pln["data"]["contents"]);
			})
		})
		
		indicaListGrid.on('onGridUpdated', function() {
			indicaListGrid.refreshLayout();
		});
		
		$("#nowSt").change(function(){
			// 선택한 option의 value
			nowSt = $("#nowSt option:selected").val();
			
			if (nowSt == '미진행' || nowSt == '진행'){
				$("#indicaGrid").css("display", "block");
				$("#indicaListGrid").css("display", "none");
				var params = {
						'nowSt': nowSt
				}
				$.ajax({
					url : '${pageContext.request.contextPath}/grid/findIndica.do',
					data : params,
					dataType:"json",
					contentType : 'application/json; charset=utf-8',
				}).done(function(pln) {
					indicaGrid.resetData(pln["data"]["contents"]);
				})
			} else {
				$("#indicaGrid").css("display", "none");
				$("#indicaListGrid").css("display", "block");
			}
		})
}
</script>

</html>