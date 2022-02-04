<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="card card-pricing card-primary card-white">
		<div class="card-body" id="grid">
			<div class="row">
				<div data-role="fieldcontain">
					<label for="defandroid">지시번호</label> <input name="indica"
						 id="indica" type="text"><button type="button" id="indicaSearch" style="width: 33px">
						🔍</button>
				</div>
			</div>
			<div class="row">
				<div data-role="fieldcontain" class="col-4">
					<label>작업자ID</label> <input type="text" id="empId">
					<button type="button" id="empIdSearch" style="width: 33px">
						🔍</button>
				</div>
				<div data-role="fieldcontain" class="col-1">
					<label>시작</label> 
					<button type="button" id="start" style="width: 33px">
						🔍</button>
				</div>
				<div data-role="fieldcontain" class="col-1">
					<label>종료</label> 
					<button type="button" id="end" style="width: 33px">
						🔍</button>
				</div>
			</div>
		</div>
	</div>

<div id="grid"></div>

<script type="text/javascript">

const grid = new tui.Grid(
		{
			el : document.getElementById('grid'), // 컨테이너 엘리먼트
			data : {
				api : {
					readData : {
						url : '${pageContext.request.contextPath}/grid/scheduler.do',
						method : 'GET'
					},
					modifyData:{
						url:'${pageContext.request.contextPath}/grid/insertWkDetail.do',
						method : 'POST',
						cache : false
						}
				},
				initialRequest : false,
				contentType : 'application/json'
			},
			
			bodyHeight : 700,

			columns : [ {
				header : 'index',
				name : 'prdtInx',
				hidden : true
			},{
				header : '제품LOT',
				name : 'prdtLot',
				
			}, {
				header : '제품코드',
				name : 'prdtCd',
				
			}, {
				header : '공정진행',
				name : 'prdtFg',
				
			}, {
				header : '생산지시상세번호',
				name : 'indicaDetaNo'
			}, {
				header : '시작시간',
				name : 'prcsFrTm'
			}, {
				header : '종료시간',
				name : 'prcsToTm'
			},{
				header : '설비코드',
				name : 'eqmCd',
				
			}, {
				header : '작업번호',
				name : 'wkNo',
				
			}, {
				header : '작업일자',
				name : 'wkDt',
				
			},

			]

		});
//그리드 값 변하면 다시 뿌려주게끔
grid.on('onGridUpdated', function() {
	grid.refreshLayout();
	var a = grid.getRowCount();

});
/* grid.on('response', function(ev) {

	let res = JSON.parse(ev.xhr.response);
	if (res.mode == 'upd') {
		grid.resetOriginData();

	}
}); */
$("#indicaSearch").on('click',function(){
	grid.readData(1,{'indicaNo' : $("#indica").val()},true);
	
});
$("#start").on('click',function(){
	if($("#indica").val()!='' && $("#empId").val()!=''){
		
		$.ajax({
			url:'${pageContext.request.contextPath}/ajax/insertWk.do',
			dataType: 'json',
			contentType: 'application/json; charset=utf-8',
			async: false,
			data : {
				indicaNo :$("#indica").val(),
				empId :  $("#empId").val()
			}
		}).done((res)=>{
			var today = new Date();
			var dd = String(today.getDate()).padStart(2, '0');
			var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
			var yyyy = today.getFullYear();

			today =yyyy+'-'+ mm + '-' + dd ;
			for(let i =0;i< grid.getRowCount();i++){
				
				grid.setValue(i,'wkNo',res.No);
				grid.setValue(i,'wkDt',today);
			}
		});
		setTimeout(() => {
			grid.request('modifyData');	
		}, 3000);
		
	}
});





</script>
</body>
</html>