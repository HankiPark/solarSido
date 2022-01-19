<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<title>Insert title here</title>
</head>
<body>
	<h1>불량률</h1>
	<div id="curve_chart" style="width: 900px; height: 500px"></div>
</body>
<script>
	import Chart from '@toast-ui/chart'
	const chart = Chart.columnChart({el, data, options});
	const data = {
			  categories: ['Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
			  series: [
			    {
			      name: 'Budget',
			      data: [5000, 3000, 5000, 7000, 6000, 4000, 1000]
			    },
			    {
			      name: 'Income',
			      data: [8000, 4000, 7000, 2000, 6000, 3000, 5000]
			    },
			    {
			      name: 'Expenses',
			      data: [4000, 4000, 6000, 3000, 4000, 5000, 7000]
			    },
			    {
			      name: 'Debt',
			      data: [3000, 4000, 3000, 1000, 2000, 4000, 3000]
			    }
			  ]
			}
</script>
</html>