<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
.switches {
	
	width: 210px;
	height: 70px;
	border: 1px solid black;
	margin-top: -15px;
	box-shadow: 5px 5px 5px black;
}

.green-on {
	background-color: rgb(63, 216, 63);
}

.green-off {
	background-color: rgb(61, 84, 61);
}

.red-on {
	background-color: red;
}

.red-off {
	background-color: rgb(112, 61, 61);
}


.controller {
	margin-top:20px;
	background-color: lightgray;
	padding: 10px;
	border-radius: 15px;
	height: 120px;
}

#eh {
	height: 30px;
}

#grid2 {
	width: 97%;
}
</style>

<body>
	<h1>설비 비가동 관리</h1>
	<div class="row" id="senseOrder">
		<div class=" col-4">
			<div id="senseOrderBody"
				class="card card-pricing card-primary card-white card-outline"
				style="margin-left: 50px; margin-right: 30px; margin-top: 30px; padding-left: 70px;">
				<div class="card-body">
					<div data-role="fieldcontain"
						style="margin-bottom: 40px; margin-top: 40px;">
						<label>설비</label> <input type="text" id="eqmParam" name="eqmParam"
							placeholder="설비코드 또는 설비명">
					</div>
					<div data-role="fieldcontain" style="margin-bottom: 20px;">
						<input type="checkbox" id="isUoN"> <label for="isUoN">비가동설비</label>
						<input type="checkbox" id="isUoY"> <label for="isUoY">가동설비</label>
					</div>
				</div>
				<div class="card-footer" style="margin-bottom: 30px;">
					<button type="button" id="gridRequestData"
						style="margin-left: 60px">조회</button>
				</div>
			</div>
		</div>
		<div id="grid" class="col-7"
			style="margin-left: 50px; margin-right: 30px; margin-top: 30px;"></div>
	</div>
	<div class="row"
>
		<div class="col-7" style="margin-left:10px">
			<h2 id="eh2">비가동 내역( 설비명, 코드 )</h2>

			<div id="grid2"></div>
		</div>
		<div
			class="card card-pricing card-primary card-white card-outline col-4">
			<div class="card-body">
				
				<div class="unopDetail">
					<h3>비가동/재가동 관리</h3>
						<div data-role="fieldcontain" style="margin-bottom: 20px; margin-top: 50px;" >
					<label>비가동일시</label><input id="stt"  disabled></div>
						<div data-role="fieldcontain" style="margin-bottom: 20px;">
							<label>비가동사유</label><select id="uoNm" >
								<option value="notSelected" selected disabled>--비가동 사유
									선택--
							</select></div>
								<div data-role="fieldcontain" style="margin-bottom: 20px;">
								<label>비가동코드</label><input id="uoCd"  disabled></div>
								<div data-role="fieldcontain" style="margin-bottom: 20px;">
								<label>재가동일시</label><input id="edt"  disabled>
						
					</div>
					<div data-role="fieldcontain" style="margin-bottom: 20px;">
					<label>최종 확인 버튼</label>
					<div class="controller">
					<h4 id="eh" style="text-align:center">설비명</h4>
					<div class=" row">
					<div class="col-5">
						<div class="switches red-on" style="text-align:center; font-size:20px;color:white;padding-top:5px"><i class="fas fa-stop"></i><br>비가동</div></div><div class="col-1"></div>
						<div class="col-5"><div class="switches green-on" style="text-align:center;font-size:20px;color:white;padding-top:5px"><i class="fas fa-play"></i><br>재가동</div></div>
					</div>
				</div>
				</div>
			</div>
		</div>
