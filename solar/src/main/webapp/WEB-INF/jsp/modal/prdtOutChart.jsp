<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div
 <canvas id="myChart"></canvas>

</div>
<script type="text/javascript">


		function prdtOutChart(){
			let labels = [
			
			  ];
			var d = new Date();
			var nd = new Date(d.getFullYear(), d.getMonth());
			for(i=12;i>0;i--){
				labels.push(new Date(d.getFullYear(), d.getMonth()-i).toISOString().slice(0, 7))
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
				//for문 제품명 다 나올때까지 label에 들어감 data에 날짜가 있다면 count 넣고 아니면 0주입 datasets추가할것
				
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