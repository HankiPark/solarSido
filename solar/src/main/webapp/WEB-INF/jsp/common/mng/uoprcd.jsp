<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비가동코드 관리</title>
</head>
<body>
	<h1>비가동코드 관리</h1>
	<div class="row" id="senseOrder">
		<div id="senseOrderBody"
			class="card card-pricing card-primary card-white card-outline col-3"
			style="margin-left: 50px; margin-right: 30px; margin-top: 200px; padding-left: 40px; margin-bottom: 300px;">
			<div class="card-body">


				<div style="margin-bottom: 20px; margin-top: 100px;">
					<label>비가동명</label> <input type="text" id="uoprNminfo">
					<button type="button" id="btnfind">🔍</button>
				</div>
				</div>
				</div>
				<div class="col-8">
					<div class="float-right">
						<button type="button" id="btnAdd" style="margin-bottom: 10px">추가</button>
						<button type="button" id="btnDel" style="margin-bottom: 10px">삭제</button>
						<button type="button" id="btnSave" style="margin-bottom: 10px">저장</button>
					</div>
					<div id="grid"></div>
				</div>
				<div id="dialog-form" title="공정명단"></div>

				<script>
					let dialog = $("#dialog-form").dialog({
						autoOpen : false,
						modal : true,
						width : 700,
						height : 700
					});
					toastr.options = {
						"closeButton" : false,
						"debug" : false,
						"newestOnTop" : false,
						"progressBar" : true,
						"positionClass" : "toast-top-right",
						"preventDuplicates" : false,
						"onclick" : null,
						"showDuration" : "100",
						"hideDuration" : "1000",
						"timeOut" : "2000",
						"extendedTimeOut" : "1000",
						"showEasing" : "swing",
						"hideEasing" : "linear",
						"showMethod" : "fadeIn",
						"hideMethod" : "fadeOut"
					}

					function SaveComplete() {
						toastr.success('데이터가 수정되었습니다.');
					}
					function SaveFail() {
						toastr.error('저장실패');
					}
					function DeleteComplete() {
						toastr.success('해당 데이터 삭제완료 저장 해주세요.');
					}
					function DeleteFail() {
						toastr.error('삭제실패');
					}
					function ResetComplete() {
						toastr.info('상세 데이터 리셋 완료 데이터를 입력해주세요');
					}
					function insertComplete() {
						toastr.success('등록완료');
					}
					function insertFail() {
						toastr.error('등록실패 빈 값이 있는지 확인해주세요.');
					}
					function updateFail() {
						toastr.error('수정실패, 값을 확인해주세요.');
					}
					function updateComplete() {
						toastr.success('수정완료');
					}
					function datawarning() {
						toastr.warning('데이터 입력오류 정확한 값을 입력해주세요');
					}
					var dataSource = 
					{
						api : {
							readData : {
								url : '${pageContext.request.contextPath}/grid/uoprcdList.do',
								method : 'GET'
							},
							modifyData : {
								url : '${pageContext.request.contextPath}/grid/uoprcdUpdate.do',
								method : 'POST',
								cache : false
							}
						},
						contentType : 'application/json'
					};

					var grid = new tui.Grid({
						el : document.getElementById('grid'),
						data : dataSource,
						scrollX : true,
						scrollY : true,
						rowHeaders : [ 'rowNum', 'checkbox' ],
						bodyHeight : 700,
						columns : 
						[ 
							{
								header : '비가동코드',
								name : 'uoprCd',
								sortable : true
							},
							{
								header : '비가동명',
								name : 'uoprNm',
								editor : 'text'
							}, 
							{
								header : '비가동내역',
								name : 'uoprDesct',
								editor : 'text'
							},
							{
								header : '발생공정코드',
								name : 'prcsCd'
							}, 
							{
								header : '발생공정명',
								name : 'prcsNm'
							} 
						]
					});

					grid.on('onGridUpdated', function() {

						grid.refreshLayout(); //변경된 데이터로 확정

					});

					grid.on('response', function(ev) { // 성공/실패와 관계 없이 응답을 받았을 경우
						console.log(ev);
						let res = JSON.parse(ev.xhr.response);
						if (res.mode == 'upd') {
							grid.resetOriginData();
							grid.refreshLayout();
							grid.readData(1, {}, true);
						}
					});

					grid
							.on(
									'click',
									function(ev) {
										if (ev["columnName"] == "prcsCd") {
											dialog.dialog("open");
											$("#dialog-form")
													.load(
															"${pageContext.request.contextPath}/modal/prcsinfoList",
															function() {
																prcsinfoList(ev["rowKey"]);
																grid
																		.refreshLayout();
															})
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
						SaveComplete();
					});
					$('#btnDel').on('click', function appendRow(index) {
						grid.blur();
						grid.removeCheckedRows(true);
						DeleteComplete();
					});

					$('#btnfind')
							.on(
									'click',
									function() {
										var uoprNm = $("#uoprNminfo").val();
										var parameter = {
											'uoprNm' : uoprNm
										}
										$
												.ajax(
														{
															url : '${pageContext.request.contextPath}/grid/uoprcddataFind',
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

					$('#senseOrder').resize(function() {
						if ($('#senseOrder').width() < 1780) {
							$('#senseOrderBody').css('paddingLeft', '20px');
						} else {
							$('#senseOrderBody').css('paddingLeft', '40px');
						}
					})
				</script>
</body>
</html>