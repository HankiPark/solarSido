<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
* {
	margin: 0;
	padding: 0;
}

ul {
	list-style: none;
}

a {
	text-decoration: none;
	color: #333;
}

.wrap {
	padding: 15px;
	letter-spacing: -0.5px;
}

.tab_menu .list {
	overflow: hidden;
}

.tab_menu .list li {
	float: left;
	margin-right: 14px;
}

.tab_menu .list .btn {
	font-size: 13px;
}

.tab_menu .list li.is_on .btn {
	font-weight: bold;
	color: green;
}

.tab_menu .list li.is_on .cont {
	display: block;
}

#oG {
	display: none;
}
</style>
</head>
<body>

	<div class="wrap">
		<div class="tab_menu">
			<ul class="list">
				<li class="is_on"><a href="#" id="in" class="btn">입고</a></li>
				<li><a href="#" id="out" class="btn">출고</a></li>
			</ul>
		</div>
	</div>

	<div id="iG">
		<div class="row">
			<div data-role="fieldcontain" class="col-7">
				<label for="defandroid">날짜 선택</label> <input name="startT"
					id="startT" type="date" data-role="datebox"
					data-options='{"mode": "calbox"}'> ~ <input name="endT"
					id="endT" type="date" data-role="datebox"
					data-options='{"mode": "calbox"}'>
			</div>
			<div data-role="fieldcontain" class="col-5">
				<label>제품명</label> <input type="text" id="prdNm">
			</div>
		</div>
		<div>
			<button type="button" id="findgrid">조회</button>
		</div>
	<div class="card card-pricing card-primary card-white">
			<div class="card-body" id="grid">
				<div align="right">
					<button type="button" id="insertBtn"
						class="btn btn-default btn-simple btn-sm">추가</button>
					<button type="button" id="deleteBtn"
						class="btn btn-default btn-simple btn-sm">삭제</button>
				</div>
			</div>
		</div>

		<div id="inGrid"></div>
	</div>
	<div id="oG">
		<div id="outGrid"></div>
	</div>





<div id="dialog-form" title="제품명단"></div>
<div id="dialog-lot" title="입고대기명단"></div>



	<script>

//탭 설정
const tabList = document.querySelectorAll('.tab_menu .list li');
for(var i = 0; i < tabList.length; i++){
  tabList[i].querySelector('.btn').addEventListener('click', function(e){
    e.preventDefault();
    for(var j = 0; j < tabList.length; j++){
      tabList[j].classList.remove('is_on');
    }
    this.parentNode.classList.add('is_on');
    if($(this)[0].id=="in"){
    	$("#oG").css("display","none");
    	$("#iG").css("display","block");
    	inGrid.refreshLayout();
    }else{
    	$("#iG").css("display","none");
    	$("#oG").css("display","block");
    	
    }
  });
}
//날짜 설정
var d = new Date();
var nd = new Date(d.getFullYear(), d.getMonth(), d.getDate() - 7);
document.getElementById('startT').value = nd.toISOString().slice(0, 10);
document.getElementById('endT').value = d.toISOString().slice(0, 10);


//modal 설정
let dialog = $("#dialog-form").dialog({
	autoOpen : false,
	modal : true,
	width : 700,
	height : 700
}); 
let dialog2 = $("#dialog-lot").dialog({
	autoOpen : false,
	modal : true,
	width : 900,
	height : 700
}); 




//제품이름검색시
$('#prdNm').on('click',function(){
	dialog.dialog("open");
	$("#dialog-form")
			.load(
					"${pageContext.request.contextPath}/modal/prdtNmList",function(){NmList()}
					)
});
//메인그리드
const inGrid = new tui.Grid({
	el : document.getElementById('inGrid'), // 컨테이너 엘리먼트
	data : null,
	bodyHeight : 700,
	rowHeaders: [
	    { type: 'rowNum', width: 100, align: 'left', valign: 'bottom' },
	    { type: 'checkbox' }
	  ],
	columns : [ {
		header : '입고일자',
		name : 'prdtDt',
		editor : 'datePicker'
	}, {
		header : '제품LOT',
		name : 'prdtLot',
		editor : 'text'
	}, {
		header : '제품코드',
		name : 'prdtCd'
	}, {
		header : '제품명',
		name : 'prdtNm',
	}, {
		header : '규격',
		name : 'prdtSpec'
	}

	],

});
//그리드 값변하면 다시 뿌려주게끔
inGrid.on('onGridUpdated', function() {
	inGrid.refreshLayout();
});
inGrid
.on(
		'click',
		function(ev) {
			console.log(ev["columnName"]);
			console.log(inGrid.getValue(ev["rowKey"], "prdtLot"));
			 if (ev["columnName"] == "prdtLot"
					&& inGrid.getValue(ev["rowKey"], "prdtLot") == '') {
				dialog2.dialog("open");
				$("#dialog-lot")
						.load(
								"${pageContext.request.contextPath}/modal/prdtInWaitList",
								function() {
									prdtInWait(inGrid.getValue(
											ev["rowKey"],
											"prdtLot"));
									inGrid.refreshLayout();
								})
			} 
		});


//조회버튼
 $('#findgrid').on('click',function(){
	
	var startT = $("#startT").val();
	var endT = $("#endT").val();
	var prdNm = $("#prdNm").val();
	var params ={'startT':startT,
			'endT':endT,
			'prdNm':prdNm
			}
	
	$.ajax({
		url:'${pageContext.request.contextPath}/grid/prdtInput.do',
		data: params,
		contentType: 'application/json; charset=utf-8',
		
		
	}).done(function(res){
		inGrid.enable();
		var sres = JSON.parse(res);
		inGrid.resetData(sres["data"]["contents"]);
		for(var i=0 ;i< sres["data"]["contents"].length;i++){
			inGrid.disableRow(i);
		}
	})
/* 	fetch('${pageContext.request.contextPath}/grid/prdtInput.do?perPage=&startT='+startT+'&endT='+endT+'&prdNm='+prdNm+'&page=1')
	.then(res=>res.json())
	.then(response=>{inGrid.resetData(response["data"]["contents"]);console.log(response);inGrid.refreshLayout();}) */
 })

 //행추가버튼
$('#insertBtn').on('click', function appendRow(index) {
			
	
							inGrid.appendRow(null,{
								extendPrevRowSpan: true,
								focus : true,
								at :0
								});
								
					});
				
				
				    
		


inGrid.refreshLayout();

</script>

</body>
</html>