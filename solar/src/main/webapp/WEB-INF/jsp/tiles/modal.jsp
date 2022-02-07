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

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
   <link rel="stylesheet"
	href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<script
	src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css"/>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<link rel="stylesheet"
	href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />

</head>
<body>
<div>
<tiles:insertAttribute name="body"></tiles:insertAttribute>
</div>


<script type="text/javascript">
$(function(){

	$("div:contains('dialog-') button:contains('🔍')").html("<i class='fas fa-search-plus'> </i>&nbsp;");
	$("div:contains('dialog-') button:contains('검색')").html("조회");
	$("div:contains('dialog-') button:contains('조회')").prepend("<i class='fas fa-search-plus'> </i>&nbsp;");
	 	$("div:contains('dialog-') button:contains('조회')").css("width","80");
		$("div:contains('dialog-') button:contains('조회')").css("height","33");
		$("div:contains('dialog-') button:contains('조회')").css("borderRadius",5);
		$("div:contains('dialog-') button:contains('조회')").css("padding","6 1 6 3"); 	
		$("div:contains('dialog-') button:contains('조회')").css("boxShadow","2px 2px 2px #74a3b0"); 	
	$("div:contains('dialog-') button:contains('저장')").prepend("<i class='far fa-save'> </i> &nbsp;");
	$("div:contains('dialog-') button:contains('저장')").css("height","33");
	$("div:contains('dialog-') button:contains('저장')").css("width","80");
	$("div:contains('dialog-') button:contains('저장')").css("borderRadius",5);
	$("div:contains('dialog-') button:contains('저장')").css("padding","6 1 6 3"); 
	$("div:contains('dialog-') button:contains('저장')").css("boxShadow","2px 2px 2px #74a3b0"); 
	$("div:contains('dialog-') button:contains('초기화')").prepend("<i class='far fa-sticky-note'> </i>&nbsp; ");
	$("div:contains('dialog-') button:contains('초기화')").css("height","33");
	$("div:contains('dialog-') button:contains('초기화')").css("width","80");	
	$("div:contains('dialog-') button:contains('초기화')").css("borderRadius",5);
	$("div:contains('dialog-') button:contains('초기화')").css("padding","6 1 6 3"); 
	$("div:contains('dialog-') button:contains('초기화')").css("boxShadow","2px 2px 2px #74a3b0"); 
	$("div:contains('dialog-') button:contains('선택완료')").html("<i class='fas fa-stamp'></i>&nbsp;완료");
	$("div:contains('dialog-') button:contains('완료')").css("height","40");
	$("div:contains('dialog-') button:contains('완료')").css("width","100");
	$("div:contains('dialog-') button:contains('완료')").css("fontSize",20);
	$("div:contains('dialog-') button:contains('완료')").css("boxShadow","2px 2px 2px #74a3b0");
	$("div:contains('dialog-') button:contains('완료')").css("borderRadius",5);
	$("div:contains('dialog-') button:contains('완료')").css("padding","6 1 6 3"); 
	
	}
)

</script>

</body>
</html>
