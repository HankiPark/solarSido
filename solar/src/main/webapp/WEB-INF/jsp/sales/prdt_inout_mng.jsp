<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
*{margin:0; padding:0;}
ul{list-style:none;}
a{text-decoration:none; color:#333;}
.wrap{padding:15px; letter-spacing:-0.5px;}
.tab_menu .list{overflow:hidden;}
.tab_menu .list li{float:left; margin-right:14px;}
.tab_menu .list .btn{font-size:13px;}
.tab_menu .list li.is_on .btn{font-weight:bold; color:green;}
.tab_menu .list li.is_on .cont{display:block;}
#outGrid{display:none;}
</style>
</head>
<body>

<div class="wrap">
  <div class="tab_menu">
    <ul class="list">
      <li class="is_on">
        <a href="#" id="in" class="btn">입고</a>
      </li>
      <li>
        <a href="#" id="out" class="btn">출고</a>
       </li>
    </ul>
  </div>
</div>



        <div id="inGrid"></div>

        <div id="outGrid"></div>







<script>


const tabList = document.querySelectorAll('.tab_menu .list li');
for(var i = 0; i < tabList.length; i++){
  tabList[i].querySelector('.btn').addEventListener('click', function(e){
    e.preventDefault();
    for(var j = 0; j < tabList.length; j++){
      tabList[j].classList.remove('is_on');
    }
    this.parentNode.classList.add('is_on');
    if($(this)[0].id=="in"){
    	$("#outGrid").css("display","none");
    	$("#inGrid").css("display","block");
    }else{
    	$("#inGrid").css("display","none");
    	$("#outGrid").css("display","block");
    }
  });
}




/* var d = new Date();
var nd = new Date(d.getFullYear(), d.getMonth(), d.getDate() - 7);
document.getElementById('startT').value = nd.toISOString().slice(0, 10);
document.getElementById('endT').value = d.toISOString().slice(0, 10);

let dialog = $("#dialog-form").dialog({
	autoOpen : false,
	modal : true,
	width : 900,
	height : 700
}); */
const inDataSource = {
	api : {
		readData : {
			url : '${pageContext.request.contextPath}/grid/orderList.do',
			method : 'GET'
		}
	},

	contentType : 'application/json'
};

const inGrid = new tui.Grid({
	el : document.getElementById('inGrid'), // 컨테이너 엘리먼트
	data : inDataSource,
	bodyHeight : 700,
	columns : [ {
		header : '입고일자',
		name : 'prdtDt'
	}, {
		header : '제품LOT',
		name : 'prdtLot',
	}, {
		header : '제품코드',
		name : 'prdtCd'
	}, {
		header : '제품명',
		name : 'prdtNm',
	}, {
		header : '규격',
		name : 'prdtSpec'
	}

	],

});
inGrid.on('onGridUpdated', function() {
	inGrid.refreshLayout();
});
/* inGrid
		.on(
				'click',
				function(ev) {
					console.log(ev);
					console.log(ev["rowKey"]);
					console.log(grid.getValue(ev["rowKey"], "orderNo"));
					 if (ev["columnName"] == "deNum"
							&& grid.getValue(ev["rowKey"], "deNum") != 0) {
						dialog.dialog("open");
						$("#dialog-form")
								.load(
										"${pageContext.request.contextPath}/modal/orderDetailList",
										function() {
											newgrid(grid.getValue(
													ev["rowKey"],
													"orderNo"));
											inGrid.refreshLayout();
										})
					} 
				});
 */

/* $('#findgrid').on('click',function(){
	
	var startT = $("#startT").val();
	var endT = $("#endT").val();
	var dateTy = $("input[name=dateTy]:checked").val();
	var nowSt = $("[name=nowSt] option:selected").val();
	console.log(dateTy);
	
	var readParams ={
			'startT':startT,
			'endT':endT,
			'dateTy':dateTy,
			'nowSt':nowSt
	}
	
	grid.readData(1,readParams,true);
	grid.refreshLayout();
}) */







</script>

</body>
</html>