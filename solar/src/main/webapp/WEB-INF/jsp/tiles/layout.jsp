<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>SolarSido</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />

 <link
	href="${pageContext.request.contextPath}/resources/dist/css/style.min.css"
	rel="stylesheet">
		<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
      <script src="${pageContext.request.contextPath}/resources/assets/extra-libs/taskboard/js/jquery.ui.touch-punch-improved.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/extra-libs/taskboard/js/jquery-ui.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/libs/popper.js/dist/umd/popper.min.js"></script>
    <link rel="stylesheet"
	href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
	<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css"/>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<script src="https://uicdn.toast.com/tui.time-picker/latest/tui-time-picker.js"></script>
	<script
		src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
<script type="text/javascript" src="https://uicdn.toast.com/tui.pagination/v3.4.0/tui-pagination.js"></script>
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css" />
	<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/chart/latest/toastui-chart.min.css" />
<script src="https://uicdn.toast.com/chart/latest/toastui-chart.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-resize/1.1/jquery.ba-resize.min.js" integrity="sha512-f39z0cdBuo6BZaPaU97tfdGSh0IJePwvm385z7hDHmmh357Huqbp0WyDnYuyWOysaIOSFCakaaoQlXJgSnM2dw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<style>


</style>
</head>
<body>

        <tiles:insertAttribute name="body"></tiles:insertAttribute>


<script type="text/javascript">
toastr.options.positionClass = "toast-top-center"; //토스트 메시지 중앙으로
var UID=null;
function receiveMsgFromParent( e ) {
    // e.data가 전달받은 메시지
    console.log('부모로 부터 받은 메시지 ', e.data );
    UID = e.data;
}
var sock  = null;
function connectWs(){
	
	sock = new SockJS(getContextPath()+'/ajax/myHandler');
	
   	sock.onopen = function() {

        
     console.log('open');

	 };

 	sock.onmessage = function(e) {
   	  console.log('message', e.data);
   	  toastr.success(e.data);
 //  	  sock.close();
	 };

 	sock.onclose = function() {
 	    console.log('close');
	 };
 
  };

	function getContextPath() {
	    var hostIndex = location.href.indexOf( location.host ) + location.host.length;
	    return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
	}; 
	function sendMsgToParent( msg,ct ) {
		
		$.ajax({
			url : "${pageContext.request.contextPath}/ajax/webinsert",
			dataType: 'json',
			contentType: 'application/json; charset=utf-8',
			data : {userId : UID,
					msTitle : msg,
					msContent : ct}
		}).done((ev)=>{
			console.log(ev);
			sock.send(UID+","+msg);
			window.parent.postMessage(ev.count, '*' );
		})
	    
	}
$(function(){
	window.addEventListener('message',receiveMsgFromParent);
 	connectWs();

	$("button:contains('🔍')").html("<i class='fas fa-search-plus'> </i>");
	$("button:contains('🔍')").css("width","28");
	$("button:contains('🔍')").css("height","28");
	$("button:contains('조회')").prepend("<i class='fas fa-search-plus'> </i>&nbsp;");
	 	$("button:contains('조회')").css("width","100");
		$("button:contains('조회')").css("height","40");
		$("button:contains('조회')").css("fontSize",20);
		$("button:contains('조회')").css("borderRadius",5);
		$("button:contains('조회')").css("padding","6 1 6 3"); 
		$("button:contains('조회')").css("boxShadow","2px 2px 2px #74a3b0"); 
	$("button:contains('삭제')").prepend("<i class='far fa-trash-alt'> </i>  &nbsp;");
	$("button:contains('삭제')").css("height","40");
	$("button:contains('삭제')").css("width","100");
	$("button:contains('삭제')").css("fontSize",20);
	$("button:contains('삭제')").css("borderRadius",5);
	$("button:contains('삭제')").css("padding","6 1 6 3"); 
	$("button:contains('삭제')").css("boxShadow","2px 2px 2px #74a3b0"); 
	
	$("button:contains('저장')").prepend("<i class='far fa-save'> </i> &nbsp;");
	$("button:contains('저장')").css("height","40");
	$("button:contains('저장')").css("width","100");
	$("button:contains('저장')").css("fontSize",20);
	$("button:contains('저장')").css("borderRadius",5);
	$("button:contains('저장')").css("boxShadow","2px 2px 2px #74a3b0");
	$("button:contains('저장')").css("padding","6 1 6 3"); 
	$("button:contains('추가')").prepend("<i class='far fa-plus-square'> </i> &nbsp;");
	$("button:contains('추가')").css("height","40");
	$("button:contains('추가')").css("width","100");
	$("button:contains('추가')").css("fontSize",20);
	$("button:contains('추가')").css("borderRadius",5);
	$("button:contains('추가')").css("boxShadow","2px 2px 2px #74a3b0");
	$("button:contains('추가')").css("padding","6 1 6 3");  
	$("button:contains('초기화')").prepend("<i class='far fa-sticky-note'> </i> &nbsp;");
	$("button:contains('초기화')").css("height","40");
	$("button:contains('초기화')").css("width","100");
	$("button:contains('초기화')").css("fontSize",20);
	$("button:contains('초기화')").css("borderRadius",5);
	$("button:contains('초기화')").css("boxShadow","2px 2px 2px #74a3b0");
	$("button:contains('초기화')").css("padding","6 1 6 3"); 
	$('th').css('border-bottom','5px solid #fc7a45');
	}
)



	







</script>

    <script src="${pageContext.request.contextPath}/resources/assets/libs/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- apps -->
    <script src="${pageContext.request.contextPath}/resources/dist/js/app-style-switcher.js"></script>
    <script src="${pageContext.request.contextPath}/resources/dist/js/feather.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/libs/perfect-scrollbar/dist/perfect-scrollbar.jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/dist/js/sidebarmenu.js"></script>
    <!--Custom JavaScript -->
    <script src="${pageContext.request.contextPath}/resources/dist/js/custom.min.js"></script>
    <!--This page JavaScript -->
    <script src="${pageContext.request.contextPath}/resources/assets/libs/moment/min/moment.min.js"></script>
<script
			src="${pageContext.request.contextPath}/resources/dist/js/iframe-custom.js"></script>
<script type="text/javascript" src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>

</body>
</html>
