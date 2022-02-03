<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산지시 관리</title>
</head>

<body>
	<h2>생산지시 관리</h2>
	<hr />

	<!-- 모달 -->
	<div id="planModal" title="미지시 계획 조회"></div>
	<div id="indicaModal" title="미공정 생산지시서 목록"></div>
	<div id="indicaDetailModal" title="생산지시서 조회"></div>
	<!-- <div id="eqmUoModal" title="설비현황 조회"</div> -->

	<!-- 생산지시 테이블 -->
	<div class="row">
		<div class="col-9">
			<form name="indicaMngFrm">
				<div>
					<label>지시일자<span style="color: red">*</span></label> 
					<input type="date" id="indicaDt" name="indicaDt" required> 
					<label>생산지시명<span	style="color: red">*</span></label> 
					<input type="text" id="indicaNm" name="indicaNm" required>
				</div>
				<div>
					<button type="button" id="btnReset">초기화</button>
					<button type="button" id="btnSave">저장</button>
					<!-- <button type="button" id="btnDel">삭제</button> -->
				</div>
			</form>
		</div>
		<div class="col-3">
			<label>생산지시서 조회</label>
			<button type="button" id="btnFind">🔍</button>
		</div>
	</div>
	<hr />

	<!-- 생산지시 상세 그리드-->
	<div id="indicaDgrid" class="row">
		<div class="col-6">
			<label>지시번호</label> <input type="text" id="indicaNo" name="indicaNo"
				readonly>
		</div>
		<div id="btnMng" class="col-6">
			<!-- <button type="button" id="eqmSearch">설비조회</button> -->
			<button type="button" id="planSearch">미지시계획</button>
			<button type="button" id="indicaSearch">지시수정</button>
			<button type="button" id="rowAdd">추가</button>
			<button type="button" id="rowDel">삭제</button>
		</div>
	</div>
	<hr />

	<div class="row">
		<!-- 소요자재 그리드 -->
		<div id="rscGrid" class="col-5">
			<form name="rscFrm">
				<label>지시상세번호</label> 
				<input type="text" id="idcDno" name="idcDno" readonly> <br> 
				<label>제품코드</label> 
				<input type="text"	id="prdtCd" name="prdtCd" readonly>
				<!-- <label>제품명</label>  -->
				<input type="hidden" id="prdtNm" name="prdtNm" readonly>
			</form>
		</div>
		<!-- 자재별 lot 선택 그리드 -->
		<div id="rscLotGrid" class="col-7">
			<form name="rscLotFrm">
				<label>자재코드</label> 
				<input type="text" id="rscCd" name="rscCd" readonly> 
				<!-- <label>자재명</label>  -->
				<input type="hidden" id="rscNm" name="rscNm" readonly> <br> 
				<label>총 소요량</label> 
				<input type="text" id="totalUseQty" name="totalUseQty" readonly>
			</form>
		</div>
	</div>
	<br>
	
	<div>
		<button type="button" id="rscReset">초기화</button>
		<button type="button" id="lotSend">lot생성</button>
	</div>
	
	<!-- 소요자재 히든그리드 -->
	<div id="hdRscConGrid"></div>
	<!-- 제품lot별 자재lot 부여 히든그리드 -->
	<div id="hdPrdtRscGrid"></div>

</body>

