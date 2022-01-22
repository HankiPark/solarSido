<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>
</head>
<body>
	<h1>불량불량</h1>
	<div id="coModal" title="업체 목록"></div>
	연도<input type="text" id="year">
	발주업체: <input type="text" id="coCds" name="co"><button type="button" id="coSearchBtn">🔍</button>
	<br><button id="sendRequest" onclick="inferRequest()">조회</button>
	<div id="chartDiv"></div>
</body>
<script>
	let categories = [];
	let series;
	
	function inferRequest(){
		let year = document.getElementById('year').value;
		let coCds = document.getElementById('coCds').value;
		
	    fetch('inferGraphData',{
	        method:'POST',
	        body:JSON.stringify({coCds:coCds,year:year}),
	        headers:{'Content-Type':'application/json'}
	    }).then(data=>data.json())
	    .then((result)=>{
	    	for(let i of result.inferRates){
	    		categories.push(i.coCd);
	    	}
	        console.log(categories);
	    });
	}
    
	series = [
		{
            name: 'first',
            data: [2.7, 2, 1.1]
        },
        {
            name: 'second',
            data: [2, 1, 0.5]
        },
        {
            name: 'third',
            data: [2.7, 1, 1.2]
        },
        {
            name: 'fourth',
            data: [2.3, 1.6, 2.5]
        }];
	
	const el = document.getElementById('chartDiv');
    const data = {categories,series};
    const options = {
    		chart: {
    			title: '분기별 자재 불량률',
    			width: 900,
    			height: 400,
    		},
    };

    const chart = toastui.Chart.barChart({ el, data, options });
    
    let coDialog = $("#coModal").dialog({
        modal: true,
        autoOpen: false,
    	width : 600,
    	height : 600
      });

      $("#coSearchBtn").on("click", function () {
        coDialog.dialog("open");
        $("#coModal").load("../comul");
      });
      
</script>
</html>