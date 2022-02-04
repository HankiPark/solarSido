<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="chart-area"></div>
</body>
<script>
	const el = document.getElementById('chart-area');
	const data = {
	  categories: ['', '', '', '', '', '', '', '', '', '','','','','','00:00:00'],
	  series: [ /* 라인 */ ],
	};
	const options = {
	  chart: { title: '설비 누적 비가동시간', width: 800, height: 400 },
	  xAxis: { pointOnColumn: false, title: { text: '현재' } },
	  yAxis: { title: '누적 비가동시간' },
	  series: {
//		  spline: true,
		  shift: true,
		  },
	};
	var chart;// = toastui.Chart.areaChart({ el, data, options });
	
    let graphInterval;
    
    fetch('${pageContext.request.contextPath}/ajax/eqm/uographdata')
    .then(data=>data.json())
    .then((json)=>{
    	console.log(json.graphData);
    	
    	for(let initialData of json.graphData){
			let i = initialData.seconds;
    		data.series.push(new Object({"name":initialData.eqmCd,"data":[i,i,i,i,i,i,i,i,i,i,i,i,i,i,i]}));
    	}
    	
    })
    .then(()=>{
    	chart = toastui.Chart.areaChart({ el, data, options });
    })
    .then(()=>{
    	graphInterval = setInterval(()=>{
    		
    		fetch('${pageContext.request.contextPath}/ajax/eqm/uographdata')
    		    .then(data=>data.json())
    			.then((json)=>{
					console.log(json.graphData);
    				let arr = [];
					for(let intervalData of json.graphData){
						arr.push(intervalData.seconds);
					}
    				
    				chart.addData(arr,new Date(+new Date() + 3240 * 10000).toISOString().substr(11,8));
    			})
	    }, 1000);
    });

</script>
</html>