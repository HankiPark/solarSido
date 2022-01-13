<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div id="dialog-form" title="작업지시번호"></div>


	<div>
		<div class="row">
			<div class="col-5">
				지시번호 : <input type="text" id="indicaDetaNo"><button type="button" id="searchIndica">돋</button><br><br>
				제품코드 : <input type="text" id="prdtCd"><br><br>
				공정명  : <input type="text" id="prcsNm"><button type="button" id="searchPrcs">돋</button><br><br>
				설비코드 : <input type="text" id="eqmCd"><br><br>
				라인번호 : <input type="text" id="liNo"><br><br>
				<br>
				작업자 : <input type="text" id="empId"><button type="button" id="searchIndic">돋</button> 작업량 : <input type="text" id="wkQty"><br><br> 
				<input type="text" id="frTm"><button id="btnStart">시작</button><input type="text" id="toTm"><button id="btnStart">종료</button><br>
				<button id="btnAddPerf">실적등록</button>
			</div>
			
			
				
			<div class="col-6" id="grid"></div>
			
		</div>	
	</div>
</body>

<script>

	let indicaGrid
	let prcsGrid 	
	
	
	let dialog = $( "#dialog-form" ).dialog({
		autoOpen: false,
		modal:true,
		width:1000
		/* buttons : {
			"save":function(){alert("save")},
			"upd": function(){alert("upd")}
		} */	
	});
	
 	$("#searchIndica").on("click", function(){
		dialog.dialog("open");
		$("#dialog-form").load("${pageContext.request.contextPath}/modal/searchIndicaDetail", function(){})
	});  

		const columns = 
			[ 
				{
				header : '제품LOT',
				name : 'prdtLot',
			}, {
				header : '제품명',
				name : 'prdtNm'
			}, {
				header : '공정명',
				name : 'prcsNm',
				
			}, {
				header : '진행상태',
				name : 'lowSt'
			}
			];
		
		
 		const inDataSource = {
				   api : {
				      readData : {
				         url : '${pageContext.request.contextPath}/grid/orderList.do',
				         method : 'GET'
				      }
				   },

				   contentType : 'application/json'
				};

 
	
		prcsGrid = new tui.Grid({
			  el: document.getElementById('grid'),
			  data : inDataSource ,
			  columns
			});	
 
 		prcsGrid.on("response", function(){
			prcsGrid.refreshLayout();
 			
 		})
	</script>
	





</html>