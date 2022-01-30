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
	<h2>자재정보관리</h2>
	<form name="rscfrm" id="rscfrm" method="post">

		<div id="btnleft">
			<label>자재명 검색</label> <input type="text" id="rscNmFind">
			<button type="button" id="btnFind">검색</button>
		</div>
		<div id="btnRight">
			<button type="button" id="btnInsert">등록</button>
			<button type="button" id="btnUpdate">수정</button>
			<button type="button" id="btnReset">초기화</button>
		</div>
	<div class ="row">	
			<div class="col-4">
				<div id="grid"></div>
			</div>
		<div class="col-8 table">
			<table id=table>
				<tbody>
					<tr>
						<th scope="row">자재코드 *</th>
						<td><input type="text" name="rscCd" id="rscCd"
							readonly="readonly"></td>
					</tr>
					<tr>
						<th scope="row">자재명 *</th>
						<td><input type="text" name="rscNm" id="rscNm"></td>
					</tr>
					<tr>
						<th scope="row">규격</th>
						<td><input type="text" name="rscSpec" id="rscSpec"></td>
					</tr>
					<tr>
						<th scope="row">관리단위</th>
						<td><input type="text" name="rscUnit" id="rscUnit"></td>
					</tr>
					<tr>
						<th scope="row">업체코드</th>
						<td><input type="text" name="coCd" id="coCd"
							readonly="readonly">
							<button type="button" id="coCdFind">조회</button></td>
					</tr>
					<tr>
						<th scope="row">업체명</th>
						<td><input type="text" name="coNm" id="coNm"
							readonly="readonly"></td>
					</tr>
					<tr>
						<th scope="row">단가</th>
						<td><input type="text" name="rscUntprc" id="rscUntprc"></td>
					</tr>
					<tr>
						<th scope="row">안전재고</th>
						<td><input type="text" name="safStc" id="safStc"></td>
					</tr>
				</tbody>
			</table>
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
		toastr.success('저장완료');
	}	
	function SaveFail(){
		toastr.error('저장실패');
	}
	function DeleteComplete(){
		toastr.success('삭제완료');
	}
	function DeleteFail(){
		toastr.error('삭제실패');
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
			scrollY : false,
			rowHeaders : ['rowNum'],
			bodyHeight : 500,
			columns : 
			[ 
				{
					header : '자재코드',
					name : 'rscCd',
					sortable: true,
					sortingType: 'desc'
				}, 
				{
					header : '자재명',
					name : 'rscNm'
				},
				{
					header : '안전재고',
					name : 'safStc',
					hidden : true
				},
				{
					header : '업체코드',
					name : 'coCd',
					hidden : true
				},
				{
					header : '규격',
					name : 'rscSpec'
				},
				{
					header : '관리단위',
					name : 'rscUnit',
					hidden : true
				},
				{
					header : '이미지',
					name : 'rscImg',
					hidden : true
				},
				{
					header : '단가',
					name : 'rscUntprc',
					hidden : true
				}
			]
		});

		grid.on('onGridUpdate', function(){
			grid.refreshLayout();
		});

		grid.on('response', function(ev) { 
			console.log(ev);
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
			console.log("업체검색")
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
				console.log(res);
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
				console.log(res);
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
/*
		 $('#btnDelete').on('click', function(){
			 $.ajax({
				 url : "${pageContext.request.contextPath}/rscinfoDelete.do"
				 type : "POST",
				 data: $("rscfrm").serialize();
				 cache: false,
				 datatype : "json",
				 success : function(data){
					 
				 }
			 })
		 });
*/		
</script>
</body>
</html>