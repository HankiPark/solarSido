<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>gongjung_info</title>

</head>
<body>
<h3>공정정보관리</h3>
<div>
	<button type="button" id="btnAdd">추가</button>
	<button type="button" id="btnDel">삭제</button>
	<button type="button" id="btnSave">저장</button><br>
	<label>공정명 입력</label>
	<input type = "text" id="prcsNminfo">
	<div><button type="button" id="btnfind">검색</button></div>
</div>
	<div id="grid">
		
	</div>

<script>
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
		  "timeOut": "1500",
		  "extendedTimeOut": "1000",
		  "showEasing": "swing",
		  "hideEasing": "linear",
		  "showMethod": "fadeIn",
		  "hideMethod": "fadeOut"
		}

function fairerror(){
	if(('#prodPd')!= num){
		toastr.warning('생산일수에 숫자만 입력해주세요')
	}
}

var dataSource = {
		  api: {
		    	readData: { url: '${pageContext.request.contextPath}/grid/fairList.do', 
					    	method: 'GET' 
					   },
				modifyData: { url: '${pageContext.request.contextPath}/grid/fairUpdateIn.do', 
							method: 'POST' }
				},
/*				initialRequest : false, // 조회버튼 누르면 값을 불러오겠다 */
				contentType: 'application/json'
		};


var grid = new tui.Grid({
	  el: document.getElementById('grid'),
	  data:dataSource, 
	  scrollY : true,
	  rowHeaders : [ 'rowNum','checkbox' ],
	  bodyHeight : 700,
	  columns : [
			{
				header : '공정코드',
				name : 'prcsCd',
				editor : 'text'
			},
			{
				header : '공정구분',
				name : 'prcsFg',
				editor : 'text'
			},
			{
				header : '공정명',
				name : 'prcsNm',
				editor : 'text'
			},
			{
				header : '작업설명',
				name : 'prcsDesct',
				editor : 'text'
			},
			{
				header : '관리단위',
				name : 'prcsUnit',
				editor : 'text'
			},
			{
				header : '생산일수',
				name : 'prodPd',
				editor : 'text'
			}
		]  
	  });
	  
grid.on('onGridUpdated', function() {
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
	

$('#btnAdd').on('click', function appendRow(index){
	grid.appendRow({}, {
		extendPrevRowSpan : true,
		focus : true,
		at : 0
	});
});
$('#btnSave').on('click', function appendRow(index){
	grid.blur();
	grid.request('modifyData');
});
$('#btnDel').on('click', function appendRow(index){
	grid.blur();
	grid.removeCheckedRows(true);
});

$('#btnfind').on('click', function(){
	var prcsNm = $("#prcsNminfo").val();
	var parameter = {
			'prcsNm' : prcsNm
	}
	$.ajax({
		url : '${pageContext.request.contextPath}/grid/prcsdataFind',
		data : parameter,
		contentType: 'application/json; charset=utf-8'
 		}).done(function(res){
		var info = JSON.parse(res);
		grid.resetData(info["data"]["contents"]);
	})
	
});


</script>
</body>
</html>