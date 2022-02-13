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
	color: #e37c6b;
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
	<h1>제품 입/출고관리</h1>
	<div class="wrap">
		<div class="tab_menu">
			<ul class="list">
				<li class="is_on"><a href="#" id="in" class="btn">입고</a></li>
				<li><a href="#" id="out" class="btn">출고</a></li>
			</ul>
		</div>
	</div>

	<div id="iG">
		<div class="row" id="sensePrdtIn">
			<div
				class="card card-pricing card-primary card-white card-outline col-3" id="sensePrdtInBody"
				style="margin-left: 50px; margin-right: 30px; margin-top: 70px; padding-left: 40px; margin-bottom: 250px; height: 350px">
				<div class="card-body" id="grid">
					<div class="row">
						<div data-role="fieldcontain"
							style="margin-bottom: 40px; margin-top: 40px;">
							<label for="defandroid">입고일자&nbsp;</label> <input name="startT"
								class="dtp" id="startT" type="text" data-role="datebox"
								data-options='{"mode": "calbox"}'>
						</div>
					</div>
					<div>

						<label>제품명&nbsp;</label> <input type="text" id="prdNm">
						<button type="button" id="prdtNmBtn" style="width: 33px">
							🔍</button>
					</div>



				</div>
				<div class="card-footer" style="margin-bottom: 30px;">
					<button type="button" id="findgrid" style="margin-left: 120px">조회</button>
				</div>
			</div>
			<div class="col-8">
				<div class="float-right"
					style="margin-left: 30px; margin-top: -50px">
					<button type="button" id="insertBtn"
						class="btn btn-default btn-simple btn-sm">추가</button>
					<button type="button" id="updateBtn"
						class="btn btn-default btn-simple btn-sm">저장</button>
					<button type="button" id="deleteBtn"
						class="btn btn-default btn-simple btn-sm">삭제</button>
				</div>
				<div id="inGrid"></div>
			</div>

		</div>
	</div>

	<div id="oG">

		<div id="C">
			<div class="row" id="sensePrdtOut1">
				<div
					class="card card-pricing card-primary card-white card-outline col-3" id="sensePrdtOut1Body"
					style="margin-left: 50px; margin-right: 30px; margin-top: 70px; padding-left: 40px; margin-bottom: 170px; height: 350px">
					<div class="card-body">

						<div style="margin-top: 40px; margin-bottom: 30px;">
							<label for="slipNm">부여될 전표번호</label>
						</div>
						<div>
							<input id="slipNm" type="text" readonly>
						</div>



					</div>
					<div class="card-footer" style="margin-bottom: 30px;">
						<button type="button" id="findgrid2" style="margin-left: 120px">조회</button>
					</div>
				</div>
				<div class="col-8">
					<div class="float-right"
						style="margin-left: 30px; margin-top: -50px">
						<button type="button" id="insertBtn2"
							class="btn btn-default btn-simple btn-sm">추가</button>
						<button type="button" id="updateBtn2"
							class="btn btn-default btn-simple btn-sm">저장</button>
						<button type="button" id="deleteBtn2"
							class="btn btn-default btn-simple btn-sm">삭제</button>
					</div>
					<div id="outGrid"></div>
				</div>
			</div>

		</div>

		<div id="noC" style="display: none">
			<div class="row" id="sensePrdtOut2">
				<div
					class="card card-pricing card-primary card-white card-outline col-3" id="sensePrdtOut2Body"
					style="margin-left: 50px; margin-right: 30px; margin-top: 70px; padding-left: 40px; margin-bottom: 170px; height: 350px">
					<div class="card-body">
						<div style="margin-top: 40px; margin-bottom: 30px;">
							<label for="slipNm2">조회중인 전표번호</label>
						</div>
						<div>
							<input id="slipNm2" type="text" readonly>
						</div>
					</div>
					<div class="card-footer" style="margin-bottom: 30px;">
						<button type="button" id="findgrid3" style="margin-left: 120px">조회</button>
					</div>

				</div>
				<div id="outGrid2" class="col-8"></div>
			</div>


		</div>





	</div>





	<div id="dialog-form" title="제품명단"></div>
	<div id="dialog-sl" title="전표명단"></div>
	<div id="dialog-lot" title="입고대기명단"></div>
	<div id="dialog-outLot" title="출고대기명단"></div>
	<div id="dialog-ord" title="주문서명단"></div>
	<div id="dialog-outEndList" title="출고완료명단"></div>



	<script>
