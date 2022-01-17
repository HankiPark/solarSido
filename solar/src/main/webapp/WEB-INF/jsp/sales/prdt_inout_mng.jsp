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
					<button type="button" id="updateBtn"
						class="btn btn-default btn-simple btn-sm">저장</button>
					<button type="button" id="deleteBtn"
						class="btn btn-default btn-simple btn-sm">삭제</button>
				</div>
			</div>
		</div>

		<div id="inGrid"></div>
	</div>

	<div id="oG">


		<div>
			<button type="button" id="findgrid2">조회</button>
		</div>
		<div id="C">
			<label for="slipNm">부여될 전표번호</label><br> <input id="slipNm"
				type="text" readonly>

			<div class="card card-pricing card-primary card-white">
				<div class="card-body">
					<div align="right">
						<button type="button" id="insertBtn2"
							class="btn btn-default btn-simple btn-sm">추가</button>
						<button type="button" id="updateBtn2"
							class="btn btn-default btn-simple btn-sm">저장</button>
						<button type="button" id="deleteBtn2"
							class="btn btn-default btn-simple btn-sm">삭제</button>
					</div>
				</div>
			</div>
			<div id="outGrid"></div>

		</div>

		<div id="noC" style="display: none">
			<label for="slipNm2">조회중인 전표번호</label><br> <input id="slipNm2"
				type="text" readonly>

			<div class="card card-pricing card-primary card-white">
				<div class="card-body">
					<div align="right">
						<button type="button" id="excelBtn"
							class="btn btn-default btn-simple btn-sm">excel</button>

					</div>
				</div>
			</div>
			<div id="outGrid2"></div>

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
		//탭 설정
		const tabList = document.querySelectorAll('.tab_menu .list li');
		for (var i = 0; i < tabList.length; i++) {
			tabList[i].querySelector('.btn').addEventListener('click',
					function(e) {
						e.preventDefault();
						for (var j = 0; j < tabList.length; j++) {
							tabList[j].classList.remove('is_on');
						}
						this.parentNode.classList.add('is_on');
						if ($(this)[0].id == "in") {
							$("#oG").css("display", "none");
							$("#iG").css("display", "block");

							inGrid.refreshLayout();
							inGrid.clear();

						} else {
							$("#iG").css("display", "none");
							$("#oG").css("display", "block");
							$("#noC").css("display", "none");
							$("#C").css("display", "block");
						
								$.ajax({
									url:'${pageContext.request.contextPath}/ajax/resetOw.do',
									dataType: 'json',
									contentType: 'application/json; charset=utf-8',
									async: false,
									
									
								}).done((res)=>{
												console.log("초기화완료")
												a=res["num2"];
												
												//전표번호 부여(기본)
												$("#slipNm").val(
																"SLI" + (d.toISOString().slice(0, 10)).replaceAll("-", "")+ a);
									
									
								})
							outGrid.refreshLayout();
							outGrid.clear();
							outGrid2.refreshLayout();
							outGrid2.clear();
						}
					});
		}
		//날짜 설정(입고/출고)
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
		$('#prdNm')
				.on(
						'click',
						function() {
							dialog.dialog("open");
							$("#dialog-form")
									.load(
											"${pageContext.request.contextPath}/modal/prdtNmList",
											function() {
												NmList()
											})
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

					bodyHeight : 700,
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
						hidden : true
					}, {
						header : '입고일자',
						name : 'prdtDt',
						editor : 'datePicker'
					}, {
						header : '제품LOT',
						name : 'prdtLot',
						editor : 'text',
						relations : [ {
							targetNames : [ 'prdtCd', 'prdtNm', 'indicaNo' ],
							editable : false
						} ]
					}, {
						header : '제품코드',
						name : 'prdtCd'
					}, {
						header : '제품명',
						name : 'prdtNm',
					}, {
						header : '규격',
						name : 'prdtSpec'
					}, {
						header : '생산지시번호',
						name : 'indicaNo'
					}

					],
					

				});
		//그리드 값변하면 다시 뿌려주게끔
		inGrid.on('onGridUpdated', function() {
			inGrid.refreshLayout();
		});
		inGrid.on('response', function(ev) {
			console.log(ev);
			let res = JSON.parse(ev.xhr.response);
			if (res.mode == 'upd') {
				inGrid.resetOriginData();
			}
		});

		inGrid
				.on(
						'click',
						function(ev) {
							console.log(ev["columnName"]);
							console.log(inGrid
									.getValue(ev["rowKey"], "prdtLot"));
							if (ev["columnName"] == "prdtLot") {
								dialog2.dialog("open");
								$("#dialog-lot")
										.load(
												"${pageContext.request.contextPath}/modal/prdtInWaitList",
												function() {
													prdtInWait(ev["rowKey"]);
													inGrid.refreshLayout();
												})
							}
						});

		//조회버튼
		$('#findgrid').on('click', function() {

			var startT = $("#startT").val();
			var endT = $("#endT").val();
			var prdNm = $("#prdNm").val();
			var params = {
				'startT' : startT,
				'endT' : endT,
				'prdNm' : prdNm
			}

			$.ajax({
				url : '${pageContext.request.contextPath}/grid/prdtInput.do',
				data : params,
				dataType : "json",
				contentType : 'application/json; charset=utf-8',

			}).done(function(res) {
				/* inGrid.enable(); */
				inGrid.resetData(res["data"]["contents"]);
				/* 		for (var i = 0; i < sres["data"]["contents"].length; i++) {
							inGrid.disableRow(i);
						} */
			})

		})

		//행추가버튼
		$('#insertBtn').on('click', function appendRow(index) {

			inGrid.appendRow(null, {
				extendPrevRowSpan : true,
				focus : true,
				at : 0
			});

		});
		$('#updateBtn').on('click', function appendRow(index) {

			inGrid.blur(); 
			inGrid.request('modifyData');

		});
		$('#deleteBtn').on('click', function appendRow(index) {
			inGrid.blur();
			inGrid.removeCheckedRows(true);

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
		$('#findgrid2')
				.on(
						'click',
						function() {
							dialog3.dialog("open");
							$("#dialog-sl")
									.load(
											"${pageContext.request.contextPath}/modal/slipOutput",
											function() {
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

					bodyHeight : 700,
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
						hidden : true
					}, {
						header : '전표상세번호',
						name : 'slipDetaNo',
						hidden : true
					}, {
						header : '출고일자',
						name : 'prdtDt'
					}, {
						header : '주문번호',
						name : 'orderNo',
						editor : 'text'
					}, {
						header : '회사명',
						name : 'coNm'
					}, {
						header : '제품코드',
						name : 'prdtCd',
						hidden : true
					}, {
						header : '제품명',
						name : 'prdtNm'
					},{
						header : '주문량',
						name : 'orderQty',
					},{
						header : '남은주문량',
						name : 'restQty',
					}, {
						header : '출고량',
						name : 'oustQty',
						editor : 'text'
					}, {
						header : '제품 재고',
						name : 'prdtStc'
					}, {
						header : '금액',
						name : 'prdtUntprc'
					}, {
						header : '단가',
						name : 'prdtAmt',
						hidden : true
					}

					],
					

				});
		//그리드 값변하면 다시 뿌려주게끔
		outGrid.on('onGridUpdated', function() {
			
			outGrid.refreshLayout();
		});
		outGrid.on('response', function(ev) {
			console.log(ev);
			let res = JSON.parse(ev.xhr.response);
			if (res.mode == 'upd') {
				outGrid.clear(); 
				/* $.ajax({
					url:'${pageContext.request.contextPath}/ajax/resetOw.do',
					dataType: 'json',
					contentType: 'application/json; charset=utf-8',
					
					
					
				}).done(function(res){
					a=res["num2"];
					console.log("a는"+a)
					$("#slipNm").val(
							"SLI" + (d.toISOString().slice(0, 10)).replaceAll("-", "")
									+ a);
					
					
				
			})*/
		}
			});

		
		//행추가버튼
		$('#insertBtn2').on('click', function appendRow(index) {
			
			outGrid.appendRow({'slipNo':$("#slipNm").val(),'slipDetaNo':tempNo++,'prdtDt':d.toISOString().slice(0, 10)}, {
				extendPrevRowSpan : true,
				focus : true,
				at : 0
			});

		});
		$('#updateBtn2').on(
				'click',
				function appendRow(index) {
					//버튼누르면 전표번호값 업데이트
					outGrid.blur();
					outGrid.request('modifyData');
				
					

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
				$("#dialog-ord")
						.load(
								"${pageContext.request.contextPath}/modal/orderList.do",
								function() {
									rowKeyNm=ev["rowKey"];
									ordList()
								})
				
			}else if(ev["columnName"]=="orderNo"){
				dialog4.dialog("open");
				$("#dialog-ord")
						.load(
								"${pageContext.request.contextPath}/modal/orderList.do",
								function() {
									rowKeyNm=ev["rowKey"];
									ordList(outGrid.getValue(ev["rowKey"],"orderNo"))
								})
				
			}else if(ev["columnName"]=="oustQty"){
				dialog5.dialog("open");
				$("#dialog-outLot")
						.load(
								"${pageContext.request.contextPath}/modal/outWaitList.do",
								function() {
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

					bodyHeight : 700,
					rowHeaders : [ {
						type : 'rowNum',
						width : 100,
						align : 'left',
						valign : 'bottom'
					} ],
					columns : [  {
						header : '전표번호',
						name : 'slipNo',
						hidden : true
					}, {
						header : '전표상세번호',
						name : 'slipDetaNo'
					}, {
						header : '출고일자',
						name : 'prdtDt'
					}, {
						header : '주문번호',
						name : 'orderNo'
					}, {
						header : '회사명',
						name : 'coNm'
					}, {
						header : '제품코드',
						name : 'prdtCd',
						hidden : true
					}, {
						header : '제품명',
						name : 'prdtNm'
					},{
						header : '주문량',
						name : 'orderQty',
					}, {
						header : '출고량',
						name : 'oustQty'
					}, {
						header : '제품 재고',
						name : 'prdtStc'
					}, {
						header : '금액',
						name : 'prdtUntprc'
					}

					]

				});
		
		//주문번호 modal
		outGrid2.on("click",(ev)=>{
			if(ev["columnName"]=="oustQty"){
				dialog6.dialog("open");
				$("#dialog-outEndList")
						.load(
								"${pageContext.request.contextPath}/modal/outEndList.do",
								function() {
									rowKeyNm=ev["rowKey"];
									outEndList()
								})
			}
			
			
			
		})
		
		
		outGrid2.on('onGridUpdated', function() {
			console.log("리프레쉬")
			outGrid2.refreshLayout();
		});
		outGrid2.refreshLayout();
		outGrid.refreshLayout();
		inGrid.refreshLayout();
	</script>

</body>
</html>