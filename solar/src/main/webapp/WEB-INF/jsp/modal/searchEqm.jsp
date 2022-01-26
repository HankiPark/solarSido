<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<label>설비명</label>
	<input type="text" id="coNm">
	<label>설비코드</label>
	<input type="text" id="coCd">
	<button type="button" id="btnfindCo">조회</button>
	<div id="coGrid"></div>
</body>
<script>
var coGrid = new tui.Grid({
    el: document.getElementById('coGrid'),
    scrollX: false,
    scrollY: false,
    data: [],
    columns: [
      {
        header: '설비명',
        name: 'eqmNm'
      },
	  {
        header: '설비코드',
        name: 'coCd'
      },
      {
        header: '사업자등록번호',
        name: 'bizno'
      }
    ]
  });
  
var btnfindCo = document.getElementById("btnfindCo");
btnfindCo.addEventListener('click',function(){
	  let coNm = document.getElementById('coNm').value;
	  let coCd = document.getElementById('coCd').value;
	  request(coNm, coCd);
});


</script>
</html>