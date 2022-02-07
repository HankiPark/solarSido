<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
* {
	margin: 0;
	padding: 0;
}

ul {
	list-style: none;
}

a {
	text-decoration: none;
	color: #333;
}

.wrap {
	padding: 15px;
	letter-spacing: -0.5px;
}

.tab_menu .list {
	overflow: hidden;
}

.tab_menu .list li {
	float: left;
	margin-right: 14px;
}

.tab_menu .list .btn {
	font-size: 13px;
}

.tab_menu .list li.is_on .btn {
	font-weight: bold;
	color: green;
}

.tab_menu .list li.is_on .cont {
	display: block;
}

#oG {
	display: none;
}
input#inref {
display : none;
}

input#outref {
display : none;
}

input#inref+label{
display: inline-block;
        width: 15px;
        height: 15px;
        border:3px solid #e37c6b;
        margin-bottom:0px;
               position: relative;
      
}
input#inref:checked + label::after{
        content:'✔';
        font-size: 12px;
        width: 12px;
        height: 12px;
position: absolute;
		top:-3.5px;
		left:0;
        background-color: #e37c6b;
        color:#fff;
         margin-bottom:0px;
      }
input#outref+label{
display: inline-block;
        width: 15px;
        height: 15px;
        border:3px solid #e37c6b;
        margin-bottom:0px;
               position: relative;
      
}
input#outref:checked + label::after{
        content:'✔';
        font-size: 12px;
        width: 12px;
        height: 12px;
position: absolute;
		top:-3px;
		left:0px;
        background-color: #e37c6b;
        color:#fff;
         margin-bottom:0px;
      }


</style>
</head>
<body>
	<h1>제품 입/출고조회</h1>
	<div class="row" id="sensePrdtRef">
	<div
				class="card card-pricing card-primary card-white card-outline col-3" id="sensePrdtRefBody"
				style="margin-left: 50px; margin-right: 30px; margin-top: 150px; padding-left: 40px; margin-bottom: 300px;">
		<div class="card-body" >
			<div >

				<div data-role="fieldcontain" style="margin-bottom: 20px; margin-top: 50px;" >
					<label for="defandroid">일자선택&nbsp;</label> <input name="startT"
						class="dtp" id="startT" type="text" data-role="datebox"
						data-options='{"mode": "calbox"}'>
				</div>
			</div>
			<div>
				<div data-role="fieldcontain" style="margin-bottom: 20px;">
					<label>제품구분&nbsp;&nbsp;&nbsp;</label> <label><input type="checkbox" name="ref" id="inref"
						value="I"><label for="inref"></label>입고</label> <label><input type="checkbox" id="outref"
						name="ref" value="O"><label for="outref"></label>출고</label>
				</div>
				
				<div data-role="fieldcontain" style="margin-bottom: 20px;">
					<label>제품명&nbsp;&nbsp;&nbsp;&nbsp;</label> <input type="text" id="prdNm"><button type="button" id="prdtNmBtn" style="width:33px" > 🔍 </button>
				</div>
				<div id="coo" data-role="fieldcontain" style="display: none">
					<div data-role="fieldcontain" style="margin-bottom: 20px;">
				<button type="button" id="static" style="width:300px;height:40px;font-size:20px;borderRadius:20px;padding:6px 1px 6px 3px"><i class="fas fa-chart-line"></i>&nbsp;제품월별통계</button>
				</div>
					<label>회사명&nbsp;&nbsp;&nbsp;&nbsp;</label> <input type="text" id="coNm"><button type="button" id="coNmBtn" style="width:33px"> 🔍 </button> 
					
		</div>
	</div>
	

		</div>
		<div class="card-footer" style="margin-bottom: 30px;">
		<button type="button" id="findgrid" style="margin-left:120px">조회</button>
		</div>
		</div>
			<div class="col-8">
	<div id="Grid" style="margin-top:100px"></div>
</div>

</div>


	<div id="dialog-form" title="제품명단"></div>
	<div id="dialog-co" title="업체명단"></div>
	<div id="dialog-out" title="월별 출고"></div>

	<script type="text/javascript">

