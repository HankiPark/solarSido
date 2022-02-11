<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원관리</title>

</head>
<body>
	<h1>사원 관리</h1>
	<div>

		<div class="row" id="senseOrder">
			<div id="senseOrderBody"
				class="card card-pricing card-primary card-white card-outline col-3"
				style="margin-left: 50px; margin-right: 30px; margin-top: 170px; padding-left: 40px;padding-top:50px; height: 300px;">
				<div class="card-body">
					<div style="margin-bottom: 20px; margin-top: 50px;">
						<label>사원명&nbsp;&nbsp;&nbsp;&nbsp;</label> <input type="text" id="empNminfo">
						<button type="button" id="btnfind">🔍</button>
					</div>
				</div>
			</div>
			<div class="col-8">
				<div class="float-right">
					<button type="button" id="btnAdd" style="margin-bottom:10px">추가</button>
					<button type="button" id="btnDel" style="margin-bottom:10px">삭제</button>
					<button type="button" id="btnSave" style="margin-bottom:10px">저장</button>
				</div>
				<div id="grid"></div>
			</div>
			<!-- <div id="dialog-form" title="사원명단"></div>  -->

			<script>
				var dataSource = {
					api : {
						readData : {
							url : '${pageContext.request.contextPath}/grid/empList.do',
							method : 'GET'
						},
						modifyData : {
							url : '${pageContext.request.contextPath}/grid/empModify.do',
							method : 'POST'
						}
					},
					/*				initialRequest : false, // 조회버튼 누르면 값을 불러오겠다 */
					contentType : 'application/json'
				};

				var grid = new tui.Grid({
					el : document.getElementById('grid'),
					data : dataSource,
					scrollY : true,
					rowHeaders : [ 'rowNum', 'checkbox' ],
					bodyHeight : 500,
					minBodyHeight : 500,
					columns : [ {
						header : '아이디',
						name : 'empId',
						editor : 'text',
						sortable : true
					}, {
						header : '비밀번호',
						name : 'empPw',
						hidden : true
					}, {
						header : '사원명',
						name : 'empNm',
						editor : 'text'
					}, {
						header : '사원번호',
						name : 'empNo',
						editor : 'text'
					}, {
						header : '부서',
						name : 'dept',
						editor : 'text'
					}, {
						header : '직책',
						name : 'wkdty',
						editor : 'text'
					}, {
						header : '전화',
						name : 'phone',
						editor : 'text'
					}, {
						header : '이메일',
						name : 'email',
						editor : 'text'
					}, {
						header : '입사일',
						name : 'hireDate',
						editor : 'datePicker'
					} ]
				});

				grid.on('onGridUpdated', function() {
					grid.refreshLayout();
				});

				grid.on('response', function(ev) {
					let res = JSON.parse(ev.xhr.response);
					if (res.mode == 'upd') {
						grid.resetOriginData();
					} else {
						grid.refreshLayout()
					}
				});

				$('#btnAdd').on('click', function appendRow(index) {
					grid.appendRow({}, {
						extendPrevRowSpan : true,
						focus : true,
						at : 0
					});
				});
				$('#btnSave').on('click', function appendRow(index) {
					grid.blur();
					grid.request('modifyData');
				});
				$('#btnDel').on('click', function appendRow(index) {
					grid.blur();
					grid.removeCheckedRows(true);
				});

				$('#btnfind')
						.on(
								'click',
								function() {
									var empNm = $("#empNminfo").val();
									var parameter = {
										'empNm' : empNm
									}
									$
											.ajax(
													{
														url : '${pageContext.request.contextPath}/grid/empdataFind',
														data : parameter,
														contentType : 'application/json; charset=utf-8'
													})
											.done(
													function(res) {
														var info = JSON
																.parse(res);
														grid
																.resetData(info["data"]["contents"]);
													})

								});
			</script>
</body>
</html>