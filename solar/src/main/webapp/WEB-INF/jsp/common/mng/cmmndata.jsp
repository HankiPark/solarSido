<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공통자료관리</title>

</head>
<body>
	<h2>공통자료관리</h2>
	<div class="row" id="senseOrder">
		<div class=" col-3">
			<div id="senseOrderBody"
				class="card card-pricing card-primary card-white card-outline"
				style="margin-left: 50px; margin-right: 30px; margin-top: 60px; padding-left: 40px;">
				<div class="card-body">
					<div class="row">
						<div class="col-sm-6">
							<div align="left">
								<label>공통코드ID </label><input type="text" id="cmmnNminfo">
								
							</div>
						</div>
					</div>
				</div>
				<div class="card-footer" style="margin-bottom: 10px;" >
					<button type="button" id="btnfind" style="margin-left:50px">조회</button>
				</div>
			</div>
			<div id="grid" style="margin-left: 30px; margin-right: 30px; margin-top: 30px;padding-left: 30px;"></div>

		</div>
		<div class="col-8">

			<div class="float-right" >
				<button type="button" id="btnReset" style="margin-bottom:10px">초기화</button>
			</div>
			<div id="detailgrid"></div>



		</div>


	</div>


	<script>
		$(function() {
			$("#tabs").tabs();
		});

		var dataSource = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/grid/cmmndataList.do',
					method : 'GET'
				}
			},
			contentType : 'application/json'
		};

		var grid = new tui.Grid({
			el : document.getElementById('grid'),
			data : dataSource,
			scrollY : true,
			rowHeaders : [ 'rowNum' ],
			bodyHeight : 400,

			columns : [ {
				header : '공통코드ID',
				name : 'cmmnCdId',
				sortable : true,
				align : 'center'
			}, {
				header : '공통코드ID명',
				name : 'cmmnCdNm',
				align : 'center',
			} ]
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

		grid.on('click', function(ev) {
			$('td').css('backgroundColor', '')
			let JsonData = grid.getRowAt(ev.rowKey);
			let key1 = Object.values(JsonData);
			$('div#grid').find('td[data-row-key$="' + ev.rowKey + '"]').css(
					'backgroundColor', '#81BEF7')
			$('cmmnCdId').val(key1[0]);

			var GridParams = {
				'cmmnCdId' : key1[0]
			};

			detailgrid.readData(1, GridParams, true);
		});

		$('#btnfind').on('click', function() {
			var cmmnCdNm = $("#cmmnNminfo").val();
			var parameter = {
				'cmmnCdNm' : cmmnCdNm
			}
			$.ajax({
				url : '${pageContext.request.contextPath}/grid/cmmndataFind',
				data : parameter,
				contentType : 'application/json; charset=utf-8'
			}).done(function(res) {
				var info = JSON.parse(res);
				grid.resetData(info["data"]["contents"]);
			})

		});

		var detailgridinfo = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/grid/cmmndataDetail.do',
					method : 'GET'
				},
				modifyData : {
					url : '${pageContext.request.contextPath}/grid/modifyData',
					method : 'PUT'
				}
			},
			initialRequest : false, // 조회버튼 누르면 값을 불러오겠다
			contentType : 'application/json'
		};

		var detailgrid = new tui.Grid({
			el : document.getElementById('detailgrid'),
			data : detailgridinfo,
			scrollY : true,
			rowHeaders : [ 'rowNum', 'checkbox' ],
			bodyHeight : 600,
			minBodyHeight : 600,
			columns : [ {
				header : '공통코드상세ID',
				name : 'cmmnCdDetaId',
				align : 'center'
			}, {
				header : '공통코드ID',
				name : 'cmmnCdId',
				align : 'center'
			}, {
				header : '코드명',
				name : 'cmmnCdNm',
				align : 'center'
			}, {
				header : '설명',
				name : 'cmmnCdDesct',
				align : 'center'
			} ]
		});

		detailgrid.on('onGridUpdated', function() {
			detailgrid.refreshLayout();
			grid.refreshLayout();
		});

		detailgrid.on('response', function(ev) {
			let res = JSON.parse(ev.xhr.response);
			if (res.mode == 'upd') {
				detailgrid.resetOriginData();
			} else {
				detailgrid.refreshLayout()
			}
		});
		$('#btnAdd').on('click', function appendRow(index) {
			detailgrid.appendRow({}, {
				extendPrevRowSpan : true,
				focus : true,
				at : 0
			});
		});
		$('#btnSave').on('click', function appendRow(index) {
			detailgrid.blur();
			detailgrid.request('modifyData');
		});
		$('#btnDel').on('click', function appendRow(index) {
			detailgrid.blur();
			detailgrid.removeCheckedRows(true);
		});

		$('#btnReset').on('click', function appendRow(index) {
			$('#prdtCd').val();
			$('td').css('backgroundColor', '');
			$('#cmmnCdId').val('');
			$('#cmmnCdNm').val('');
			detailgrid.clear();
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