/* 	
	var d = new Date();
	var nd = new Date(d.getFullYear(), d.getMonth(), d.getDate() - 7);
	document.getElementById('startT').value = nd.toISOString().slice(0, 10);
	document.getElementById('endT').value = d.toISOString().slice(0, 10); */
	var save;
	var a;
	$(function() {
		
		  $('input[name="startT"]').daterangepicker({
			  showDropdowns: true,
		    opens: 'right',
		    startDate: moment().startOf('hour').add(-7, 'day'),
			  endDate: moment().startOf('hour'),
			  minYear: 1990,
			    maxYear: 2025,
			  autoApply: true,
			    locale: {
			      format: 'YYYY-MM-DD',
			    	  separator: " ~ ",
			          applyLabel: "적용",
			          cancelLabel: "닫기",
			          prevText: '이전 달',
			          nextText: '다음 달',
			          monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			          daysOfWeek: ['일', '월', '화', '수', '목', '금', '토'],
			          showMonthAfterYear: true,
			          yearSuffix: '년'
			    }
		  }, function(start, end, label) {
		    console.log("A new date selection was made: " + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD'));
		  },
		  
		  );
		});
	
	let dialog = $("#dialog-form").dialog({
		autoOpen : false,
		modal : true,
		width : 700,
		height : 700
	});
	let dialog2 = $("#dialog-out").dialog({
		autoOpen : false,
		modal : true,
		width : 700,
		height : 700
	});
	let dialog3 = $("#dialog-co").dialog({
		autoOpen : false,
		modal : true,
		width : 700,
		height : 700
	});
	
	//제품이름검색시
	$('#prdtNmBtn')
	.on(
			'click',
			function() {
				dialog.dialog("open");
				$("#dialog-form")
						.load(
								"${pageContext.request.contextPath}/modal/prdtNmList",
								function() {
									NmList()
								})
			});
	$('#coNmBtn')
	.on(
			'click',
			function() {
				dialog3.dialog("open");
				$("#dialog-co")
						.load(
								"${pageContext.request.contextPath}/modal/coNmList",
								function() {
									CoList()
								})
			});
	
	const Grid = new tui.Grid(
			{
				el : document.getElementById('Grid'), // 컨테이너 엘리먼트
				data : {
					api : {
						readData : {
							url : '${pageContext.request.contextPath}/grid/prdtSearch.do',
							method : 'GET'
						}
					},
					initialRequest : false,
					contentType : 'application/json'
				},

				minBodyHeight : 500,
				
				pageOptions : {
					useClient : true,
					perPage : 15
				},
				rowHeaders : [ {
					type : 'rowNum',
					width : 100,
					align : 'left',
					valign : 'bottom'
				}],
				columns : [ {
					header : 'index',
					name : 'prdtInx',
					hidden : true
				},
				{
					header : '입출고구분',
					name : 'prdtFg'

				}, {
					header : '생산지시번호/출고전표번호',
					name : 'indicaNo'
				}, {
					header : '제품LOT',
					name : 'prdtLot'
				}, {
					header : '입출고일자',
					name : 'prdtDt'
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

	$(document).on('click','.tui-page-btn',function(e){
		$('td').css('backgroundColor','');
		$('td').css('color','');
		$('td').css('fontSize','');

		setTimeout(function(){
			for(let i=save;i<=a;i++){
				$('td[data-row-key$="'+i+'"]').css('backgroundColor','#fff');
				$('td[data-row-key$="'+i+'"]').css('color','#e37c6b');
				$('td[data-row-key$="'+i+'"]').css('fontSize',15);
			}
			$('td[data-column-name$="prdtFg"]').find('div:contains("I")').html("입고");
			$('td[data-column-name$="prdtFg"]').find('div:contains("O")').html("출고");
		},300);
	})
	
	$('#findgrid').on('click', function() {
		
		if($("input:checkbox[name=ref]").is(":checked")==false){
			toastr.warning("입/출고를 선택해주세요")
		}else{
		var startT = $("#startT").val().substring(0,10);
		var endT = $("#startT").val().substring(13,23);
		var prdNm = $("#prdNm").val();
		if($("input:checkbox[name=ref]:checked").length==2){
			console.log(startT);
			console.log(endT);
			var chk = null;
			var co =  $("#coNm").val();
		}else if($('input:checkbox[name=ref]:checked').val()=='O'){
			var chk = $('input:checkbox[name=ref]:checked').val();
			var co =  $("#coNm").val();
		}else{
			var chk = $('input:checkbox[name=ref]:checked').val();
			var co =  null;
		}
		
		var params = {
				'startT' : startT,
				'endT' : endT,
				'prdSt' : chk,
				'prdNm' : prdNm,
				'coNm' : co
				
			}
		$('td').css('backgroundColor','');
		$('td').css('color','');
		$('td').css('fontSize',);
			/* inGrid.enable(); */
			Grid.readData(1,params,true);
		
			
		}})
		
		Grid.on('onGridUpdated', function() {
		$('td').css('backgroundColor','');
		$('td').css('color','');
		$('td').css('fontSize','');
		Grid.refreshLayout();
		 a = Grid.getRowCount();
		save =Grid.getRowCount();
		var day = Grid.getValue(0,'prdtDt');
		var cnt=1;
		var up=1;
		for(let i = 0 ; i<a;i++){
			if(Grid.getValue(i+1,'prdtDt')==day){
				cnt++;
			}else if(Grid.getValue(i+1,'prdtDt')!=day){
				
				Grid.appendRow({'prdtCd':day, 'prdtNm':'소계','prdtSpec':cnt}, {
					
					at : i+up
				});
				a++;up++;
				day=Grid.getValue(i+1,'prdtDt');
				cnt=1;
				
			}

			
		}
		setTimeout(function(){
			for(let i=save;i<=a;i++){
				$('td[data-row-key$="'+i+'"]').css('backgroundColor','#fff');
				$('td[data-row-key$="'+i+'"]').css('color','#e37c6b');
				$('td[data-row-key$="'+i+'"]').css('fontSize',15);
			}
			$('td[data-column-name$="prdtFg"]').find('div:contains("I")').html("입고");
			$('td[data-column-name$="prdtFg"]').find('div:contains("O")').html("출고");
		},300);
		
	});
		
		
		
		
		$("#outref").change(function(ev){
			$("#coo").toggle();
		})
		
		
		$('#static')
	.on(
			'click',
			function() {
				dialog2.dialog("open");
				$("#dialog-out")
						.load(
								"${pageContext.request.contextPath}/modal/prdtOutChart",
								function() {
									prdtOutChart()
								})
			});
		
		$('#sensePrdtRef').resize(function(){
			if($('#sensePrdtRef').width()<1780){
				$('#sensePrdtRefBody').css('paddingLeft','15px');
			}else{
				$('#sensePrdtRefBody').css('paddingLeft','40px');
			}
		})
	</script>
</body>
</html>