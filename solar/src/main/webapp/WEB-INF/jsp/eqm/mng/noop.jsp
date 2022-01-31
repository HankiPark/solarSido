<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>설비 비가동 관리</h1><hr>
	<div class="flex row">
		<div id="grid" class="col-8"></div>
		<div class="col-3" align="center" style="background-color: lightgray; padding: 10px; border-radius: 15px">
			<h3>비가동</h3>
			시간1<input><br>
			시간2<input>
			<div align="left">
				<div style="border-radius:100px; background-color: green; width: 100px; height: 100px; border: 1px solid black; margin:5px"></div>
				<div style="border-radius:100px; background-color: yellow; width: 100px; height: 100px; border: 1px solid black; margin:5px"></div>
				<div style="border-radius:100px; background-color: red; width: 100px; height: 100px; border: 1px solid black; margin:5px"></div>
			</div>
		</div>
	</div>
</body>
<script>
var Grid = tui.Grid;

const dataSource = {
    api: {
        readData: {url: '${pageContext.request.contextPath}/grid/eqmList.do',method: 'GET'},
    },
    contentType: 'application/json'
};

const grid = new Grid({
    el: document.getElementById('grid'),
    data: dataSource,
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
</script>
</html>