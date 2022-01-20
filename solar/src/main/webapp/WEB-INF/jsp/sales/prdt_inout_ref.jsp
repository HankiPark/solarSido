<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
* {
	margin: 0;
	padding: 0;
}

ul {
	list-style: none;
}

a {
	text-decoration: none;
	color: #333;
}

.wrap {
	padding: 15px;
	letter-spacing: -0.5px;
}

.tab_menu .list {
	overflow: hidden;
}

.tab_menu .list li {
	float: left;
	margin-right: 14px;
}

.tab_menu .list .btn {
	font-size: 13px;
}

.tab_menu .list li.is_on .btn {
	font-weight: bold;
	color: green;
}

.tab_menu .list li.is_on .cont {
	display: block;
}

#oG {
	display: none;
}
</style>
</head>
<body>
	<h2>제품 입/출고조회</h2>
	<div class="row">
		<div data-role="fieldcontain" class="col-4">
			<label for="defandroid">날짜 선택</label> <input name="startT"
				id="startT" type="date" data-role="datebox"
				data-options='{"mode": "calbox"}'> ~ <input name="endT"
				id="endT" type="date" data-role="datebox"
				data-options='{"mode": "calbox"}'>
		</div>
		<div data-role="fieldcontain" class="col-2">
		<label>제품구분</label>
			<label><input type="checkbox" name="ref" value="I">입고</label>
			<label><input type="checkbox" name="ref" value="O">출고</label>
		</div>
		<div data-role="fieldcontain" class="col-2">
			<label>제품명</label> <input type="text" id="prdNm">
		</div>
		<div data-role="fieldcontain" class="col-2" style="display:none">
			<label>회사명</label> <input type="text" id="coNm">
		</div>
	</div>
	<button type="button" id="findgrid">조회</button>
	
	
	<div id="Grid"></div>







	<script type="text/javascript">
	
	var d = new Date();
	var nd = new Date(d.getFullYear(), d.getMonth(), d.getDate() - 7);
	document.getElementById('startT').value = nd.toISOString().slice(0, 10);
	document.getElementById('endT').value = d.toISOString().slice(0, 10);
	
	//제품이름검색시
	$('#prdNm')
	.on(
			'click',
			function() {
				dialog.dialog("open");
				$("#dialog-form")
						.load(
								"${pageContext.request.contextPath}/modal/prdtNmList",
								function() {
									NmList()
								})
			});
	
	const Grid = new tui.Grid(
			{
				el : document.getElementById('Grid'), // 컨테이너 엘리먼트
				data : {
					api : {
						readData : {
							url : '${pageContext.request.contextPath}/grid/prdtInput.do',
							method : 'GET'
						}
					},
					initialRequest : false,
					contentType : 'application/json'
				},

				bodyHeight : 700,
				rowHeaders : [ {
					type : 'rowNum',
					width : 100,
					align : 'left',
					valign : 'bottom'
				}, {
					type : 'checkbox'
				} ],
				columns : [ {
					header : 'index',
					name : 'prdtInx',
					hidden : true
				}, {
					header : '입고일자',
					name : 'prdtDt',
					editor : 'datePicker',
					 validation: {
					        required: true
					      }
				}, {
					header : '제품LOT',
					name : 'prdtLot',
					editor : 'text',
					validation: {
				        required: true,
				        unique : true
				      }
				}, {
					header : '제품코드',
					name : 'prdtCd'
				}, {
					header : '제품명',
					name : 'prdtNm',
				}, {
					header : '규격',
					name : 'prdtSpec'
				}, {
					header : '생산지시번호',
					name : 'indicaNo'
				}

				],
				

			});
	
	
	
	</script>
</body>
</html>