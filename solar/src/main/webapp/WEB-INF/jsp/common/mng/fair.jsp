<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>gongjung_info</title>

</head>
<body>
	<h1>공정 관리</h1>
	<div class="row" id="senseOrder">
		<div id="senseOrderBody"
			class="card card-pricing card-primary card-white card-outline col-3"
			style="margin-left: 50px; margin-right: 30px; margin-top: 200px; padding-left: 60px; padding-top: 30px; margin-bottom: 300px;">
			<div class="card-body">
				<div style="margin-bottom: 20px; margin-top: 50px;">
					<label>공정명&nbsp;&nbsp;&nbsp;&nbsp;</label> <input type="text"
						id="prcsNminfo">
				</div>
			</div>
			<div class="card-footer" style="margin-bottom: 30px;">
				<button type="button" id="btnfind" style="margin-left: 120px">조회</button>
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
			"timeOut" : "1500",
			"extendedTimeOut" : "1000",
			"showEasing" : "swing",
			"hideEasing" : "linear",
			"showMethod" : "fadeIn",
			"hideMethod" : "fadeOut"
		}

		function fairerror() {
			if (('#prodPd') != num) {
				toastr.warning('생산일수에 숫자만 입력해주세요')
			}
		}
		
		function Savedone(){
			toastr.success('수정이 완료되었습니다.')
		}
		function Deletedone(){
			toastr.success('해당 데이터가 삭제되었습니다 저장 해주세요.');
		}

		var dataSource = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/grid/fairList.do',
					method : 'GET'
				},
				modifyData : {
					url : '${pageContext.request.contextPath}/grid/fairUpdateIn.do',
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
			bodyHeight : 700,
			columns : [ {
				header : '공정코드',
				name : 'prcsCd'
						}, 
						{
						header : '공정구분',
						name : 'prcsFg',
						editor : 'text',
						align : 'center',
						formatter:function(value){
							if(value.value=="1"){
								return "제조_공정";
							}else if(value.value=="2"){
								return "전극_공정";
							}else if(value.value=="3"){
								return "용접_공정";
							}else if(value.value=="4"){
								return "접합_공정";
							}else{
								return "";
							}
						}
						
			}, {
				header : '공정명',
				name : 'prcsNm',
				editor : 'text',
				align : 'center'
				
			}, {
				header : '작업설명',
				name : 'prcsDesct',
				editor : 'text',
				align : 'center'
			}, {
				header : '관리단위',
				name : 'prcsUnit',
				editor : 'text',
				hidden : true,
				align : 'center'
			}, {
				header : '작업일수',
				name : 'prodPd',
				editor : 'text',
				hidden : true,
				align : 'center'
			} ]
		});

		grid.on('onGridUpdated', function() {
			grid.refreshLayout();
		});

		grid.on('response', function(ev) {
			let res = JSON.parse(ev.xhr.response);
			if (res.mode == 'upd') {
				grid.resetOriginData();
				grid.refreshLayout();
				grid.readData(1,{},true);
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
			Savedone();
		});
		$('#btnDel').on('click', function appendRow(index) {
			grid.blur();
			grid.removeCheckedRows(true);
			Deletedone();
		});

		$('#btnfind').on('click', function() {
			var prcsNm = $("#prcsNminfo").val();
			var parameter = {
				'prcsNm' : prcsNm
			}
			$.ajax({
				url : '${pageContext.request.contextPath}/grid/prcsdataFind',
				data : parameter,
				contentType : 'application/json; charset=utf-8'
			}).done(function(res) {
				var info = JSON.parse(res);
				grid.resetData(info["data"]["contents"]);
			})

		});
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