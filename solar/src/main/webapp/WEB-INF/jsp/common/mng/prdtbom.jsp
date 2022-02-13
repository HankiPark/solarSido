<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품BOM 관리</title>
</head>
<body>
	<h2>제품 BOM 관리</h2>
	<div class="row" id="senseOrder">
		<div id="senseOrderBody"
			class="card card-pricing card-primary card-white card-outline col-3"
			style="margin-left: 50px; margin-right: 30px; margin-top: 150px; padding-left: 40px; margin-bottom: 300px;">
			<div class="card-body">

				<div style="margin-bottom: 20px; margin-top: 50px;">
					<label>제품코드</label><input type="text" id="prdtCd">
				</div>
				<div style="margin-bottom: 20px;">
					<label>제품명 &nbsp;&nbsp;&nbsp;</label><input type="text" id="prdtNm"
						readonly="readonly">
				</div>
				<div style="margin-bottom: 20px;">
					<label>규격&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><input type="text" id="prdtSpec"
						readonly="readonly">
				</div>


			</div>
			<div class="card-footer" style="margin-bottom: 30px;">
				<button type="button" id="btnfindinfo" style="margin-left: 120px">조회</button>
			</div>
		</div>
		
			<div class="col-8" style="margin-top:40px">
			<div class="float-right" style="margin-bottom:10px">
				<button type="button" id="btnAdd">추가</button>
				<button type="button" id="btnDel">삭제</button>
				<button type="button" id="btnSave">저장</button>
				<button type="button" id="btnReset">초기화</button>
			</div>
			<div id="grid"></div>
		</div>
	</div>
	</div>

	

	<div id="dialog-form"></div>

	<div id="dialog-form2"></div>

	<div id="dialog-form3"></div>
	<script>
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
			toastr.success('데이터가 수정되었습니다');
		}
		function SaveFail() {
			toastr.error('저장실패');
		}
		function DeleteComplete() {
			toastr.success('체크 한 행의 데이터가 삭제되었습니다, 저장해주세요.');
		}
		function DeleteFail() {
			toastr.error('삭제실패');
		}
		function ResetComplete() {
			toastr.info('리셋 완료.');
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

		let prdtGrid;

		let dialog = $("#dialog-form").dialog({
			autoOpen : false,
			modal : true,
			width : 700,
			height : 700
		});

		let dialog2 = $("#dialog-form2").dialog({
			autoOpen : false,
			modal : true,
			width : 700,
			height : 700
		});

		let dialog3 = $("#dialog-form3").dialog({
			autoOpen : false,
			modal : true,
			width : 700,
			height : 700
		});

		var dataSource = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/grid/prdtbomList.do',
					method : 'GET'
				},
				modifyData : {
					url : '${pageContext.request.contextPath}/grid/prdtbomUpdateIn.do',
					method : 'POST'
				}
			},

			contentType : 'application/json'
		};

		var grid = new tui.Grid({
			el : document.getElementById('grid'),
			data : dataSource,
			pageOptions : {
				useClient : true,
				perPage : 60
			},
			bodyHeight : 500,
			minBodyHeight : 500,
			rowHeaders : [ 'rowNum', 'checkbox' ],
			columns : 
		[ 	
			{
				header : '제품코드',
				name : 'prdtCd',
				align : 'center',
				editor : 'text',
				rowSpan : true
			}, 
			{
				header : '자재코드',
				name : 'rscCd',
				align : 'center',
			}, 
			{
				header : '자재명',
				name : 'rscNm',
				align : 'center',
			}, 
			{
				header : '사용량',
				name : 'rscUseQty',
				editor : 'text',
				align : 'center'
			}, 
			{
				header : '사용공정명',
				name : 'prcsNm',
				align : 'center'
			}, 
			{
				header : '규격',
				name : 'prdtSpec',
				editor : 'text',
				align : 'center'
			} 
			],
			draggable: true
		});

		grid.on('onGridUpdate', function() {
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
			SaveComplete();
		});
		$('#btnDel').on('click', function appendRow(index) {
			grid.blur();
			grid.removeCheckedRows(true);
			DeleteComplete();
		});

		$('#btnfindinfo').on('click', function() {
			var prdtCd = $("#prdtCd").val();
			var parameter = {
				'prdtCd' : prdtCd
			}
			$.ajax({
				url : '${pageContext.request.contextPath}/grid/prdtbomSearch',
				data : parameter,
				contentType : 'application/json; charset=utf-8'
			}).done(function(res) {
				var info = JSON.parse(res);
				grid.resetData(info["data"]["contents"]);
			})

		});

		$('#btnReset').on('click', function() {
			grid.clear();
			$('#prdtCd').val('');
			$('#prdtNm').val('');
			$('#prdtSpec').val('');
			ResetComplete();
		});

		grid.on('click', function(ev) {
			if (ev["columnName"] == "rscCd") {
				dialog2.dialog("open");
				$("#dialog-form2").load(
						"${pageContext.request.contextPath}/modal/rscinfoList",
						function() {
							rscinfoList(ev["rowKey"]);
							grid.refreshLayout();
						})
			}
		});

		grid
				.on(
						'click',
						function(ev) {
							if (ev["columnName"] == "prcsNm") {
								dialog3.dialog("open");
								$("#dialog-form3")
										.load(
												"${pageContext.request.contextPath}/modal/prcsinfoList2",
												function() {
													prcsinfoList(ev["rowKey"]);
													grid.refreshLayout();
												})
							}
						});

		$('#prdtCd')
				.on(
						'click',
						function() {
							dialog.dialog("open");
							$("#dialog-form")
									.load(
											"${pageContext.request.contextPath}/modal/prdtlistbom");
						});
	</script>
</body>
</html>