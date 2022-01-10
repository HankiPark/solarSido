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
	src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
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

	<div id="grid"></div>
	<div id="dialog-form" title="주문 상세 목록"></div>
	<script type="text/javascript">
		let dialog = $("#dialog-form").dialog({autoOpen:false,modal: true,width:900,height:700});
		const dataSource = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/grid/orderList.do',
					method : 'GET',
					cache : false
				}
			},

			contentType : 'application/json'
		};

		const grid = new tui.Grid({
			el : document.getElementById('grid'), // 컨테이너 엘리먼트
			data : dataSource,
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
				editor : {
					type : 'datePicker',
					options : {
						format : 'yyyy-MM-dd'
					}
				}
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
		grid.on('click', function(ev) {
			console.log(ev["columnName"]);
			if (ev["columnName"] == "deNum") {
				dialog.dialog("open");
				$("#dialog-form").load("${pageContext.request.contextPath}/modal/orderDetailList"
						 )
			}
		});
	</script>
</body>
</html>