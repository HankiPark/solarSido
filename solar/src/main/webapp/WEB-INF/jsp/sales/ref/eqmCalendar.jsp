<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 <div id='calendar2'></div>


<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar2');
    var calendar = new FullCalendar.Calendar(calendarEl, {
    	headerToolbar: {
    		left: 'prev,next today',
    		center: 'title',
    		right: ''
    		},
    		contentHeight: 'auto',
    		dayMaxEvents: 2,
    		locale: 'ko', // 한국어 설정
    		eventSources:[
    			{
	    				events: function(info, successCallback, failureCallback) {
	    					$.ajax({
			    				url : '${pageContext.request.contextPath}/ajax/orderCal',
			    				dataType: 'json',
								contentType: 'application/json; charset=utf-8'

	    					}).done((data)=>{
	    						successCallback(data.events);
							})
    				},
    				color : 'yellow',
    				textColor: 'black' 
    			},
    			{
	    				events: function(info, successCallback, failureCallback) {
	    					$.ajax({
			    				url : '${pageContext.request.contextPath}/ajax/inPrdtCal',
			    				dataType: 'json',
								contentType: 'application/json; charset=utf-8'

	    					}).done((data)=>{
	    						successCallback(data.events);
							})
    				},
    				color : 'transparent',
    				textColor: 'black' 
    			},
    			{
	    				events: function(info, successCallback, failureCallback) {
	    					$.ajax({
			    				url : '${pageContext.request.contextPath}/ajax/outPrdtCal',
			    				dataType: 'json',
								contentType: 'application/json; charset=utf-8'

	    					}).done((data)=>{
	    						successCallback(data.events);
							})
    				},
    				color : 'transparent',
    				textColor: 'black' 
    			}
    		]
    });
    calendar.render();
  });


</script>
</body>
</html>