let rowKeyNm;
let tempNo=0;
var d = new Date();
//daterangepicker설정
$(function() {
	
	  $('input[name="startT"]').daterangepicker({
		  showDropdowns: true,
	    opens: 'right',
	    startDate: moment().startOf('hour').add(-7, 'day'),
		  endDate: moment().startOf('hour'),
		  minYear: 1990,
		    maxYear: 2025,
		  autoApply: true,
		    locale: {
		      format: 'YYYY-MM-DD',
		    	  separator: " ~ ",
		          applyLabel: "적용",
		          cancelLabel: "닫기",
		          prevText: '이전 달',
		          nextText: '다음 달',
		          monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		          daysOfWeek: ['일', '월', '화', '수', '목', '금', '토'],
		          showMonthAfterYear: true,
		          yearSuffix: '년'
		    }
	  }, function(start, end, label) {
	  },
	  
	  );
	  
	  
	  
	});

	//탭 설정
	const tabList = document.querySelectorAll('.tab_menu .list li');
	
	for (var i = 0; i < tabList.length; i++) {
		tabList[i].querySelector('.btn').addEventListener('click', function(e) {
					e.preventDefault();
					for (var j = 0; j < tabList.length; j++) {
						tabList[j].classList.remove('is_on');
					}
					this.parentNode.classList.add('is_on');
					if ($(this)[0].id == "in") {
						$("#oG").css("display", "none");
						$("#iG").css("display", "block");
						$('td').css('backgroundColor','');

						inGrid.refreshLayout();
						inGrid.clear();
						
							
						
							

					} else {
						$("#iG").css("display", "none");
						$("#oG").css("display", "block");
						$("#noC").css("display", "none");
						$("#C").css("display", "block");
						$('td').css('backgroundColor','');
						$.ajax({
							url:'${pageContext.request.contextPath}/ajax/resetOw.do',
							dataType: 'json',
							contentType: 'application/json; charset=utf-8',
							async: false,
							}).done((res)=>{
								a=res["num2"];	
								
								//전표번호 부여(기본)
								$("#slipNm").val("SLI" + (d.toISOString().slice(0, 10)).replaceAll("-", "")+ a);
							})
								outGrid.refreshLayout();
								outGrid.clear();
								outGrid2.refreshLayout();
								outGrid2.clear();
							}
						});
					}
	var d = new Date();
