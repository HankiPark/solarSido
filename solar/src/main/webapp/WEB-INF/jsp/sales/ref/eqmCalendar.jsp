<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="row" id="sensePrdtIn">
			<div
				class="card card-pricing card-primary card-white card-outline col-11" id="sensePrdtInBody"
				style="margin-left: 40px; margin-right: 20px; margin-top: 10px; padding-left: 30px">
				<div class="card-body" style="margin-top:-20px">
 <div id='calendar2'></div>
</div></div></div>
<div id="dialog-order" title="설비 비가동 내역"></div>
<script type="text/javascript">
let dialog = $("#dialog-order").dialog({
	autoOpen : false,
	modal : true,
	width : 400,
	height : 400
});
document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar2');
    var calendar = new FullCalendar.Calendar(calendarEl, {
    	headerToolbar: {
    		left: 'prev,next today',
    		center: 'title',
    		right: ''
    		},
    		contentHeight: 700,
    		dayMaxEvents: 2,
    		locale: 'ko', // 한국어 설정
    		eventSources:[
    			
    			{
	    				events: function(info, successCallback, failureCallback) {
	    					$.ajax({
			    				url : '${pageContext.request.contextPath}/ajax/eqmCal',
			    				dataType: 'json',
								contentType: 'application/json; charset=utf-8'

	    					}).done((data)=>{
	    						successCallback(data.events);
							})
    				},
    				color : '#FD9E77',
    				textColor: 'white', 
    			},
    			
    		],
    		eventClick:function(ev){
    			
    			ev.jsEvent.preventDefault();
    			$("span[title$='Close']").trigger("click");
    			
    			 if(ev.event.url =='inspa'){
    				 console.log(ev.event.title.length)
    				 if(ev.event.title.length>12){
    					 console.log(ev.event.title.substring(11,16));
    					ev.event.title.substring(11,16);	 
    					 dialog.dialog("open");
    						$("#dialog-order")
    								.load(
    										"${pageContext.request.contextPath}/modal/calendarModal",
    										function() {
    											eqm(ev.event.extendedProps.etc,ev.event.extendedProps.etc2,ev.event.start,ev.event.title.substring(11,16));
    										})
    				 }else{
    					 dialog.dialog("open");
    						$("#dialog-order")
    								.load(
    										"${pageContext.request.contextPath}/modal/calendarModal",
    										function() {
    											eqm(ev.event.extendedProps.etc,ev.event.extendedProps.etc2,ev.event.start,ev.event.end);
    										})
    				 }
    				
    			} 				
			}
    });
    calendar.render();
    setTimeout(() => {
    	$(".fc-view-harness").css("marginTop","-40px");
    	$(".fc-daygrid-day-frame").css("height","50px");
        $(".fc-daygrid-event").css("margin","3px ");
        $(".fc-daygrid-event").css("height","18px ");
       // $(".fc-daygrid-event").css("padding","-2px");
	}, 1000);

    $(document).on("click",".fc-next-button",function(){
    	$(".fc-view-harness").css("marginTop","-40px");
    	    	$(".fc-daygrid-day-frame").css("height","50px");
    	        $(".fc-daygrid-event").css("margin","3px ");
    	        $(".fc-daygrid-event").css("height","18px ");
    	    //    $(".fc-daygrid-event").css("padding","2px");
    
    })
    $(document).on("click",".fc-prev-button",function(){
    	$(".fc-view-harness").css("marginTop","-40px");
    	    	$(".fc-daygrid-day-frame").css("height","50px");
    	        $(".fc-daygrid-event").css("margin","3px ");
    	        $(".fc-daygrid-event").css("height","18px ");
    	     //   $(".fc-daygrid-event").css("padding","2px");
    	
    })
    setTimeout(() => {
    $('th').css('border-bottom',' 1px solid #ddd')
    }, 1000);
  });

</script>
</body>
</html>