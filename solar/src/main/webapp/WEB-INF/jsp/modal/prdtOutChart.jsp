<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div>
 <canvas id="myChart"></canvas>

</div>
<script type="text/javascript">


		function prdtOutChart(){
			let labels = [
			
			  ];
			var d = new Date();
			var nd = new Date(d.getFullYear(), d.getMonth());
			for(i=11;i>=-1;i--){
				labels.push(new Date(d.getFullYear(), d.getMonth()-i).toISOString().slice(2, 7))
			}
			  let data = {
			    labels: labels,
			   /*  datasets: [{
			      label: 'My First dataset',
			      backgroundColor: 'rgb(255, 99, 132)',
			      borderColor: 'rgb(255, 99, 132)',
			      data: [0, 10, 5, 2, 20, 30, 45],
			    }] */
			  };
			  
			  $.ajax({
				  url:'${pageContext.request.contextPath}/ajax/prdtChart.do',
					contentType: 'application/json; charset=utf-8',
					dataType: 'json',
					async: false,
				}).done(function(res){
					var dataset={};
					var dd=[];
					$.each(res.data,function(a,b){
						dataset.label=b[0].prdtCd;
						let dat = [];
						for(let i=0;i<13;i++){
							dat.push(b[i].valid);
							console.log(b[i].valid)
						}
						dataset.borderColor = 'rgb('+(Math.floor(Math.random() * 250) + 1)+','+(Math.floor(Math.random() * 250) + 1)+','+(Math.floor(Math.random() * 250) + 1)+')';
						dataset.data=dat;
						let kk= JSON.parse(JSON.stringify(dataset));
						dd.push(kk);
						
						console.log(dd);
						
					})
					data.datasets=dd;
					
					
				})	 
				
				
	 		  const config = {
			    type: 'line',
			    data: data,
			    options: {}
			  };
			  const myChart = new Chart(
					    document.getElementById('myChart'),
					    config
					  );
		}
	</script>
</body>
</html>