/* 	//날짜 설정(입고/출고)
	var d = new Date();
	var nd = new Date(d.getFullYear(), d.getMonth(), d.getDate() - 7);
	document.getElementById('startT').value = nd.toISOString().slice(0, 10);
	document.getElementById('endT').value = d.toISOString().slice(0, 10); */

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
	
	let dialog3 = $("#dialog-sl").dialog({
		autoOpen : false,
		modal : true,
		width : 900,
		height : 700
	});
	
	let dialog4 = $("#dialog-ord").dialog({
		autoOpen : false,
		modal : true,
		width : 900,
		height : 700
	});
	
	let dialog5 = $("#dialog-outLot").dialog({
		autoOpen : false,
		modal : true,
		width : 900,
		height : 700
	});
	let dialog6 = $("#dialog-outEndList").dialog({
		autoOpen : false,
		modal : true,
		width : 900,
		height : 700
	});

	//제품이름검색시
	$('#prdtNmBtn').on('click',function() {
		dialog.dialog("open");
		$("#dialog-form").load(
			"${pageContext.request.contextPath}/modal/prdtNmList", 
			function() {
				NmList()
				}
			)
	});
	
	//메인그리드
	const inGrid = new tui.Grid(
			{
				el : document.getElementById('inGrid'), // 컨테이너 엘리먼트
				data : {
					api : {
						readData : {
							url : '${pageContext.request.contextPath}/grid/prdtInput.do',
							method : 'GET'
						},
						modifyData : {
							url : '${pageContext.request.contextPath}/grid/prdtInputUpdate.do',
							method : 'POST',
							cache : false
						}
					},
					initialRequest : false,
					contentType : 'application/json'
				},
				
				bodyHeight : 400,
				rowHeaders : [ {
					type : 'rowNum',
					width : 100,
					align : 'left',
					valign : 'bottom'
				}, {
					type : 'checkbox'
				} ],
				columns : [ {
					header : 'index',
					name : 'prdtInx',
					hidden : true,
					align : 'center'
				}, {
					header : '입고일자',
					name : 'prdtDt',
					rowSpan: true,
					align : 'center'
				}, {
					header : '제품LOT',
					name : 'prdtLot',
					editor : 'text',
					validation: {
				        required: true,
				        unique : true
				      },
						align : 'center'
				}, {
					header : '제품코드',
					name : 'prdtCd',
					align : 'center'
					
				}, {
					header : '제품명',
					name : 'prdtNm',
					align : 'center'
					
				}, {
					header : '규격',
					name : 'prdtSpec',
					align : 'center'
				}, {
					header : '생산지시번호',
					name : 'indicaNo',
					align : 'center'
				}

				],
				summary:{
					 position: 'bottom',
					    height: 100,  // by pixel
					    columnContent: {
					    	'indicaNo': null
				}},

			});
	//그리드 값 변하면 다시 뿌려주게끔
	inGrid.on('onGridUpdated', function() {
		inGrid.refreshLayout();
		var a = inGrid.getRowCount();

		inGrid.setSummaryColumnContent('indicaNo','합계:'+a);
	});
	inGrid.on('response', function(ev) {

		let res = JSON.parse(ev.xhr.response);
		if (res.mode == 'upd') {
			inGrid.resetOriginData();

		}
	});

	inGrid.on('click',function(ev) {
		if (ev["columnName"] == "prdtLot") {
			dialog2.dialog("open");
			$("#dialog-lot").load("${pageContext.request.contextPath}/modal/prdtInWaitList",function() {
				prdtInWait(ev["rowKey"]);
				inGrid.refreshLayout();

				})
				}
			});

	//조회버튼
	$('#findgrid').on('click', function() {		
		
		var startT = $("#startT").val().substring(0,10);
		var endT = $("#startT").val().substring(13,23);
		var prdNm = $("#prdNm").val();
		var params = {
			'startT' : startT,
			'endT' : endT,
			'prdNm' : prdNm
		}
		/* inGrid.enable(); */
		inGrid.readData(1,params,true);

	});
	
	$('#insertBtn').on('click', function appendRow(index) {

		inGrid.appendRow({'prdtDt':d.toISOString().slice(0, 10)}, {
			extendPrevRowSpan : true,
			focus : true,
			at : 0
		});
	});
	$('#updateBtn').on('click', function appendRow(index) {
		inGrid.blur();
		for(let i=inGrid.getRowCount();i>=0;i--){
			if(inGrid.getValue(i,"prdtLot")=='' ||inGrid.getValue(i,"prdtLot")==null ||inGrid.getValue(i,"prdtDt")==null || inGrid.getValue(i,"prdtDt")==''){
				inGrid.removeRow(i);
			}
		}
	
		if(inGrid.validate().length!=0 ){
			toastr.error("제품lot은 중복될수 없습니다");
			
		}else{
			 inGrid.request('modifyData',{'showConfirm' : false});
			 sendMsgToParent('입고처리','/sales/mng/prdt_inout_mng');
			 setTimeout(()=>{
					var startT = $("#startT").val().substring(0,10);
					var endT = $("#startT").val().substring(13,23);
					var prdNm = $("#prdNm").val();
					var params = {
						'startT' : startT,
						'endT' : endT,
						'prdNm' : prdNm
					}
					
					inGrid.readData(1,params,true);
				
				},1000) 
			
			
		}

	});
	$('#deleteBtn').on('click', function appendRow(index) {
		inGrid.blur();
		inGrid.removeCheckedRows(false);
		inGrid.request('modifyData',{'showConfirm' : false});
	});

	//업체명단 input 클릭시
	/* $('#coNm')
	.on(
			'click',
			function() {
				dialog3.dialog("open");
				$("#dialog-co")
						.load(
								"${pageContext.request.contextPath}/modal/coNmList",
								function() {
									CoList()
								})
			}); */

	//전표 조회버튼		
	$('#findgrid2').on('click',function() {
		dialog3.dialog("open");
		$("#dialog-sl").load("${pageContext.request.contextPath}/modal/slipOutput",function() {
			slList()
			})
			})
	$('#findgrid3').on('click',function() {
		dialog3.dialog("open");
		$("#dialog-sl").load("${pageContext.request.contextPath}/modal/slipOutput",function() {
			slList()
			})
			})

	const outGrid = new tui.Grid(
			{
				el : document.getElementById('outGrid'), // 컨테이너 엘리먼트
				data : {
					api : {
						readData : {
							url : '${pageContext.request.contextPath}/grid/slipOutput.do',
							method : 'GET'
						},
						modifyData : {
							url : '${pageContext.request.contextPath}/grid/slipOutputUpdate.do',
							method : 'POST',
							cache : false/* ,
							initParams: { indicaDetaNo : outGrid.getValue(rowKeyNm,"slipDetaNo"),
								prdtCd : outGrid.getValue(rowKeyNm,"prdtCd")
								}*/
						}
					},
					initialRequest : false,
					contentType : 'application/json'
				},
				bodyHeight : 500,
				rowHeaders : [ {
					type : 'rowNum',
					width : 100,
					align : 'left',
					valign : 'bottom'
				}, {
					type : 'checkbox'
				} ],
				columns : [ {
					header : '전표번호',
					name : 'slipNo',
					hidden : true,
					align : 'center'
				}, {
					header : '전표상세번호',
					name : 'slipDetaNo',
					hidden : true,
					align : 'center'
				}, {
					header : '출고일자',
					name : 'prdtDt',
					align : 'center'
				}, {
					header : '주문번호',
					name : 'orderNo',
					editor : 'text',
					validation: {
					        required: true
					      },
							align : 'center'
				}, {
					header : '회사명',
					name : 'coNm',
					align : 'center'
				}, {
					header : '제품코드',
					name : 'prdtCd',
					hidden : true,
					align : 'center'
				}, {
					header : '제품명',
					name : 'prdtNm',
					align : 'center'
				},{
					header : '주문량',
					name : 'orderQty',
					align : 'center'
				},{
					header : '남은주문량',
					name : 'restQty',
					align : 'center'
				}, {
					header : '출고량',
					name : 'oustQty',
					editor : 'text',
					align : 'center'
				}, {
					header : '제품 재고',
					name : 'prdtStc',
					align : 'center'
				}, {
					header : '금액',
					name : 'prdtUntprc',
					align : 'center'
				}, {
					header : '단가',
					name : 'prdtAmt',
					hidden : true,
					align : 'center'
				}

				],
			});
			
	//그리드 값 변하면 다시 뿌려주게끔
	outGrid.on('onGridUpdated', function() {
		
	outGrid.refreshLayout();
	});
	outGrid.on('response', function(ev) {
	
		let res = JSON.parse(ev.xhr.response);
		if (res.mode == 'upd') {
			outGrid.clear(); 
			/* $.ajax({
				url:'${pageContext.request.contextPath}/ajax/resetOw.do',
				dataType: 'json',
				contentType: 'application/json; charset=utf-8',
				
			}).done(function(res){
				a=res["num2"];
				$("#slipNm").val(
						"SLI" + (d.toISOString().slice(0, 10)).replaceAll("-", "")
								+ a);
		})*/
	}
		});

	
	//행추가버튼
	$('#insertBtn2').on('click', function appendRow(index) {
		outGrid.appendRow(
				{'slipNo':$("#slipNm").val(),'slipDetaNo':tempNo++,'prdtDt':d.toISOString().slice(0, 10)}, 
				{extendPrevRowSpan : true,focus : true,at : 0}
				);
		});
	$('#updateBtn2').on('click',function appendRow(index) {
				//버튼누르면 전표번호 값 업데이트
				outGrid.blur();
				outGrid.request('modifyData');
				sendMsgToParent('출고전표발행','/sales/mng/prdt_inout_mng');
			});
	
	$('#deleteBtn2').on('click', function appendRow(index) {
		outGrid.blur();
		for(let i of outGrid.getCheckedRowKeys()){
		var slParams = {
				'indicaDetaNo' : outGrid.getValue(i,"slipDetaNo")
			}
		
			$.ajax({
				url:'${pageContext.request.contextPath}/ajax/resetOw.do',
				data: slParams,
				contentType: 'application/json; charset=utf-8',
				async: false,
			}).done(function(res){
			})	 
		}
		outGrid.removeCheckedRows(false);
	});

	//주문번호 modal
	outGrid.on("click",(ev)=>{
		
		if(ev["columnName"]=="orderNo" && outGrid.getValue(ev["rowKey"],"orderNo")==null){
			dialog4.dialog("open");
			$("#dialog-ord").load(
					"${pageContext.request.contextPath}/modal/orderList.do",function() {
						rowKeyNm=ev["rowKey"];
						ordList()
						})
			
		}else if(ev["columnName"]=="orderNo"){
			dialog4.dialog("open");
			$("#dialog-ord").load("${pageContext.request.contextPath}/modal/orderList.do",function() {
				rowKeyNm=ev["rowKey"];
				ordList(outGrid.getValue(ev["rowKey"],"orderNo"))
			})
			
		}else if(ev["columnName"]=="oustQty"){
			dialog5.dialog("open");
			$("#dialog-outLot").load("${pageContext.request.contextPath}/modal/outWaitList.do",function() {
				rowKeyNm=ev["rowKey"];
				outWaitList()
			})
		}
		
	})
	
	
	//제품 lot관리 그리드(숨겨짐)
	const outGrid2 = new tui.Grid(
			{
				el : document.getElementById('outGrid2'), // 컨테이너 엘리먼트
				data : {
					api : {
						readData : {
							url : '${pageContext.request.contextPath}/grid/getSlipList.do',
							method : 'GET'
						}
					},
					initialRequest : false,
					contentType : 'application/json'
				},

				bodyHeight : 500,
				rowHeaders : [ {
					type : 'rowNum',
					width : 100,
					align : 'left',
					valign : 'bottom'
				} ],
				columns : [  {
					header : '전표번호',
					name : 'slipNo',
					hidden : true,
					align : 'center'
				}, {
					header : '전표상세번호',
					name : 'slipDetaNo',
					hidden : true,
					align : 'center'
				}, {
					header : '출고일자',
					name : 'prdtDt',
					align : 'center'
				}, {
					header : '주문번호',
					name : 'orderNo',
					align : 'center'
				}, {
					header : '회사명',
					name : 'coNm',
					align : 'center'
				}, {
					header : '제품코드',
					name : 'prdtCd',
					hidden : true,
					align : 'center'
				}, {
					header : '제품명',
					name : 'prdtNm',
					align : 'center'
				},{
					header : '주문량',
					name : 'orderQty',
					align : 'center'
				}, {
					header : '출고량',
					name : 'oustQty',
					align : 'center'
				}, {
					header : '금액',
					name : 'prdtUntprc',
					align : 'center'
				}

				]

			});

	
	//주문번호 modal
	outGrid2.on("click",(ev)=>{
		if(ev["columnName"]=="oustQty"){
			if(outGrid2.getValue(ev["rowKey"],"oustQty")!=0){
		
			dialog6.dialog("open");
			$("#dialog-outEndList").load("${pageContext.request.contextPath}/modal/outEndList.do",function() {
				rowKeyNm=ev["rowKey"];
				outEndList()
				})
		}else{
			toastr.warning("출고수량이 없습니다.")	
		}
	}})
	
	outGrid2.on('onGridUpdated', function() {
		$('td[data-column-name$="oustQty"]').css('backgroundColor','#ffeeee');
		outGrid2.refreshLayout();
		setTimeout(()=>{$('td[data-column-name$="oustQty"]').css('backgroundColor','#ffeeee')},1000);
		});
	
	outGrid2.refreshLayout();
	outGrid.refreshLayout();
	inGrid.refreshLayout();
	$('#sensePrdtIn').resize(function(){
		if($('#sensePrdtIn').width()<1780){
			$('#sensePrdtInBody').css('paddingLeft','15px');
		}else{
			$('#sensePrdtInBody').css('paddingLeft','40px');
		}
	})
	$('#sensePrdtOut1').resize(function(){
		if($('#sensePrdtOut1').width()<1780){
			$('#sensePrdtOut1Body').css('paddingLeft','15px');
		}else{
			$('#sensePrdtOut1Body').css('paddingLeft','40px');
		}
	})
	$('#sensePrdtOut2').resize(function(){
		if($('#sensePrdtOut2').width()<1780){
			$('#sensePrdtOut2Body').css('paddingLeft','15px');
		}else{
			$('#sensePrdtOut2Body').css('paddingLeft','40px');
		}
	})
</script>
</body>
</html>