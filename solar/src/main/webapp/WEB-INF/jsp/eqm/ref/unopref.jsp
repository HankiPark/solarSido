<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>

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
			<button type="button" id=gridRequestData>조회</button>
		</div>
			<div id="grid"></div>
	</div>
</body>
<script>
	let event;
	
	var Grid = tui.Grid;

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

</html>