</body>
<script>
	let unopCds = [];
	let event = {};
	event.rowKey = '';
	let stt = document.getElementById('stt');
	let edt = document.getElementById('edt');
	let eh = document.getElementById('eh');
	let eh2 = document.getElementById('eh2');
	let switches = document.getElementsByClassName('switches');
	let selectTag = document.getElementById('uoNm');
	let uoCdTag = document.getElementById('uoCd');
	let intervalFn;
	let eqmCd;
	
	switches[0].addEventListener('click', function () {
		let isValid = false;
		for (let i = 0; i < grid.getRowCount(); i++) {
			if (eh.innerText == grid.getValue(i, 'eqmNm'))
				isValid = true;
		}
		if (!isValid) {
			toastr.warning('관리할 설비를 먼저 선택해주세요.');
			return false;
		}
		if(grid.getValue(event.rowKey,'eqmYn')=='N'){
			toastr.error('이미 비가동된 설비입니다.')
			return false;
		}
		if(selectTag.value=='notSelected'){
			toastr.warning('비가동 사유를 선택해주세요.');
			return false;
		}
		toastr.info("<br><div align='right'><button type='button' id='toastrYes'>확인</button>&emsp;<button type='button' id='toastrNo'>취소</button></div>",'비가동 처리하시겠습니까?',
				{
			closeButton: false,
			allowHtml: true,
			onShown: function (toast) {
				$("#toastrYes").click(function(){
					eh.innerText = '요청 중..';
					fetch('${pageContext.request.contextPath}/ajax/eqmtoggle?eqmCd='+grid.getValue(event.rowKey,'eqmCd')+'&eqmYn=N&uoprCd='+selectTag.value)
					.then(()=>{
						refreshForm();
						gridRequest();
						grid2.readData();
						});
					});
				}
		});
		});
	
	switches[1].addEventListener('click', function () {
		let isValid = false;
		for (let i = 0; i < grid.getRowCount(); i++) {
			if (eh.innerText == grid.getValue(i, 'eqmNm'))
				isValid = true;
		}
		if (!isValid) {
			toastr.warning('관리할 설비를 먼저 선택해주세요.');
			return false;
		}
		if(grid.getValue(event.rowKey,'eqmYn')=='Y'){
			toastr.error('이미 가동중인 설비입니다.')
			return false;
		}
		toastr.info("<br><div align='right'><button type='button' id='toastrYes'>확인</button>&emsp;<button type='button' id='toastrNo'>취소</button></div>",'재가동 처리하시겠습니까?',
				{
			closeButton: false,
			allowHtml: true,
			onShown: function (toast) {
				$("#toastrYes").click(function(){
					eh.innerText ='요청 중..';
					fetch('${pageContext.request.contextPath}/ajax/eqmtoggle?eqmCd='+grid.getValue(event.rowKey,'eqmCd')+'&eqmYn=Y')
					.then(()=>{
						gridRequest();
						grid2.readData();
						refreshForm();
					});
				});
			}
		});
	});
	
	var Grid = tui.Grid;
	Grid.setLanguage('ko');

	const dataSource = {
		api: {
			readData: {
				url: '${pageContext.request.contextPath}/grid/eqmList.do',
				method: 'GET'
			},
		},
		contentType: 'application/json'
	};
	const uoDataSource = {
		api: {
			readData: {
				url: '${pageContext.request.contextPath}/grid/eqm/uoList',
				method: 'GET'
			},
		},
		contentType: 'application/json',
		initialRequest: false,
	};

	const grid = new Grid({
		el: document.getElementById('grid'),
		data: dataSource,
		pageOptions : {
			useClient : true,
			perPage : 6
		},
		bodyHeight: 240,
		scrollX: false,
		scrollY: false,
		columns: [{
				header: '설비코드',
				name: 'eqmCd',
				align: 'center',
			},
			{
				header: '설비구분',
				name: 'eqmFg',
				align: 'center',
			},
			{
				header: '설비명',
				name: 'eqmNm',
				align: 'center',
				width: 150,
			},
			{
				header: '모델',
				name: 'eqmMdl',
				align: 'center',
			},
// 			{
// 				header: '용량/규격',
// 				name: 'eqmSpec',
// 				align: 'center',
// 			},
// 			{
// 				header: '라인번호',
// 				name: 'liNo',
// 				align: 'center',
// 			},
			{
				header: '작업자',
				name: 'empId',
				align: 'center',
			},
			{
				header: '사용에너지',
				name: 'energy',
				align: 'center',
			},
			{
				header: '부하율',
				name: 'lf',
				align: 'center',
			},
			{
				header: '기준온도',
				name: 'temp',
				align: 'center',
			},
// 			{
// 				header: 'UPH',
// 				name: 'uph',
// 				align: 'center',
// 			},
			{
				header: '공정코드',
				name: 'prcsCd',
				align: 'center',
			},
			{
				header: '가동여부',
				name: 'eqmYn',
				align: 'center',
			},
		]
	});
	
	const grid2 = new Grid({
		el: document.getElementById('grid2'),
		data: uoDataSource,
		bodyHeight: 360,
		pageOptions : {
			useClient : true,
			perPage : 9
		},
		scrollX: false,
		scrollY: false,
		columns: [{
				header: '번호',
				name: 'eqmUoNo',
				align: 'center',
				width: 50,
			},
			{
				header: '설비코드',
				name: 'eqmCd',
				align: 'center',
			},
			{
				header: '설비명',
				name: 'eqmNm',
				align: 'center',
			},
			{
				header: '비가동코드',
				name: 'uoprCd',
				align: 'center',
			},
			{
				header: '비가동명',
				name: 'uoprNm',
				align: 'center',
			},
			{
				header: '시작시간',
				name: 'frTm',
				align: 'center',
			},
			{
				header: '종료시간',
				name: 'toTm',
				align: 'center',
			},
		]
	});
	
	let gridRequestData = document.getElementById('gridRequestData');
	gridRequestData.addEventListener('click',function(){
		gridRequest();
	});

	grid.on('click', function (ev) {
		if(ev.targetType!='cell')
			return false;
		event = ev;
		refreshForm();
		eh.innerText = grid.getValue(ev.rowKey, 'eqmNm');
		eh2.innerText = '비가동 내역( '+grid.getValue(ev.rowKey, 'eqmNm')+', '+grid.getValue(ev.rowKey, 'eqmCd')+' )';
		
		//그리드2
		eqmCd = grid.getValue(ev.rowKey,'eqmCd');
// 		fetch('${pageContext.request.contextPath}/grid/eqm/uoList')
// 		.then(data=>data.json())
// 		.then(result=>grid2.resetData(result));
		grid2.readData(1,{
			'eqmCd': eqmCd,
		});
		
		
		// 가동/비가동
		if (grid.getValue(ev.rowKey, 'eqmYn') == 'Y') {
			switches[0].classList.replace('red-off', 'red-on');
			switches[1].classList.replace('green-on', 'green-off');
			stt.value = new Date(+new Date() + 3240 * 10000).toISOString().replace("T", " ").replace(/\..*/, '');
			intervalFn = setInterval(sttDT,1000);
		} else if (grid.getValue(ev.rowKey, 'eqmYn') == 'N') {
			switches[0].classList.replace('red-on', 'red-off');
			switches[1].classList.replace('green-off', 'green-on');
			fetch('${pageContext.request.contextPath}/ajax/eqm/uoselect?eqmCd='+grid.getValue(ev.rowKey,'eqmCd'))
			.then(data=>data.json())
			.then(result=>{
				stt.value = result.unop.frTm;
				selectTag.value = result.unop.uoprCd;
				selectTag.disabled = true;
				uoCdTag.value = result.unop.uoprCd;
			});
			edt.value = new Date(+new Date() + 3240 * 10000).toISOString().replace("T", " ").replace(/\..*/, '');
			intervalFn = setInterval(edtDT,1000);
		} else {
			event = null;
			eh.innerText = '설비명';
			return false;
		}
	});
	
	grid.on('onGridUpdated',function(){
		  grid.refreshLayout();
		  rowColor();
	  });
	grid2.on('onGridUpdated',function(){
		  grid2.refreshLayout();
		  rowColor();
	  });
	
	document.addEventListener('click',function(ev){
		if(ev.target.className.includes('tui-page-btn'))
			rowColor();
	});
	
	function rowColor(){
		let rowCnt = grid.getRowCount();
		let rowCnt2 = grid2.getRowCount();
		for(let i = 0; i<rowCnt; i++){
			if(grid.getValue(i, 'eqmYn')=='Y'){
			 $('div#grid').find('td[data-row-key$="'+i+'"]').css('backgroundColor','#e9ffe3');
			} else if(grid.getValue(i, 'eqmYn')=='N'){
			 $('div#grid').find('td[data-row-key$="'+i+'"]').css('backgroundColor','#f7dad5');
			}} else if (grid.getValue(i, 'eqmYn')=='P'){
				$('div#grid').find('td[data-row-key$="'+i+'"]').css('backgroundColor','#bfe0b6');
			}
	  	}
		for(let i = 0; i<rowCnt2; i++){
			$('div#grid2').find('td[data-row-key$="'+i+'"]').css('backgroundColor','');
	  	}
	}
	
	fetch('${pageContext.request.contextPath}/ajax/unopcd')
	.then(data => data.json())
	.then(result=> unopCds = result.unopCds)
	.then(()=>{
		for (let unopCd of unopCds){
			let optTag = '<option value="'+ unopCd.uoprCd +'">'+unopCd.uoprNm+'</option>';
			selectTag.innerHTML += optTag;
		}
	})
	
	selectTag.addEventListener('change',function(ev){
		uoCdTag.value = selectTag.value;
	});
	
	function sttDT(){
		stt.value = new Date(+new Date() + 3240 * 10000).toISOString().replace("T", " ").replace(/\..*/, '');
	}
	function edtDT(){
		edt.value = new Date(+new Date() + 3240 * 10000).toISOString().replace("T", " ").replace(/\..*/, '');
	}
	function refreshForm(){
		clearInterval(intervalFn);
		eh.innerText = '설비명';
		switches[0].class
		edt.value = '';
		stt.value = '';
		selectTag.value = 'notSelected';
		selectTag.disabled = false;
		uoCdTag.value = '';
		switches[0].classList.replace('red-off', 'red-on');
		switches[1].classList.replace('green-off', 'green-on');
	}
	function gridRequest(){
		let uoYn = '';
		if(document.getElementById('isUoY').checked)
			uoYn += 'Y';
		if(document.getElementById('isUoN').checked)
			uoYn += 'N';
		grid.readData(1,{
			'eqmParam': document.getElementById('eqmParam').value,
			'uoYn': uoYn,
		});
	}
	$('#senseOrder').resize(function() {
		if ($('#senseOrder').width() < 1780) {
			$('#senseOrderBody').css('paddingLeft', '20px');
		} else {
			$('#senseOrderBody').css('paddingLeft', '40px');
		}
	})
</script>

</html>