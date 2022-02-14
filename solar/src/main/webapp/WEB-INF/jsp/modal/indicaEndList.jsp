<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<!-- 생산지시 전체 기간별 조회 그리드 -->
	<div id="indicaListGrid">
		<label>작업지시기간</label>
		<input type="text" id="startT" name="startT">
		<button type="button" id="btnSearch">조회</button>
	</div>

</body>

<script type="text/javascript">
window.onload = function(){
}

function endList(){
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
	
	
	//공정진행별 지시서 조회 그리드
	
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
					  },
					  {
					    header: '제품코드',
					    name: 'prdtCd',  
					    align: 'center',
					  },		  
					  {
					    header: '제품명',
					    name: 'prdtNm',
				    	align: 'center'
					  },
					  {
					    header: '지시량',
					    name: 'indicaQty',
					    align: 'center'
					  },
					  {
					    header: '작업일자',
					    name: 'wkDt',
					    align: 'center',
					  }
			 		 ],

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

		
		indicaListGrid.on('dblclick',function(ev){
			$("#indicaNo").val(indicaListGrid.getValue(ev["rowKey"],"indicaNo"));
			dialog.dialog("close");
			
		})
		
		
}
</script>
</html>