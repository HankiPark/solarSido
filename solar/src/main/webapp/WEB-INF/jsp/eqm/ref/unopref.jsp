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
		width: 80px;
		height: 80px;
		border: 1px solid black;
		margin: 5px
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

	.row {
		height: 40px;
	}

	.controller {
		background-color: lightgray;
		padding: 10px;
		border-radius: 15px;
		height: 280px;
	}

	#eh{
		height: 30px;
	}
	
	#grid{
		width: 97%;
	}
	#rightDiv{
		position: relative;
		bottom: 70px;
		width: 97%;
 		text-align: left;
	}
</style>

<body>
	<h1>설비 비가동 조회</h1>
	<hr>
	<div>
		<div>
			<label>설비</label>
			<input type="text" id="eqmParam" name="eqmParam" placeholder="설비코드 또는 설비명">
			<input type="checkbox" id="isUoN">
			<label for="isUoN">비가동설비</label>
			<input type="checkbox" id="isUoY">
			<label for="isUoY">가동설비</label>
			<br><button type="button" id=gridRequestData>조회</button>
		</div>
		<br>
		<div class="flex row" align="center">
			<div id="grid" class="col-4">
				<h3>설비 목록</h3>
			</div>
			<div id="rightDiv" class="col-8">
				<div id="chart-area"></div>
				<div id="grid2">
					<h3 id="eh2">비가동 내역( 설비명, 코드 )</h3>
				</div>
			</div>
		</div>
	</div>
</body>
<script>
	let eh2 = document.getElementById('eh2');
	
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
			perPage : 12
		},
		bodyHeight: 480,
		scrollX: false,
		scrollY: false,
		rowHeaders: ['checkbox'],
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
				width: 110,
			},
			{
				header: '모델',
				name: 'eqmMdl',
				align: 'center',
			},
			{
				header: '작업자',
				name: 'empId',
				align: 'center',
			},
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
		bodyHeight: 200,
		pageOptions : {
			useClient : true,
			perPage : 5
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
		eh2.innerText = '비가동 내역( '+grid.getValue(ev.rowKey, 'eqmNm')+', '+grid.getValue(ev.rowKey, 'eqmCd')+' )';
		
		//그리드2
		let eqmCd = grid.getValue(ev.rowKey,'eqmCd');
		grid2.readData(1,{
			'eqmCd': eqmCd,
		});
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
			} else if (grid.getValue(i, 'eqmYn')=='P'){
				$('div#grid').find('td[data-row-key$="'+i+'"]').css('backgroundColor','#bfe0b6');
			}
	  	}
		for(let i = 0; i<rowCnt2; i++){
			$('div#grid2').find('td[data-row-key$="'+i+'"]').css('backgroundColor','');
	  	}
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
	
</script>

<script>
	const el = document.getElementById('chart-area');
	let data = {
	  categories: ['', '', '', '', '', '', '', '', '', '','','','','',new Date(+new Date() + 3240 * 10000).toISOString().substr(11,8)],
	  series: [ /* 라인 */ ],
	};
	const options = {
			lang: { noData: "데이터를 나타낼 설비를 체크해주십시오."},
			chart: { title: '실시간 설비 누적 비가동시간', width: 1050, height: 400 },
			xAxis: { pointOnColumn: false, title: { text: '현재' } },
			yAxis: { title: '누적 비가동시간' },
			series: {
			shift: true,
		  },
	};
	var chart = toastui.Chart.areaChart({ el, data, options });
	
    let graphInterval;
    
    function drawGraph(eqmCds){
	
	    fetch('${pageContext.request.contextPath}/ajax/eqm/uographdata',{
	        method: 'POST',
	        body: JSON.stringify({
	            eqmCds: eqmCds,
	        }),
	        headers: {
	            'Content-Type': 'application/json'
	        }
	    })
	    .then(data=>data.json())
	    .then((json)=>{
	    	
	    	data = {
	    			  categories: ['', '', '', '', '', '', '', '', '', '','','','','',new Date(+new Date() + 3240 * 10000).toISOString().substr(11,8)],
	    			  series: [],
	    			};
	    	
	    	for(let initialData of json.graphData){
				let i = initialData.seconds;
	    		data.series.push(new Object({"name":initialData.eqmNm+'( '+initialData.eqmCd+ ' )',"data":[i,i,i,i,i,i,i,i,i,i,i,i,i,i,i]}));
	    	}
	    	
	    })
	    .then(()=>{
	    	clearInterval(graphInterval);
	    	chart.destroy();
	    	chart = toastui.Chart.areaChart({ el, data, options });
	    })
	    .then(()=>{
	    	graphInterval = setInterval(()=>{
	    		
	    		fetch('${pageContext.request.contextPath}/ajax/eqm/uographdata',{
	    			method: 'POST',
	    	        body: JSON.stringify({
	    	            eqmCds: eqmCds,
	    	        }),
	    	        headers: {
	    	            'Content-Type': 'application/json'
	    	        }
	    		})
	   		    .then(data=>data.json())
	   			.then((json)=>{
	   				let arr = [];
					for(let intervalData of json.graphData){
						arr.push(intervalData.seconds);
					}
	   				
	   				chart.addData(arr,new Date(+new Date() + 3240 * 10000).toISOString().substr(11,8));
	   			})
		    }, 1000);
	    });
    }
	    
    grid.on('check',function(ev){
    	gridGetCheckedEqmCds();
    })
    grid.on('uncheck',function(ev){
    	gridGetCheckedEqmCds();
    })
    grid.on('checkAll',function(ev){
    	gridGetCheckedEqmCds();
    })
    grid.on('uncheckAll',function(ev){
    	gridGetCheckedEqmCds();
    })
    
    function gridGetCheckedEqmCds(){
    	let eqmCds = '';
    	let checkedRows = grid.getCheckedRows();
    	for(let row of checkedRows){
    		eqmCds += ','+row.eqmCd;
    	}
    	eqmCds = eqmCds.substr(1);
    	if(eqmCds==''){
    		clearInterval(graphInterval);
    		chart.clear();
    		return false;
    	}
    	drawGraph(eqmCds);
    }

</script>
</html>