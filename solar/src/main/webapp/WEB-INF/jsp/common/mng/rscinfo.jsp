<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자재정보관리</title>
<style>
#btnRight {
	float: right;
	margin: 15px;
}
</style>
</head>
<body>
	<h1>자재정보관리</h1>
	<form name="rscfrm" id="rscfrm" method="post">
		<div class="row">
			<div class=" col-3">
				<div id="senseOrderBody"
					class="card card-pricing card-primary card-white card-outline"
					style="margin-left: 50px; margin-right: 30px; margin-top: 150px; padding-left: 40px;">
					<div class="card-body">
						<div>
							<label>자재명</label> <input type="text" id="rscNmFind">

						</div>
					</div>
					<div class="card-footer" style="margin-bottom: 10px;">
						<button type="button" id="btnFind" style="margin-left: 50px">조회</button>
					</div>
				</div>
			</div>
			<div class="col-8">
				<div id="grid"></div>
			</div>
		</div>
		<div class="card card-pricing card-primary card-white card-outline"
			style="margin-left: 50px; margin-right: 150px; margin-top: 60px; padding-left: 40px;">
			<div class="card-body">
				<div class=" row">
					<div class="col-3">
						<label>자재코드</label> <input type="text" name="rscCd" id="rscCd"
							readonly="readonly">
					</div>

					<div class=" col-3">
						<label>자재명</label> <input type="text" name="rscNm" id="rscNm">
					</div>
					<div class=" col-3">
						<label>규격</label> <input type="text" name="rscSpec" id="rscSpec">
					</div>
					<div class=" col-3">
						<label>관리단위&nbsp;</label><input type="text" name="rscUnit" id="rscUnit">
					</div>
				</div>
				<div class="row">
					<div class=" col-3">
						<label>업체코드&nbsp; </label><input type="text" name="coCd" id="coCd"
							readonly="readonly">
						<button type="button" id="coCdFind">🔍</button>
					</div>
					<div class=" col-3">
						<label>업체명&nbsp;</label><input type="text" name="coNm" id="coNm"
							readonly="readonly">
					</div>
					<div class=" col-3">
						<label>단가</label> <input type="text" name="rscUntprc"
							id="rscUntprc">
					</div>
					<div class=" col-3">
						<label>안전재고</label> <input type="text" name="safStc" id="safStc">
					</div>
				</div>
				<div>
					<button type="button" id="btnInsert">추가</button>
					<button type="button" id="btnUpdate">저장</button>
					<button type="button" id="btnDelete">삭제</button>
					<button type="button" id="btnReset">초기화</button>
				</div>
			</div>
		</div>
		</div>
		<div id="coCdModal" title="업체명단"></div>
	</form>
	<script>
	//업체검색 모달
	let coCdDialog = $("#coCdModal").dialog({
		autoOpen: false,
		modal: true,
		height: 600,
		width: 600
	});
	
	toastr.options = {
			  "closeButton": false,
			  "debug": false,
			  "newestOnTop": false,
			  "progressBar": true,
			  "positionClass": "toast-top-right",
			  "preventDuplicates": false,
			  "onclick": null,
			  "showDuration": "100",
			  "hideDuration": "1000",
			  "timeOut": "2000",
			  "extendedTimeOut": "1000",
			  "showEasing": "swing",
			  "hideEasing": "linear",
			  "showMethod": "fadeIn",
			  "hideMethod": "fadeOut"
			}
	
	function SaveComplete(){
		toastr.success('데이터가 수정되었습니다.');
	}	
	function SaveFail(){
		toastr.error('저장실패');
	}
	function DeleteComplete(){
		toastr.success('삭제완료');
	}
	function DeleteFail(){
		toastr.error('삭제실패, 데이터를 선택 후 삭제해주세요.');
	}
	function ResetComplete(){
		toastr.info('상세 데이터 리셋 완료 데이터를 입력해주세요');
	}
	function insertComplete(){
		toastr.success('등록완료');
	}
	function insertFail(){
		toastr.error('등록실패 빈 값이 있는지 확인해주세요.');
	}
	function updateFail(){
		toastr.error('수정실패, 값을 확인해주세요.');
	}
	function updateComplete(){
		toastr.success('수정완료');
	}
	function datawarning(){
		toastr.warning('데이터 입력오류 정확한 값을 입력해주세요');
	}
	
	var dataSource = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/grid/rscinfoList.do',
					method : 'GET'
				}
			},
			contentType : 'application/json'
		};

		var grid = new tui.Grid({
			el : document.getElementById('grid'),
			data : dataSource,
			scrollX : true,
			scrollY : true,
			rowHeaders : ['rowNum'],
			bodyHeight : 450,
			columns : 
			[ 
				{
					header : '자재코드',
					name : 'rscCd',
					sortable: true,
					sortingType: 'desc',
					align : 'center'
				}, 
				{
					header : '자재명',
					name : 'rscNm',
					align : 'center'
				},
				{
					header : '안전재고',
					name : 'safStc',
					hidden : true,
					align : 'center'
				},
				{
					header : '업체코드',
					name : 'coCd',
					hidden : true,
					align : 'center'
				},
				{
					header : '규격',
					name : 'rscSpec',
					align : 'center'
				},
				{
					header : '관리단위',
					name : 'rscUnit',
					hidden : true,
					align : 'center'
				},
				{
					header : '이미지',
					name : 'rscImg',
					hidden : true,
					align : 'center'
				},
				{
					header : '단가',
					name : 'rscUntprc',
					hidden : true,
					align : 'center'
				}
			]
		});

		grid.on('onGridUpdate', function(){
			grid.refreshLayout();
		});

		grid.on('response', function(ev) { 
			let res = JSON.parse(ev.xhr.response);
			if(res.mode=='upd'){
				grid.resetOriginData();
			}
			else {
				grid.refreshLayout()
				}
		});
		
		grid.on('click', (ev) =>{
			var row = ev.rowKey;
			var code = grid.getValue(row, 'rscCd');
			$("#rscCd").prop('readonly', true);
				$.ajax({
					url : "${pageContext.request.contextPath}/rscinfo.do",
					type : "POST",
					dataType: "json",
					cache: false,
					data : {rscCd : code},
					success: function(data){
						var vo = data["result"];
						$("#rscCd").val(vo["rscCd"]);
						$("#rscNm").val(vo["rscNm"]);
						$("#rscSpec").val(vo["rscSpec"]);
						$("#rscUnit").val(vo["rscUnit"]);
						$("#coCd").val(vo["coCd"]);
						$("#coNm").val(vo["coNm"]);
						$("#rscUntprc").val(vo["rscUntprc"]);
						$("#safStc").val(vo["safStc"]);
					}
				})
		})
		
		grid.on('click', function(ev) {
			$('td').css('backgroundColor','')
			$('div#grid').find('td[data-row-key$="'+ev.rowKey+'"]').css('backgroundColor','#81BEF7');
		});

		$('#btnFind').on('click', function(){
			var rscNm = $("#rscNmFind").val();
			var parameter = {
					'rscNm' : rscNm
			}
			$.ajax({
				url : '${pageContext.request.contextPath}/grid/rscinfoFind',
				data : parameter,
				contentType: 'application/json; charset=utf-8'
			}).done(function(res){
				var info = JSON.parse(res);
				grid.resetData(info["data"]["contents"]);
			})
		});
		

		$("#coCdFind").on("click", function(){	
			coCdDialog.dialog("open");
			$("#coCdModal").load("${pageContext.request.contextPath}/modal/selectRcoCd", function(){ coCdList() })
		});
		 
	$("#btnInsert").on("click", function(){

		$.ajax({
			url: "${pageContext.request.contextPath}/rscinfoInsert.do",
			method : "POST",
			data: $("form").serialize(),
			success:function(res){
				grid.readData(1,{},true)
				insertComplete();
			},
			error:function(){
				insertFail();
			}
		})
			
	});
	
	$("#btnUpdate").on("click", function(){		
		$.ajax({
			url: "${pageContext.request.contextPath}/rscinfoUpdate.do",
			method : "POST",
			data: $("#rscfrm").serialize(),
			success:function(res){
				grid.readData(1,{},true)
				updateComplete();
			},
			error : function(){
				updateFail();
			}
		})
		
		
	});
		
		$('#btnReset').on('click', function(){
			$('#rscCd').val('');
			$('#rscNm').val('');
			$('#rscSpec').val('');
			$('#rscUnit').val('');
			$('#coCd').val('');
			$('#coNm').val('');
			$('#rscUntprc').val('');
			$('#safStc').val('');
			$("#rscCd").removeAttr("readonly");
			ResetComplete();
		});

		 $('#btnDelete').on('click', function(){
			 $.ajax({
				 url : "${pageContext.request.contextPath}/rscinfoDelete.do",
				 method : "POST",
				 data: $("#rscfrm").serialize(),
				 datatype : "json",
				 success : function(data){
				 grid.readData(1,{},true)
					$('#rscCd').val('');
					$('#rscNm').val('');
					$('#rscSpec').val('');
					$('#rscUnit').val('');
					$('#coCd').val('');
					$('#coNm').val('');
					$('#rscUntprc').val('');
					$('#safStc').val('');
					DeleteComplete();
				 },
				error : function(){
					DeleteFail();
				}
			 })
		 });
		 		
		
$('#senseOrder').resize(function() {
		if ($('#senseOrder').width() < 1780) {
			$('#senseOrderBody').css('paddingLeft', '20px');
		} else {
			$('#senseOrderBody').css('paddingLeft', '40px');
		}	
	});

		$(document).on('click','.tui-page-btn',function(){
			$('td').css('backgroundColor','');
		});
</script>
</body>
</html>