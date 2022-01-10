<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>

<body>
  <h1>자재발주정보</h1>
  <form id="ordrQueryFrm" name="ordrQueryFrm">
    발주일: <input type="date" id="ordrDtStt" name="ordrDtStt">~<input type="date" id="ordrDtEnd" name="ordrDtEnd"><br>
    발주업체: <input type="text" id="co"><button type="button" id="coSearchBtn">ㅇ-</button>
    자재: <input type="text" id="rsc"><button type="button" id="rscSearchBtn">ㅇ-</button>
    <button type="button" id="ordrQueryBtn">조회</button>
  </form>
  <div id="grid"></div>
</body>

<script>
  //그리드
  var grid = new tui.Grid({
    el: document.getElementById('grid'),
    scrollX: false,
    scrollY: false,
    data: [],
    columns: [{
        header: '발주일',
        name: 'ordrDt'
      },
      {
        header: '자재명',
        name: 'rscNm'
      },
      {
        header: '자재코드',
        name: 'rscCd'
      },
      {
        header: '발주량',
        name: 'ordrQty'
      },
      {
        header: '입고량',
        name: 'rscIstQty'
      },
      {
        header: '발주번호',
        name: 'ordrCd'
      },
      {
        header: '업체',
        name: 'coNm'
      }
    ]
  });

  $.ajax({
    url: "ordrData",
    method: "GET",
    dataType: "JSON"
  }).done(function (result) {
	  console.log(result);
    grid.resetData(result.rscOrdr);
    grid.refreshLayout();
  });
</script>
<script>
  let ordrQueryBtn = document.getElementById("ordrQueryBtn");
  ordrQueryBtn.addEventListener("click", function () {
    
	let ordrDtStt = document.ordrQueryFrm.ordrDtStt.value;
	let ordrDtEnd = document.ordrQueryFrm.ordrDtEnd.value;
	let co = document.ordrQueryFrm.co.value;
	let rsc = document.ordrQueryFrm.rsc.value;

    $.ajax({
      url: "ordrData?ordrDtStt="+ordrDtStt+"&ordrDtEnd="+ordrDtEnd+"&co="+co+"&rsc="+rsc,
      method: "GET",
      dataType: "JSON",
      //data: JSON.stringify(obj)
    }).done(function (result) {
    	console.log(result);
      grid.resetData(result.rscOrdr);
      grid.refreshLayout();
    });
  })
</script>

</html>