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
		border-radius: 100px;
		width: 100px;
		height: 100px;
		border: 1px solid black;
		margin: 5px
	}

	.green-on {
		background-color: rgb(63, 216, 63);
	}

	.green-off {
		background-color: rgb(61, 84, 61);
	}

	.yellow {
		background-color: yellow;
	}

	.red-on {
		background-color: red;
	}

	.red-off {
		background-color: rgb(112, 61, 61);
	}

	.row {
		height: 40px;
	}

	.controller {
		background-color: lightgray;
		padding: 10px;
		border-radius: 15px;
		height: 300px;
	}

	/*.unopDetail {
		border: 1px dotted black;
		border-radius: 15px;
		margin: 5px;
	}*/
</style>

<body>
	<h1>설비 비가동 관리</h1>
	<hr>
	<div>
		<div class="flex row">
			<div id="grid" class="col-8"></div>
			<div class="col-1 controller" align="center">
				<h4 id="eh">비가동 관리</h4>
				<hr>
				<div>
					<div class="switches red-on">정지</div>
					<div class="switches green-on">재가동</div>
				</div>
			</div>
			<div class="col-2 unopDetail">
				<div class="flex row">
					<div class="col-4">
						<span class="row">비가동일시</span><br>
						<span class="row">비가동사유</span><br>
						<span class="row">비가동코드</span><br>
						<span class="row">재가동일시</span>
					</div>
					<div class="col-6">
						<input id="stt" class="row right" size="14" readonly><br>
						<select id="uoNm" class="row right">
							<option selected disabled>비가동 사유 선택
						</select><br>
						<input id="uoCd" class="row right" size="14" readonly><br>
						<input id="edt" class="row right" size="14" readonly>
					</div>
				</div>
			</div>
		</div>
	</div>
	<br><br><br><br><br><br><br><br><br><br><br><br><br>
	<hr>
	<div id="grid2"></div>
</body>
<script>
	let unopCds = [];
	let event;
	let stt = document.getElementById('stt');
	let edt = document.getElementById('edt');
	let eh = document.getElementById('eh');
	let switches = document.getElementsByClassName('switches');
	let selectTag = document.getElementById('uoNm');
	let uoCdTag = document.getElementById('uoCd');
	
	switches[0].addEventListener('click', function () {
		if(grid.getValue(event.rowKey,'eqmYn')=='N'){
			alert('이미 비가동된 설비입니다.')
			return false;
		}
		let isValid = false;
		for (let i = 0; i < grid.getRowCount(); i++) {
			if (eh.innerText == grid.getValue(i, 'eqmNm'))
				isValid = true;
		}
		if (!isValid) {
			alert('관리할 설비를 먼저 선택해주세요.');
			return false;
		}
		let sure = confirm('정지하시겠습니까?');
		if (!sure) {
			return false;
		}
		eh.innerText +='*';
		fetch('${pageContext.request.contextPath}/ajax/eqmtoggle?eqmCd='+grid.getValue(event.rowKey,'eqmCd')+'&eqmYn=N')
		.then(grid.readData())
		stt.value = 'asdfasdf';
	});

	var Grid = tui.Grid;

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
		contentType: 'application/json'
	};

	const grid = new Grid({
		el: document.getElementById('grid'),
		data: dataSource,
		bodyHeight: 300,
		rowHeaders: ['checkbox'],
		columns: [{
				header: '설비코드',
				name: 'eqmCd'
			},
			{
				header: '설비구분',
				name: 'eqmFg',
			},
			{
				header: '설비명',
				name: 'eqmNm',
			},
			{
				header: '모델',
				name: 'eqmMdl',
			},
			{
				header: '용량/규격',
				name: 'eqmSpec',
			},
			{
				header: '라인번호',
				name: 'liNo',
			},
			{
				header: '작업자',
				name: 'empId',
			},
			{
				header: '사용에너지',
				name: 'energy',
			},
			{
				header: '부하율',
				name: 'lf',
			},
			{
				header: '기준온도',
				name: 'temp',
			},
			{
				header: 'UPH',
				name: 'uph',
			},
			{
				header: '공정코드',
				name: 'prcsCd',
			},
			{
				header: '가동여부',
				name: 'eqmYn',
			},
		]
	});
	
	const grid2 = new Grid({
		el: document.getElementById('grid2'),
		data: uoDataSource,
		columns: [{
				header: '설비비가동번호',
				name: 'eqmUoNo'
			},
			{
				header: '설비코드',
				name: 'eqmCd',
			},
			{
				header: '설비명',
				name: 'eqmNm',
			},
			{
				header: '비가동코드',
				name: 'uoprCd',
			},
			{
				header: '비가동명',
				name: 'uoprNm',
			},
			{
				header: '시작시간',
				name: 'frTm',
			},
			{
				header: '종료시간',
				name: 'toTm',
			},
		]
	});

	grid.on('dblclick', function (ev) {
		event = ev;
		eh.innerText = grid.getValue(ev.rowKey, 'eqmNm');
		if (grid.getValue(ev.rowKey, 'eqmYn') == 'Y') {
			switches[0].classList.replace('red-off', 'red-on');
			switches[1].classList.replace('green-on', 'green-off');
		} else if (grid.getValue(ev.rowKey, 'eqmYn') == 'N') {
			switches[0].classList.replace('red-on', 'red-off');
			switches[1].classList.replace('green-off', 'green-on');
		} else {
			alert('err');
			event = undefined;
			return false;
		}
	});
	
	
	fetch('${pageContext.request.contextPath}/ajax/unopcd')
	.then(data => data.json())
	.then(result=> unopCds = result.unopCds)
	.then(()=>{
		for (let unopCd of unopCds){
			//let optTag = document.createElement('option');
			//optTag.innerText = unopCd.uoprNm;
			//selectTag.appendChild(optTag);
			let optTag = '<option value="'+ unopCd.uoprCd +'">'+unopCd.uoprNm+'</option>';
			selectTag.innerHTML += optTag;
		}
	})
	
	selectTag.addEventListener('change',function(ev){
		uoCdTag.value = selectTag.value;
	});
</script>

</html>