<!-- 스크립트 -->
<script type="text/javascript">
	//------------------------------변수------------------------------------------------
	let iDt = new Date();
	let idcDt = iDt.toISOString().substring(0, 10);
	document.getElementById('indicaDt').value = idcDt;
	let idt = idcDt.replaceAll("-","");
	
	let idcQty;
	let totalQty;
	let idcNo;
	let orderNo;
	let totalUse;
	
	//제품-자재 lot 연결
	let lotArr = []; 	//list
	let lotData = {}; 	//obj
	let arr=[];
	let obj={};
	let pdIdx=0;
	let prdtLotNum=0;
	
	let arr1;
	let arr2;
	let arr3;
	let arr4;
	let arr5;
	let arr6;
	// 자재별 lot 사용 갯수: arr(i).length
	
	//let chkLot; //체크된 행 담기
	//let udLot;
	
	//공통 - 제품코드 가져옴
	$.ajax({
		url: '${pageContext.request.contextPath}/ajax/cmmn/code',
		dataType: 'JSON',
		async: false,
	}).done(function (data) {
		//console.log(data)
		cmmnCodes = data;
	});

	//------------------------------그리드생성------------------------------------------------
	//지시 조회 그리드
	let indicaDgrid = new tui.Grid({
		el: document.getElementById('indicaDgrid'),
		data: {
			  api: {
			    	readData: {
						url: '${pageContext.request.contextPath}/grid/indicaGrid.do', 
						method: 'GET'
			    				},
			    	/* modifyData: {
			    		url: '${pageContext.request.contextPath}/grid/indicaModify.do', 
						method: 'POST'
								} */
			  },
				contentType: 'application/json',
				initialRequest: false //초기에 안보이게 함
			},
		scrollX: false,
		scrollY: true,
		bodyHeight: 200,
		rowHeaders: [{
			type: 'checkbox',
			width: 40}],
		columns: [
					 {
					    header: '지시상세번호',
					    name: 'indicaDetaNo',
				        //hidden: true
					  },
					  {
					    header: '지시번호',
					    name: 'indicaNo',
					    hidden: true
					  },
					  {
					    header: '지시명',
					    name: 'indicaNm',
					    hidden: true
					  },
					  {
					    header: '주문번호',
					    name: 'orderNo',
				    	sortingType: 'desc',
				        sortable: true
					  },
					  {
					    header: '업체코드',
					    name: 'coCd',
				    	sortingType: 'desc',
				        sortable: true
					  },
					  {
					    header: '제품코드',
					    name: 'prdtCd',    
					    formatter: 'listItemText',
				    	editor: {
				    		type:'select',
				    		options: {
				    			listItems: cmmnCodes.codes.prod
					    		}
					  		},
				    	sortingType: 'desc',
				        sortable: true,
				        validation: {
			    	        required: true
		    	      }
					  },		  
					  {
					    header: '제품명',
					    name: 'prdtNm'
					  },
					  {
					    header: '납기일자',
					    name: 'paprdDt',
					    sortingType: 'desc',
				        sortable: true
					  },
					  {
					    header: '주문량',
					    name: 'orderQty',
					    sortingType: 'desc',
				        sortable: true
					  },
					  {
					    header: '계획량',
					    name: 'planQty',
					    sortingType: 'desc',
				        sortable: true
					  },
					  {
					    header: '지시량',
					    name: 'indicaQty',
					    editor : 'text',
					    validation: {
			    	        required: true
			    	      },
			    	       onAfterChange(e) {
				    			console.log("e.rowkey:"+e.rowKey+" & e.value:"+e.value);
				    	    	indicaDgrid.setValue(e.rowKey, 'prodDay',
				    	    					e.value / indicaDgrid.getValue(e.rowKey, 'dayOutput'));
				    	    	b = e.value;
				    	    	for ( i=0; i< rscGrid.getRowCount(); i++){
				    	    		rscGrid.setValue(i, 'totalUseQty',
		    	    					b * rscGrid.getValue(i, 'rscUseQty'));
				    	    	}
				    	    }    	
					  },
					  {
					    header: '일생산량',
					    name: 'dayOutput',
					  },
					  {
					    header: '생산일수',
					    name: 'prodDay',
					  },
					  {
					    header: '생산구분',
					    name: 'prodFg',
					    formatter: 'listItemText',
				    	editor: {
				    		type:'select',
				    		options: {
				    			listItems: [
				    				{text:'정상', value:'정상'},
				    				{text:'재작업', value:'재작업'}
				    				]
					    		}
					  		}
					  },
					  {
					    header: '작업일자',
					    name: 'wkDt',
					    editor :'datePicker',
					    sortingType: 'desc',
				        sortable: true,
				        validation: {
			    	        required: true
			    	      }
					  },
					  {
					    header: '작업순서',
					    name: 'wkOrd',
					    editor: 'text'
					  },
					  {
					    header: '제품LOT_NO',
					    name: 'prdt_lot'
					  }
			 		 ]
			});
	
	//제품별 소요 자재 목록 그리드
	let rscGrid = new tui.Grid({
		el: document.getElementById('rscGrid'),
		data: {
			  api: {
			    	readData: {
						url: '${pageContext.request.contextPath}/grid/rscGrid.do', 
						method: 'GET',
						initParams : { prdtCd: 'prdtCd'}
			    				}
			  },
				contentType: 'application/json',
				initialRequest: false //초기에 안보이게 함
			},
		scrollX: false,
		scrollY: true,
		rowHeaders : [ 'rowNum' ],
		selectionUnit : 'row',
		bodyHeight: 250,
		columns: [
					 {
					    header: '제품코드',
					    name: 'prdtCd',
					    //hidden: true
					  },
					  {
					    header: '주문번호',
					    name: 'orderNo',
					    hidden: true
					  },
					  {
					    header: '자재코드',
					    name: 'rscCd'
					  },
					  {
					    header: '자재명',
					    name: 'rscNm'
					  },
					  {
					    header: '소요량',
					    name: 'rscUseQty'
					  },
					  {
					    header: '총 소요량',
					    name: 'totalUseQty'
					  }
				],
		summary: {
	        position: 'bottom',
	        height: 50,
	        columnContent: {
	        	rscUseQty: {
	        		template: function(valueMap) {
	        			return '합계';
	        			},
	        		align:'center'
	        	},
	        	totalUseQty: {
					template: function(valueMap) {
						return valueMap.sum;
						}
				}
			}
	    }
	});
	
	//소요 자재 Lot 그리드
	let rscLotGrid = new tui.Grid({
		el: document.getElementById('rscLotGrid'),
		data:  {
			  api: {
			    	readData: {
						url: '${pageContext.request.contextPath}/grid/rscLotGrid.do', 
						method: 'GET',
						initParams : { rscCd: 'rscCd'}
			    				}
			  },
				contentType: 'application/json',
				initialRequest: false //초기에 안보이게 함
			},
		scrollX: false,
		scrollY: true,
		rowHeaders : [ 'checkbox', 'rowNum' ],
		bodyHeight: 250,
		columns: [
					 {
					    header: '자재코드',
					    name: 'rscCd',
					    //hidden: true
					  },
					  {
					    header: '소요량',
					    name: 'rscUseQty'
					  },
					  {
					    header: '주문번호',
					    name: 'orderNo',
					    hidden: true
					  },
					  {
					    header: '생산지시상세번호',
					    name: 'indicaDetaNo',
					  },
					  {
					    header: '자재LOT_NO',
					    name: 'rscLot'
					  },
					  {
					    header: '재고량',
					    name: 'rscStc'
					  },
					  {
					    header: '투입량',
					    name: 'rscQty',
					    editor: 'text',
					    onAfterChange(e) {
			    	    	rscLotGrid.setValue(e.rowKey, 'rscStc',
			    	    					rscLotGrid.getValue(e.rowKey, 'rscStc') - e.value);
			    	    	}
			    	    }    
				],
		summary: {
	        position: 'bottom',
	        height: 50,
	        columnContent: {
	        	rscStc: {
	        		template: function(valueMap) {
	        			return '합계';
	        			},
	        		align:'center'
				},
				rscQty: {
					template: function(valueMap) {
						return valueMap.sum;
						}
				}
	        }
	    }
	});
	
	//------------------------------히든 그리드------------------------------------------------
	//소요 자재 목록 히든그리드 : 생산소요자재T
	let hdRscConGrid = new tui.Grid({
		el: document.getElementById('hdRscConGrid'),
		data: null,
		scrollX: false,
		scrollY: true,
		rowHeaders : [ 'rowNum' ],
		bodyHeight: 250,
		columns: [
					 {
					    header: '지시상세번호',
					    name: 'indicaDetaNo',
					   // hidden: true
					  },
					  {
					    header: '자재코드',
					    name: 'rscCd'
					  },
					  {
					    header: '자재LOT_NO',
					    name: 'rscLot'
					  },
					  {
					    header: '소요량',
					    name: 'rscUseQty'
					  },
					  {
					    header: '투입량',
					    name: 'rscQty'
					  }
				],
			summary: {
		        position: 'bottom',
		        height: 50,
		        columnContent: {
		        	rscUseQty: {
		        		template: function(valueMap) {
		        			return '합계';
		        			},
		        		align:'center'
		        	},
		        	rscQty: {
						template: function(valueMap) {
							return valueMap.sum;
							}
					}
				}
		    }
	});
	
	//자재사용현황T 히든그리드: 제품lot별 자재lot 연결
	 let hdPrdtRscGrid = new tui.Grid({
		el: document.getElementById('hdPrdtRscGrid'),
		data: null,
		scrollX: false,
		scrollY: true,
		rowHeaders : [ 'rowNum' ],
		bodyHeight: 250,
		columns: [
					 {
					    header: '지시상세번호',
					    name: 'indicaDetaNo',
					 	// hidden: true
					  },
					  {
					 	header: '제품코드',
					    name: 'prdtCd',
						hidden: true
					  },
					  {
					 	header: '제품LOT_NO',
					    name: 'prdtLot',
					  },
					  {
					    header: '자재코드',
					    name: 'rscCd',
						// hidden: true
					  },
					  {
					    header: '자재LOT_NO',
					    name: 'rscLot'
					  },
					  {
					    header: '소요량',
					    name: 'rscUseQty'
					  }
				]
	});
	
	//------------------------------그리드이벤트------------------------------------------------
	//지시상세 그리드 이벤트
	indicaDgrid.on('onGridUpdated', function() {
		indicaDgrid.refreshLayout();
		rscGrid.clear();
		rscLotGrid.clear();
	});
	 
	indicaDgrid.on('click', function(ev) {
		
	});	
	
	indicaDgrid.on('dblclick', function(ev){
		
	});

	
	indicaDgrid.on('editingFinish', function(ev) {
		idcQty = indicaDgrid.getValue(ev.rowKey, "indicaQty")
		idcNo =  indicaDgrid.getValue(ev.rowKey, "indicaDetaNo")
		orderNo = indicaDgrid.getValue(ev.rowKey, "orderNo")
		let prdtCd = indicaDgrid.getValue(ev.rowKey, "prdtCd")
		let prdtNm = indicaDgrid.getValue(ev.rowKey, "prdtNm")
		
		console.log(idcNo + "&" + prdtCd);
		$('#prdtCd').val(prdtCd);
		$('#prdtNm').val(prdtNm);
		$('#idcDno').val(idcNo);
		
		var rscGridParams = {
				'prdtCd' : prdtCd,
				'prdtNm' : prdtNm
		};
		rscGrid.readData(1, rscGridParams, true);
		
		if (ev.columnName == 'indicaQty') {
			//제품lot생성
			$.ajax({
				url:'${pageContext.request.contextPath}/ajax/makePrdtNo.do',
				dataType: 'json',
				contentType: 'application/json; charset=utf-8',
				async: false,
			}).done((res)=>{
				console.log(res)
				prdtLotNum = res.num
			})
			
		//제품수 * 해당 자재수만큼 obj 생성 -> arr
			arr.length = 0; // arr 초기화
			for (let i=0; i<indicaDgrid.getValue(ev.rowKey, "indicaQty") * rscGrid.getRowCount() ; i++){
				obj= {	'indicaDetaNo': idcNo,
						'prdtCd': indicaDgrid.getValue(0, 'prdtCd'),
						'prdtLot':'',
						'rscCd':'',
						'rscLot':'',
						'rscUseQty':''
						} 
				arr.push(obj);
			}
		}
	});
		
	//자재목록 그리드 이벤트
	rscGrid.on('onGridUpdated', function() {
		rscGrid.refreshLayout(); 
		//rscLotGrid.refreshLayout();
		for ( i=0; i< rscGrid.getRowCount(); i++){
			rscGrid.setValue(i, 'totalUseQty',  1* idcQty * rscGrid.getValue(i, 'rscUseQty'));
		}
		rscLotGrid.refreshLayout(); 
	});
	
	//자재코드 눌렀을때 자재정보->arr
	function rsc(){
		let udr = rscLotGrid.getModifiedRows().updatedRows;
		console.log(udr)
		console.log(udr[0].rscQty)
		console.log(udr[0].rscUseQty)
		console.log(udr[0].rscLot)
		
		let c = 0; //자재 수
	 	for (i=0; i<udr.length; i++ ){ //a.length -> 로트종류
			for ( k=0; k<(udr[i].rscQty*1); k=k+(1*udr[i].rscUseQty)){
					//console.log("k:"+k)
					arr[pdIdx].rscLot = udr[i].rscLot
					arr[pdIdx].rscUseQty = udr[i].rscUseQty
					arr[pdIdx].rscCd = udr[i].rscCd
					arr[pdIdx].prdtLot = 'PRD'+ idt + lpad((prdtLotNum).toString(), 3,'0')
					pdIdx++ // 다음 lot 시작 인덱스
					prdtLotNum++
			}
		} 
	}
	
	rscGrid.on('dblclick', function(ev){
	/* 	if (rscLotGrid.getModifiedRows().updatedRows.length != 0) {
			rsc();
		}
		console.log(arr) */
		
			//console.log(rscLotGrid.getCheckedRows())
		//chkLot = rscLotGrid.getCheckedRows();
		//console.log(rscLotGrid.getModifiedRows().updatedRows)
	/* 			if (rscLotGrid.getModifiedRows().updatedRows.length != 0) {
			obj= rscLotGrid.getModifiedRows().updatedRows;
		} */
		udLot = rscLotGrid.getModifiedRows().updatedRows;
		console.log(udLot)
		if (rscLotGrid.getModifiedRows().updatedRows.length != 0) {
			//console.log(udLot[0].rscCd)
			let lotCd = udLot[0].rscCd
			switch (lotCd) {
				case 'r001':
					arr1 =  udLot;
					break;
				case 'r002' :
					arr2 = udLot;
					break;
				case 'r003':
					arr3 = udLot;
					break;
				case 'r004' :
					arr4 = udLot;
					break;
				case 'r005':
					arr5 =  udLot;
					break;
				case 'r006' :
					arr6 = udLot;
					break;
			}
		} 
		
		let rscCd = rscGrid.getValue(ev.rowKey, "rscCd")
		let rscNm = rscGrid.getValue(ev.rowKey, "rscNm")
		let prdtCd = rscGrid.getValue(ev.rowKey, "prdtCd")
		let totalUseQty = rscGrid.getValue(ev.rowKey, "totalUseQty")
		
		$('#rscCd').val(rscCd);
		$('#rscNm').val(rscNm);
		$('#totalUseQty').val(totalUseQty);
		
		var lotGridParams = {
				'rscCd' : rscCd,
				'rscNm' : rscNm,
				'prdtCd' : prdtCd,
				'totalUseQty' : totalUseQty
		};
		rscLotGrid.readData(1, lotGridParams, true);
		console.log(rscLotGrid.getModifiedRows().updatedRows.length);	
	});
	
	//소요 자재 Lot 그리드 -> 소요 자재 목록 히든그리드
	rscLotGrid.on("editingFinish", (rscEv) => {
		totalUse = rscLotGrid.getValue(rscEv.rowKey, 'rscQty')
		rscLotGrid.check(rscEv.rowKey)
		totalQty = $('#totalUseQty').val();
		if ( totalQty <= rscLotGrid.getSummaryValues('rscQty').sum ) {
			for ( i=rscEv.rowKey+1 ; i<rscLotGrid.getRowCount(); i++){
				rscLotGrid.disableRow(i, true)
			}
		}
		rscLotGrid.blur()
	})
	
	rscLotGrid.on("check", (rscEv) => {
      
     /*  if(rscLotGrid.getValue(rscEv.rowKey, 'rscQty') != ''){
    	  if(rscLotGrid.getValue(rscEv.rowKey, 'rscQty') != ''){
  			hdRscConGrid.appendRow(rscLotGrid.getRow(rscEv.rowKey),{
  				extendPrevRowSpan : false,
  				focus : true,
  				at : 0
  			});
  		} */
    	  if(hdRscConGrid.getColumnValues('rscLot').includes(rscLotGrid.getValue(rscEv.rowKey,'rscLot'))){
          var key = hdRscConGrid.findRows({'rscLot':rscLotGrid.getValue(rscEv.rowKey,'rscLot')})[0].rowKey;
          hdRscConGrid.setValue(key,'rscQty',rscLotGrid.getValue(rscEv.rowKey,'rscQty'));
	         }else{
	         hdRscConGrid.appendRow({'indicaDetaNo':rscLotGrid.getValue(rscEv.rowKey,'indicaDetaNo'),
	            'rscUseQty':rscLotGrid.getValue(rscEv.rowKey,'rscUseQty'),
	            'rscCd':rscLotGrid.getValue(rscEv.rowKey,'rscCd'),
	            'rscLot':rscLotGrid.getValue(rscEv.rowKey,'rscLot'),
	            'rscQty':rscLotGrid.getValue(rscEv.rowKey,'rscQty'),},{
	            extendPrevRowSpan : true,
	            focus : true,
	            at : 0
	         });
       } 
      
   })
	
	rscLotGrid.on("click", (rscEv) => {
		for ( i=0 ; i<rscLotGrid.getRowCount(); i++){
			rscLotGrid.setValue(i, 'indicaDetaNo', idcNo)
			rscLotGrid.setValue(i, 'orderNo', orderNo)
		}
	})
	
	rscLotGrid.on("uncheck", (rscEv) => {
		hdRscConGrid.removeRow(rscEv.rowKey);
		rscLotGrid.setValue(rscEv.rowKey, 'rscQty', '');
		if ( totalQty >= rscLotGrid.getSummaryValues('rscQty').sum ) {
			for ( i=rscEv.rowKey+1 ; i<rscLotGrid.getRowCount(); i++){
				rscLotGrid.enableRow(i, true)
			}
		}
	})
	
	
	rscLotGrid.on('onGridUpdated', function() {
		rscLotGrid.refreshLayout(); 
	});
	
	//히든 그리드 이벤트
	hdRscConGrid.on('onGridUpdated', function() {
		hdRscConGrid.refreshLayout();
	});
	
	//------------------------------버튼------------------------------------------------
	//초기화 버튼: 지시폼, 지시상세 그리드 초기화
	$('#btnReset').click(function() {
		indicaMngFrm.reset();
		rscFrm.reset();
		rscLotFrm.reset();
		indicaDgrid.resetData([]);
		rscGrid.resetData([]);
		rscLotGrid.resetData([]);
		hdRscConGrid.resetData([]);
	})

	//저장 버튼: 계획 + 계획상세 그리드 저장(수정, 입력, 삭제)
	$('#btnSave').on("click", function(){
		indicaNm = $('#indicaNm').val();
		indicaDt = $('#indicaDt').val();
		
		let hdData = {};
		hdData.hdRscConGrid = hdRscConGrid.getData();
		hdData.hdPrdtRscGrid = hdPrdtRscGrid.getData();
		console.log(hdData)
		
		if (indicaNm == null || indicaNm == ""){
			alert('필수입력칸이 비어있습니다.');
			$('#indicaNm').focus();
		} else {
			for ( i =0 ; i <= indicaDgrid.getRowCount(); i++) {
				indicaDgrid.setValue(i,'indicaNm',planNm);
				indicaDgrid.setValue(i,'indicaDt',planDt);
			}
			if(gridCheck()){
				if (confirm("지시를 저장하시겠습니까?")) { 
					planDgrid.blur();
					planDgrid.request('modifyData'); // modifyData의 url 호출
					
					$.ajax({
						url: '${pageContext.request.contextPath}/hiddenData',
						dataType: 'JSON',
						method: 'POST',
						data: JSON.stringify(hdData),
						contentType: 'application/json',
						success: function () {
							alert("완료");
						}
					})
				}
			}
		} 
	})
	
	//생산지시서 조회 버튼: 기간별 생산계획 조회 모달
	let indicaDetailDialog = $("#indicaDetailModal").dialog({
		autoOpen : false,
		modal : true,
		width : 900,
		height : 600,
		buttons : {
			'확인': function(){
				indicaDetailDialog.dialog("close");
			}
		}
	});
  
 	$('#btnFind').on('click', function(){
 		console.log("생산지시서 조회")
		indicaDetailDialog.dialog("open");
		$("#indicaDetailModal").load("${pageContext.request.contextPath}/modal/findIndicaDetail", 
									function() { indicaDetailList() })
	});
 	
 	//미지시계획 버튼: 미지시 계획상세 모달
	let planDetailDialog = $("#planModal").dialog({
		autoOpen : false,
		modal : true,
		width : 900,
		height : 400,
		buttons : {
			"확인" : function(){
				console.log('확인');
				planDetailDialog.dialog("close");
			},
			'취소': function(){
				planDetailDialog.dialog("close");
			}
		}
	});
 	
 	$('#planSearch').on('click', function(){
 		console.log("미지시 계획 검색")
		planDetailDialog.dialog("open");
		$("#planModal").load("${pageContext.request.contextPath}/modal/findPlanDlist", 
									function() { planDList() })
	});
 	
	//지시수정 버튼: 미공정 지시서 모달
	let indicaDialog = $("#indicaModal").dialog({
		autoOpen : false,
		modal : true,
		width : 900,
		height : 400,
		buttons : {
			'취소': function(){
				indicaDgrid.resetData([]);
				indicaDialog.dialog("close");
			}
		}
	});
	
 	$('#indicaSearch').on('click', function(){
 		console.log("작업지시서 검색")
		indicaDialog.dialog("open");
		$("#indicaModal").load("${pageContext.request.contextPath}/modal/findIndica", 
									function() { indicaList() })
	});
 	
 	//그리드 추가 버튼: 계획 없는 지시 등록
	rowAdd.addEventListener("click", function(idx){
		indicaDgrid.appendRow({},{
			extendPrevRowSpan : true,
			focus : true,
			at : 0
		});
		//지시상세번호 부여
		$.ajax({
				url:'${pageContext.request.contextPath}/ajax/makeDno.do',
				dataType: 'json',
				contentType: 'application/json; charset=utf-8',
				async: false,
			}).done((res)=>{
				console.log(res.num2)
				let idx = 0;
				for(i=0; i<indicaDgrid.getRowCount(); i++){
					if ( indicaDgrid.getValue (i, 'indicaNo') !=null ){
						console.log(idx)
					} else {
						indicaDgrid.setValue(i, 'indicaDetaNo', Number(res.num2)+1*idx)
						idx = Number(idx) +1
					}
				}
			})
	});
	
	//그리드 삭제 버튼
	//false면 확인 안하고 삭제함
	rowDel.addEventListener("click", function(){
		indicaDgrid.removeCheckedRows(true);
	});
	
	//히든 그리드 초기화버튼
	$('#rscReset').on('click', function(){
		hdRscConGrid.resetData([]);
		rscLotGrid.resetData([]);
	})
	
	 $('#lotSend').on('click', function(){
		//rsc();
		console.log("lot부여");
		 
	      let prdtCnt = indicaDgrid.getValue(0, 'indicaQty'); //제품수
	      let rscCnt = rscGrid.getRowCount(); //자재수
	      let list=[];
	      list.push(arr1);
	      list.push(arr2);
	      list.push(arr3);
	      list.push(arr4);
	      list.push(arr5);
	      list.push(arr6);
	      console.log(list);
	      
	      for(let li of list){
		      if(li != null){
		         var q =0;
		         lotData =  {'indicaDetaNo': idcNo,
		            'prdtCd': indicaDgrid.getValue(0, 'prdtCd'),
		            'prdtLot':'',
		            'rscCd':'',
		            'rscLot':'' ,
		            'rscUseQty':''
		            } 
	
			      for(let i =0 ; i< li.length ; i++){
			         lotData.rscCd = li[i].rscCd;
			         var useQty = li[i].rscUseQty;
			         var rscLot = li[i].rscLot;
			         var rscQty = li[i].rscQty;
			         var t =0;
			
			         if(lotData.rscUseQty !=li[i].rscUseQty && lotData.rscUseQty!=''){
			            //lotData push
			            lotData.rscLot= rscLot;
			            rscQty = rscQty-useQty+lotData.rscUseQty;
			            lotData.rscUseQty = useQty-lotData.rscUseQty;
			            lotArr.push(JSON.parse(JSON.stringify(lotData)));
			         }
			
			         for(let k =0; k*useQty<rscQty ; k++){
			            lotData.prdtLot = 'PRD'+ idt + lpad((q+1).toString(), 3,'0')
			            lotData.rscLot = rscLot;
			            lotData.rscUseQty = useQty;
			            lotArr.push(JSON.parse(JSON.stringify(lotData)));
			            console.log(lotData);
			            q++;
			            t++; 
			         }
			         
			         if(t*useQty==rscQty){
			        	 lotData.rscUseQty=''
			         } else {   
			            lotData.rscLot = rscLot;   
			            lotData.rscUseQty = rscQty%(t*useQty);
			            lotArr.push(JSON.parse(JSON.stringify(lotData)));
			         }
		      		}
		      }   
		     }
	      console.log("lotArr:")
	      console.log(lotArr);
		    
		//hdPrdtRscGrid.resetData(arr);
		hdPrdtRscGrid.appendRows(lotArr);
		//초기화
		arr.length = 0; 
		pdIdx=0;
	 })
	 	
	//------------------------------함수------------------------------------------------
 	//lpad 함수
	function lpad(s, padLength, padString){
	    while(s.length < padLength)
	        s = padString + s;
	    return s;
	}
</script>
</html>