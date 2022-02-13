<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


</head>

<body>
	<h1>주문서 조회</h1>
	<div class="row" id="senseOrder">
		<div id="senseOrderBody" class="card card-pricing card-primary card-white card-outline col-3" style="margin-left: 50px;margin-right: 30px;margin-top: 150px;padding-left: 40px;margin-bottom: 300px;">
		<div class="card-body"  >
	<div class="row">
		<div data-role="fieldcontain" class="col-12" style="margin-bottom: 20px; margin-top: 50px;">
			<label for="defandroid">주문일자</label> <input name="startT" class="dtp"
				id="startT" type="text" data-role="datebox"
				data-options='{"mode": "calbox"}'>
		</div>
	</div>

				<div style="margin-bottom: 20px;">			
				<label>자료구분</label> 
			<input type="radio" name="dateTy" value="접수" checked>접수일자
			<input type="radio" name="dateTy" value="납기">납기일자
			</div>
			<div >
			<label>진행상태</label>
			<select name="nowSt">
				<option value="진행">진행</option>
				<option value="종료">종료</option>
				<option value="모두">모두</option>
			</select>
		</div>
		
	

	</div>
			<div class="card-footer" style="margin-bottom: 30px;" >
		<button type="button" id="findgrid" style="margin-left:120px">조회</button>
	</div>
	</div>
	


	<div class="col-8" id="grid" style="margin-top:100px"></div>
	</div>
	<div id="dialog-form" title="주문 상세 목록"></div>




	<script type="text/javascript">

	
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
		  }, function(start, end, label) {
		  },
		  
		  );
		});
	
/* 		var d = new Date();
		var nd = new Date(d.getFullYear(), d.getMonth(), d.getDate() - 7);
		document.getElementById('startT').value = nd.toISOString().slice(0, 10);
		document.getElementById('endT').value = d.toISOString().slice(0, 10); */

		let dialog = $("#dialog-form").dialog({
			autoOpen : false,
			modal : true,
			width : 900,
			height : 570
		});
		const dataSource = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/grid/orderList.do',
					method : 'GET'
				}
			},

			contentType : 'application/json'
		};

		const grid = new tui.Grid({
			el : document.getElementById('grid'), // 컨테이너 엘리먼트
			data : dataSource,
			bodyHeight : 500,
			columns : [ {
				header : '주문번호',
				name : 'orderNo'
			}, {
				header : '접수일자',
				name : 'recvDt',
			}, {
				header : '업체명',
				name : 'coNm'
			}, {
				header : '납기일자',
				name : 'paprdDt',
			}, {
				header : '주문제품명',
				name : 'deNum'
			}, {
				header : '진행상황',
				name : 'progInfo'
			},

			],

		});
		grid.on('onGridUpdated', function() {
			$('td[data-column-name$="deNum"]').css('backgroundColor','#ffeeee');
			grid.refreshLayout();

		});
		grid
				.on(
						'click',
						function(ev) {
							 if (ev["columnName"] == "deNum"
									&& grid.getValue(ev["rowKey"], "deNum") != 0) {
								dialog.dialog("open");
								$("#dialog-form")
										.load(
												"${pageContext.request.contextPath}/modal/orderDetailList",
												function() {
													newgrid(grid.getValue(
															ev["rowKey"],
															"orderNo"));
													grid.refreshLayout();
												})
							} 
						});
		
		
		$('#findgrid').on('click',function(){
			
			var startT = $("#startT").val().substring(0,10);
			var endT = $("#startT").val().substring(13,23);
			var dateTy = $("input[name=dateTy]:checked").val();
			var nowSt = $("[name=nowSt] option:selected").val();
			
			var readParams ={
					'startT':startT,
					'endT':endT,
					'dateTy':dateTy,
					'nowSt':nowSt
			}
			
			grid.readData(1,readParams,true);
			grid.refreshLayout();
		})
		
		$('#senseOrder').resize(function(){
			if($('#senseOrder').width()<1780){
				$('#senseOrderBody').css('paddingLeft','20px');
			}else{
				$('#senseOrderBody').css('paddingLeft','40px');
			}
		})
		
	</script>

</body>
</html>