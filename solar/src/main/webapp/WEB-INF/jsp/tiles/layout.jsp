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
    <link href="${pageContext.request.contextPath}/resources/assets/libs/fullcalendar/dist/fullcalendar.min.css" rel="stylesheet" />
 <link
	href="${pageContext.request.contextPath}/resources/dist/css/style.min.css"
	rel="stylesheet">
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

<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css" />
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/chart/latest/toastui-chart.min.css" />
<script src="https://uicdn.toast.com/chart/latest/toastui-chart.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>


</style>
</head>
<body>

        <tiles:insertAttribute name="body"></tiles:insertAttribute>


<script type="text/javascript">
$(function(){
	

	$("button:contains('조회')").html("🔍 조회");
	 	$("button:contains('조회')").css("width","66");
		$("button:contains('조회')").css("height","30");
		$("button:contains('조회')").css("width","80");
		$("button:contains('조회')").css("fontSize",16);
		$("button:contains('조회')").css("padding","6 1 6 3"); 
	$("button:contains('삭제')").prepend("<i class='far fa-trash-alt'> </i>  ");
	$("button:contains('삭제')").css("height","30");
	$("button:contains('삭제')").css("width","80");
	$("button:contains('삭제')").css("fontSize",16);
	$("button:contains('삭제')").css("padding","6 1 6 3"); 
	
	$("button:contains('저장')").prepend("<i class='far fa-save'> </i> ");
	$("button:contains('저장')").css("height","30");
	$("button:contains('저장')").css("width","80");
	$("button:contains('저장')").css("fontSize",16);
	$("button:contains('저장')").css("padding","6 1 6 3"); 
	$("button:contains('추가')").prepend("<i class='far fa-plus-square'> </i> ");
	$("button:contains('추가')").css("height","30");
	$("button:contains('추가')").css("width","80");
	$("button:contains('추가')").css("fontSize",16);
	$("button:contains('추가')").css("padding","6 1 6 3"); 
	
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
    <script src="${pageContext.request.contextPath}/resources/assets/libs/fullcalendar/dist/fullcalendar.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/dist/js/pages/calendar/cal-init.js"></script>
<script
			src="${pageContext.request.contextPath}/resources/dist/js/iframe-custom.js"></script>
<script type="text/javascript" src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
</body>
</html>
