<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
.eqmImg {
	width: 150px;
	height: 120px;
}

progress {
	width: 100%;
	height: 20px;
	border: 1px solid #FA8383;
	border-radius: 30px;
	text-align: center;
	color: white;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
}

::-webkit-progress-bar {
	background-color: white;
	border: 0;
	border-radius: 30px;
}

::-webkit-progress-value {
	border: 0;
	border-radius: 30px;
	background-color: orange;
}

.progText {
	position: absolute;
	left: 220px;
	top: 329px;
}

.progSemiText {
	position: absolute;
	left: 76px;
	top: 119px;
}
</style>
<body>
	<h1>공정지시</h1>
	<div class="row">
		<div class="col-3">
			<div class="card card-pricing card-primary card-white card-outline"
				style="margin-left: 30px; padding-left: 10px; padding-top: 20px; margin-bottom: 10px; height: 300px">
				<div class="card-body">

					<div data-role="fieldcontain" style="margin-left: -20px;">
						<label for="defandroid">지시번호</label> <input name="indica"
							id="indica" type="text">
						<button type="button" id="indicaSearch" style="width: 33px">
							🔍</button>
					</div>


					<div data-role="fieldcontain"
						style="margin-left: -20px; margin-top: 20px">
						<label>작업자ID</label> <input type="text" id="empId" readonly>

					</div>
					<div data-role="fieldcontain" class="row" style="margin-top: 50px">
						<label class="col-6" style="padding-left: 60px">시작</label><label
							class="col-6" style="padding-left: 70px">종료</label>
					</div>
					<div class="row">
						<button type="button" id="start" class="col-5"
							style="height: 50px; background-color: green">
							<i class="fas fa-play"></i>
						</button>
						<button type="button" id="end" class="col-5"
							style="height: 50px; margin-left: 30px; background-color: red">
							<i class="fas fa-stop"></i>
						</button>

					</div>
				</div>
			</div>

			<div
				style="margin-left: 20px; margin-right: 30px; padding-left: 40px; padding-top: 20px; height: 250px">
				<div>
					<progress value="0" max="100" id="pr5"></progress>
					<span id="pct5" class="progText">0%</span><SPAN>입고량 : </SPAN><span id="Ccnt">0</span> <span
						style="margin-left: 50px">생산량 : </span><span id="cnt5">0</span>/
						<span>불랑량 : </span><span id="inq">0</span>
				</div>
				<div class="row">
					<div class=" col-6">
						<img id="eqmImg1" class="eqmImg"
							src="${pageContext.request.contextPath}/images/eqm1.png">
						<progress value="0" max="100" id="pr1"></progress>
						<span id="pct1" class="progSemiText">0%</span> <br>1번공정: <span
							id="cnt1">0</span>

					</div>
					<div class=" col-6">
						<img id="eqmImg2" class="eqmImg"
							src="${pageContext.request.contextPath}/images/eqm2.png">
						<progress value="0" max="100" id="pr2"></progress>
						<span id="pct2" class="progSemiText">0%</span> <br>2번공정: <span
							id="cnt2">0</span>

					</div>
				</div>
				<div class="row">
					<div class=" col-6">
						<img id="eqmImg3" class="eqmImg"
							src="${pageContext.request.contextPath}/images/eqm3.png">
						<progress value="0" max="100" id="pr3"></progress>
						<span id="pct3" class="progSemiText">0%</span> <br>3번공정: <span
							id="cnt3">0</span>

					</div>
					<div class=" col-6">
						<img id="eqmImg4" class="eqmImg"
							src="${pageContext.request.contextPath}/images/eqm4.png">
						<progress value="0" max="100" id="pr4"></progress>
						<span id="pct4" class="progSemiText">0%</span> <br>4번공정: <span
							id="cnt4">0</span>

					</div>
				</div>

			</div>
		</div>



		<div id="grid" class="col-8" style="margin-left: 40px"></div>
	</div>
	<div id="dialog-form" title="미지시 공정"></div>
	<script type="text/javascript">
