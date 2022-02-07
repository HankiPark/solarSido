<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산지시조회</title>
<style>
input#noing {
display : none;
}

input#inding {
display : none;
}

input#noing+label{
display: inline-block;
        width: 15px;
        height: 15px;
        border:3px solid #e37c6b;
        margin-bottom:0px;
               position: relative;
      
}
input#noing:checked + label::after{
        content:'✔';
        font-size: 12px;
        width: 12px;
        height: 12px;
position: absolute;
		top:-3.5px;
		left:0;
        background-color: #e37c6b;
        color:#fff;
         margin-bottom:0px;
      }
input#inding+label{
display: inline-block;
        width: 15px;
        height: 15px;
        border:3px solid #e37c6b;
        margin-bottom:0px;
               position: relative;
      
}
input#inding:checked + label::after{
        content:'✔';
        font-size: 12px;
        width: 12px;
        height: 12px;
position: absolute;
		top:-3px;
		left:0px;
        background-color: #e37c6b;
        color:#fff;
         margin-bottom:0px;
      }
</style>
</head>

<body>
<h2>생산지시조회</h2>
<hr/>

<!-- 검색모달 -->
<div id="coCdModal" title="업체 목록"></div>
<div id="prdtCdModal" title="제품 목록"></div>

<!-- 검색테이블 -->
<div class="row" id="senseIn">
	<div id="senseInBody" class="card card-pricing card-primary card-white card-outline col-3"
			style="margin-left: 50px; margin-right: 30px; margin-top: 150px; padding-left: 40px; margin-bottom: 300px; height: 400px">
			<div class="card-body">
				<form action="searchFrm" name="searchFrm">
					<input type="hidden" id="indicaNo" name="indicaNo" value="indicaNo">
					<div style="margin-bottom: 20px; margin-top: 50px;">
						<label>지시일&nbsp;&nbsp;&nbsp;&nbsp;</label> 
						<input type="text" id="startT" name="startT" class="dtp">
					</div>
					<div style="margin-bottom: 20px;">
						<label>업체코드</label> 
						<input type="text" id="coCd" name="coCd" readonly>
						<button type="button" id="btnCoCdFind">🔍</button>
					</div>
					<div style="margin-bottom: 20px;">
						<label>제품코드</label> 
						<input type="text" id="prdtCd" name="prdtCd" readonly>
						<button type="button" id="btnPrdtCdFind">🔍</button>
					</div>
					<div data-role="fieldcontain" style="margin-bottom: 20px;">
						<label>진행상태&nbsp;&nbsp;&nbsp;</label> 
						<label><input type="checkbox" name="nowSt" id="noing" value="미진행">
								<label for="noing"></label>미공정</label> 
						<label><input type="checkbox" id="inding" name="nowSt" value="진행">
								<label for="inding"></label>공정진행</label>
					</div>
				</form>
			</div>

			<div class="card-footer" style="margin-bottom: 30px;">
					<button type="button" id="btnSearch">조회</button>
					<button type="button" id="btnReset">초기화</button>
			</div>
		</div>

<!-- 생산지시 상세 그리드-->
	<div class="col-8" style="margin-top: 50px;">
		<button style="width: 100px; height: 40px; font-size: 20px; border-radius: 5px;boxShadow:2px 2px 2px #74a3b0; padding: 6px 1px 6px 3px" type="button" id="btnExcel" class="float-right"><i class="far fa-file-excel"></i>&nbsp;Excel</button>
		<div id="indicaDgrid"></div>
	</div>
</div>
</body>

<!-- 스크립트 -->
<script type="text/javascript">
	let coCd;
	let prdtCd;
	
	$(function() {
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
			console.log("A new date selection was made: " + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD'));
			}
		);
	});

	//업체검색 모달
	let coCdDialog = $("#coCdModal").dialog({
		autoOpen: false,
		modal: true,
		height: 600,
		width: 600
	});

	$("#btnCoCdFind").on("click", function(){
		console.log("업체검색")
		coCdDialog.dialog("open");
		$("#coCdModal").load("${pageContext.request.contextPath}/modal/findCoCd", function(){ coCdList() })
	});

 	//제품검색 모달  
 	let prdtCdDialog = $("#prdtCdModal").dialog({
		autoOpen : false,
		modal : true,
		width : 600,
		height : 600
	});
  
 	$('#btnPrdtCdFind').on('click', function(){
 		console.log("제품검색")
		prdtCdDialog.dialog("open");
		$("#prdtCdModal").load("${pageContext.request.contextPath}/modal/findPrdtCd", function(){ prdtCdList() })
	});

 	//지시 조회 그리드
	const indicaDgrid = new tui.Grid({
		el: document.getElementById('indicaDgrid'),
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
		bodyHeight: 500,
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
					    align: 'center'
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
	
	//조회 버튼: 조건별(기간, 업체, 제품) 생산지시 조회
	$('#btnSearch').click(function() {
		var startT = $("#startT").val().substring(0,10);
		var endT = $("#startT").val().substring(13,23);
		var coCd = document.getElementById('coCd').value
		var prdtCd = document.getElementById('prdtCd').value
		if($("input:checkbox[name=nowSt]:checked").length==2){
			var nowSt = null;
		}else{
			var nowSt = $('input:checkbox[name=nowSt]:checked').val();
		}
		var params = {
				'startT': startT,
				'endT': endT,
				'coCd': coCd,
				'prdtCd': prdtCd,
				'nowSt' : nowSt
		}
		$.ajax({
			url : '${pageContext.request.contextPath}/grid/indicaGrid.do',
			data : params,
			dataType:"json",
			contentType : 'application/json; charset=utf-8',
		}).done(function(pln) {
			indicaDgrid.resetData(pln["data"]["contents"]);
		})
	})
	
	//초기화 버튼: 지시폼, 지시상세 그리드 초기화
	$('#btnReset').click(function() {
		searchFrm.reset();
		indicaDgrid.resetData([]);
	})
			
	indicaDgrid.on('onGridUpdated', function() {
		indicaDgrid.refreshLayout();
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