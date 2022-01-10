<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

<link rel="stylesheet"
	href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
</head>

<body>
	<h2>주문서 참조</h2>
	<div class="row">
		<div data-role="fieldcontain" class="col-6">
			<label for="defandroid">날짜 선택</label> <input name="startT"
				id="startT" type="date" data-role="datebox"
				data-options='{"mode": "calbox"}'> ~ <input name="endT"
				id="endT" type="date" data-role="datebox"
				data-options='{"mode": "calbox"}'> 
				</div>
				<div data-role="fieldcontain" class="col-4">
			<label>자료구분</label>
			<input type="radio" name="dateTy" value="접수" checked>접수일자
			<input type="radio" name="dateTy" value="납기">납기일자
			</div><div data-role="fieldcontain" class="col-2">
			<label>진행상태</label>
			<select name="nowSt">
				<option value="진행">진행</option>
				<option value="종료">종료</option>
				<option value="모두">모두</option>
			</select>
		</div>
		
		
		</div>
		<div>
		<button type="button" id="findgrid">조회</button>
	</div>
	<div id="grid"></div>
	<div id="dialog-form" title="주문 상세 목록"></div>




	<script type="text/javascript">
	
	
		var d = new Date();
		var nd = new Date(d.getFullYear(), d.getMonth(), d.getDate() - 7);
		document.getElementById('startT').value = nd.toISOString().slice(0, 10);
		document.getElementById('endT').value = d.toISOString().slice(0, 10);

		let dialog = $("#dialog-form").dialog({
			autoOpen : false,
			modal : true,
			width : 900,
			height : 700
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
			bodyHeight : 700,
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
				header : '상세주문',
				name : 'deNum'
			}, {
				header : '진행상황',
				name : 'progInfo'
			},

			],

		});
		grid.on('onGridUpdated', function() {
			grid.refreshLayout();
		});
		grid
				.on(
						'click',
						function(ev) {
							console.log(ev["rowKey"]);
							console.log(grid.getValue(ev["rowKey"], "orderNo"));
							if (ev["columnName"] == "deNum"
									&& grid.getValue(ev["rowKey"], "deNum") != 0) {
								dialog.dialog("open");
								$("#dialog-form")
										.load(
												"${pageContext.request.contextPath}/modal/orderDetailList",
												function() {
													newgrid(grid.getValue(
															ev["rowKey"],
															"orderNo"))
												})
							}
						});
		
		
		$('#findgrid').on('click',function(){
			
			var startT = $("#startT").val();
			var endT = $("#endT").val();
			var dateTy = $("input[name=dateTy]").val();
			var nowSt = $("[name=nowSt] option:selected").val();
			console.log(dateTy);
			
			var readParams ={
					'startT':startT,
					'endT':endT,
					'dateTy':dateTy,
					'nowSt':nowSt
			}
			
			grid.readData(1,readParams,true);
		})
		
		
		
	</script>
	<script
		src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
</body>
</html>