var wkno=null;
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
			rowHeight: 20,
			minRowHeight: 10,
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
				header : '제품명',
				name : 'prdtNm',
				
			}, {
				header : '공정진행',
				name : 'prdtFg',
			 	formatter:function(value){
			 		if(value.value=="P"){
			 			return "1공정";
			 		}
			 		else if(value.value=="P1"){
			 			return "2공정";
			 		}
			 		else if(value.value=="P2"){
			 			return "3공정";
			 		}
			 		else if(value.value=="P3"){
			 			return "4공정";
			 		}else if(value.value=="F"){
			 			return "불량";
			 		}else{
			 			return "생산완료";
			 		}
				}
				
			}, {
				header : '생산지시상세번호',
				name : 'indicaDetaNo',
				hidden : true,
			}, {
				header : '시작시간',
				name : 'prcsFrTm',
				 formatter:function(value){
					  if(value.value !=null && value.value !=''){
						 var t= new Date(value.value);
						 var h,m,s;
						 if(t.getHours().toString().length==1){h="0"+t.getHours()}else{h=t.getHours()}
						 if(t.getMinutes().toString().length==1){m="0"+t.getMinutes()}else{m=t.getMinutes()}
						 if(t.getSeconds().toString().length==1){s="0"+t.getSeconds()}else{s=t.getSeconds()}
						return h+":"+m+":"+s; }
						else {return null;} 
				} 
			}, {
				header : '종료시간',
				name : 'prcsToTm',
				formatter:function(value){
					 if(value.value !=null && value.value !=''){
						 var t= new Date(value.value);
						 var h,m,s;
						 
						 if(t.getHours().toString().length==1){h="0"+t.getHours()}else{h=t.getHours()}
						 if(t.getMinutes().toString().length==1){m="0"+t.getMinutes()}else{m=t.getMinutes()}
						 if(t.getSeconds().toString().length==1){s="0"+t.getSeconds()}else{s=t.getSeconds()}
						return h+":"+m+":"+s; }
					else {return null;} 
				}
			},{
				header : '설비코드',
				name : 'eqmCd',
				
			}, {
				header : '설비명',
				name : 'eqmNm',
				
			}, {
				header : '작업번호',
				name : 'wkNo',
				hidden : true,
				
			}, {
				header : '작업일자',
				name : 'wkDt',
				hidden : true,
				
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
			wkno=res.No;
			repeat();
		});
		

		setTimeout(() => {
			grid.request('modifyData',{showConfirm: false});	
			$("#Ccnt").val(grid.getRowCount());
		}, 1000);
		
	}
	
	
	function repeat(){
		$.ajax({
			url:'${pageContext.request.contextPath}/ajax/repeat',
			dataType: 'json',
			contentType: 'application/json; charset=utf-8',
			data : {
				wkNo : wkno
			}
		}).done((res)=>{
			if(res.data.contents.length!=0){
			grid.resetData(res.data.contents);

			$("#cnt1").text(res.p2+res.p3+res.p4+res.p5+res.error);
			$("#cnt2").text(res.p3+res.p4+res.p5+res.error);
			$("#cnt3").text(res.p4+res.p5+res.error);
			$("#cnt4").text(res.p5+res.error);
			$("#cnt5").text(res.p5);
			$("#inq").text(res.error);
			document.getElementById("pr1").max = res.len;
			document.getElementById("pr2").max = res.len;
			document.getElementById("pr3").max = res.len;
			document.getElementById("pr4").max = res.len;
			document.getElementById("pr5").max = res.len;
			$("#pr1").val(res.p2+res.p3+res.p4+res.p5+res.error);
			$("#pr2").val(res.p3+res.p4+res.p5+res.error);
			$("#pr3").val(res.p4+res.p5+res.error);
			$("#pr4").val(res.p5+res.error);
			$("#pr5").val(res.p5+res.error);

			$("#pct1").text(Math.ceil((res.p2+res.p3+res.p4+res.p5+res.error)/res.len*100)+'%');
			$("#pct2").text(Math.ceil((res.p3+res.p4+res.p5+res.error)/res.len*100)+'%');
			$("#pct3").text(Math.ceil((res.p4+res.p5+res.error)/res.len*100)+'%');
			$("#pct4").text(Math.ceil((res.p5+res.error)/res.len*100)+'%');
			$("#pct5").text(Math.ceil((res.p5+res.error)/res.len*100)+'%');
			if(res.p1>0 && res.p1<=res.len){
				pngToGif(1);
			}else{
				gifToPng(1);
			}
			if(res.p2>0 && res.p2<=res.len){
				pngToGif(2);
			}else{
				gifToPng(2);
			}
			if(res.p3>0 && res.p3<=res.len){
				pngToGif(3);
			}else{
				gifToPng(3);
			}
			if(res.p4>0 && res.p4<=res.len){
				pngToGif(4);
			}else{
				gifToPng(4);
			}
			}
			setTimeout(() => {
				repeat();
			}, 2000);
			
		})
	}
	
});
$("#end").on('click',function(){
	$.ajax({
		url:'${pageContext.request.contextPath}/ajax/scheduleEnd',
		dataType: 'json',
		contentType: 'application/json; charset=utf-8',
	})
	gifToPng(1);
	gifToPng(2);
	gifToPng(3);
	gifToPng(4);
});

function pngToGif(i){
	let imgTag = document.getElementById('eqmImg'+i);
	imgTag.src = '${pageContext.request.contextPath}/images/eqm'+i+'.gif';
}
function gifToPng(i){
	let imgTag = document.getElementById('eqmImg'+i);
	imgTag.src = '${pageContext.request.contextPath}/images/eqm'+i+'.png';
}
$("#empIdSearch").on("click",function(){
	$.ajax({
		url : "${pageContext.request.contextPath}/modal/empinfoList",
		
	})
})
$(function(){
	setTimeout(() => {
		$("#empId").val(UID);
	}, 2000);
	
})
</script>
</body>
</html>