<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원관리</title>

</head>
<body>
<h3>사원 관리</h3>
<div>
	<button type="button" id="btnAdd">추가</button>
	<button type="button" id="btnDel">삭제</button>
	<button type="button" id="btnSave">저장</button><br>
	<button type="button" id="btnTest">테스트</button><br>
	<label>사원명 입력</label>
	<input type = "text" id="empNminfo">
	<div><button type="button" id="btnfind">검색</button></div>
</div>
	<div id="grid"></div>
	
	<!-- <div id="dialog-form" title="사원명단"></div>  -->

<script>
/*
let dialog = $("#dialog-form").dialog({
	autoOpen : false,
	modal : true,
	width : 700,
	height : 700
});
*/

var dataSource = {
		  api: {
		    	readData: { url: '${pageContext.request.contextPath}/grid/empList.do', 
					    	method: 'GET' 
					   },
				modifyData: { url: '${pageContext.request.contextPath}/grid/empModify.do', 
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
	  columns : 
		  [
			{
				header : '아이디',
				name : 'empId',
				editor : 'text',
			    sortable: true
			},
			{
				header : '비밀번호',
				name : 'empPw',
				hidden : true
			},
			{
				header : '사원명',
				name : 'empNm',
				editor : 'text'
			},
			{
				header : '사원번호',
				name : 'empNo',
				editor : 'text'
			},
			{
				header : '부서',
				name : 'dept',
				editor : 'text'
			},
			{
				header : '직책',
				name : 'wkdty',
				editor : 'text'
			},
			{
				header : '전화',
				name : 'phone',
				editor : 'text'
			},
			{
				header : '이메일',
				name : 'email',
				editor : 'text'
			},
			{
				header : '입사일',
				name : 'hireDate',
				editor : 'datePicker'
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
	var empNm = $("#empNminfo").val();
	var parameter = {
			'empNm' : empNm
	}
	$.ajax({
		url : '${pageContext.request.contextPath}/grid/empdataFind',
		data : parameter,
		contentType: 'application/json; charset=utf-8'
	}).done(function(res){
		var info = JSON.parse(res);
		grid.resetData(info["data"]["contents"]);
	})
	
});
/*
$('#btnTest').on('click',function() {
	dialog.dialog("open");
	$("#dialog-form").load(
	"${pageContext.request.contextPath}/modal/empinfoList"
	);
});
EMP모달 테스트로만듬 지워도됨 */
</script>
</body>
</html>