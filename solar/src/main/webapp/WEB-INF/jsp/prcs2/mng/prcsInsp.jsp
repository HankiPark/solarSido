<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>제품 불량 조회</h1>
	<div class="row">
		<div id="senseOrderBody"
			class="card card-pricing card-primary card-white card-outline col-3"
			style="margin-left: 50px; margin-right: 30px; margin-top: 20px; padding-left: 30px; margin-bottom: 20px;">
			<div class="card-body">
				<div data-role="fieldcontain"
					style="margin-bottom: 20px; margin-top: 50px;">
					<label for="defandroid">작업일자&nbsp;</label> <input name="startT"
						class="dtp" id="startT" type="text" data-role="datebox"
						data-options='{"mode": "calbox"}'>
				</div>
				<div data-role="fieldcontain" style="margin-bottom: 20px;">
					<label>지시번호&nbsp;</label> <input type="text"
						id="indicaNo">
					<button type="button" id="indicaBtn" style="width: 33px">
						🔍</button>
				</div>

				<div data-role="fieldcontain" style="margin-bottom: 20px;">

					<label>진행상태&nbsp;</label> <select name="nowSt">
						<option value="설비">설비불량</option>
						<option value="자재">자재불량</option>
						<option value="모두">모두</option>
					</select>
				</div>
			</div>
			<div class="card-footer" style="margin-bottom: 30px;">
				<button type="button" id="findgrid" style="margin-left: 120px">조회</button>
			</div>
		</div>


		<div id="grid" class="col-8" style="margin-left: 50px;"></div>
	</div>
	
	<div id="ab" class="row">
		<canvas id="gra1" class="col-8" style="height:300px"></canvas>
		<canvas id="gra2" class="col-4" style="height:300px">불량 수량</canvas>
	</div>
		<div id="senseOrderBody2"
			class="card card-pricing card-primary card-white card-outline"
			style="margin-left: 50px; margin-right: 30px; margin-top: 20px; padding-left: 40px; margin-bottom: 20px; display: none">
			<div class="card-body">
	<div id="b"></div>

	</div>
	</div>
	<div id="dialog-form" title="지시번호 검색"></div>
	<script type="text/javascript">
	var chk;
	var myChart2;
	const grid = new tui.Grid({
		el : document.getElementById('grid'), // 컨테이너 엘리먼트
		data : {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/grid/prdtInferList',
					method : 'GET',
					
				}
			},
			initialRequest : false,
			contentType : 'application/json'
		},
		bodyHeight : 300,
		minBodyHeight :300,
		pageOptions : {
			useClient : true,
			perPage : 7
		},
		columns : [ {
			header : '제품LOT',
			name : 'prdtLot',
			width : 150,
			align : 'center'
		}, {
			header : '불량코드',
			name : 'prdtInferCd',
			width : 70,
			align : 'center'
		}, {
			header : '불량명',
			name : 'prdtInferNm',
			width : 100,
			align : 'center'
		}, {
			header : '불량내역',
			name : 'prdtInferDesct',
			align : 'center'
		}, {
			header : '설비코드',
			name : 'eqmCd',
			width : 70,
			align : 'center'
		}, {
			header : '설비명',
			name : 'eqmNm',
			width : 130,
			align : 'center'
		}, {
			header : '불량일자',
			name : 'inferDt',
			width : 180,
			align : 'center'
		},

		],

	});
	grid.on('onGridUpdated', function() {
		$('td[data-column-name$="deNum"]').css('backgroundColor','#ffeeee');
		grid.refreshLayout();

	});
	
	
	
	
	
	
	$("#findgrid").on("click",function(){
		
		var startT = $("#startT").val().substring(0,10);
		var endT = $("#startT").val().substring(13,23);
		var indicaNo = $("#indicaNo").val();
		var nowSt = $("[name=nowSt] option:selected").val();
		
		var readParams ={
				'startT':startT,
				'endT':endT,
				'indicaNo':indicaNo,
				'nowSt':nowSt
		}
		grid.readData(1,readParams,true);
		
		if(nowSt=='설비'){
			$("#gra1").css("display","block");
			$("#gra2").css("display","block");
			$("#senseOrderBody2").css("display","none");
			chk='설비';
		let labels = [];
			  let data = {
		
			  };
			  $.ajax({
				  url:'${pageContext.request.contextPath}/ajax/inspaEqmChart',
					contentType: 'application/json; charset=utf-8',
					dataType: 'json',
					async: false,
				}).done(function(res){
					var dataset={};
					var dd=[];
					var dat = [];
					var color=[];
					$.each(res.data,function(a,b){
						dataset.label='불량수';
						labels.push(b.eqmNm);
						dat.push(Number(b.cnt));
						color.push('rgb('+(Math.floor(Math.random() * 250) + 1)+','+(Math.floor(Math.random() * 250) + 1)+','+(Math.floor(Math.random() * 250) + 1)+')');
					})
					dataset.backgroundColor = color;
					dataset.data=dat;
					let kk= JSON.parse(JSON.stringify(dataset));
					dd.push(kk);
					data.labels=labels;
					data.datasets=dd;
					console.log(data);
			 		  const config = {
			 				    type: 'bar',
			 				    data: data,
			 				    options: {plugins:{legend:{display:false}, title:{display:true, text:'설비별 불량제품 수'}},responsive:false,
			 				    	onClick: function(c,i) {
			 				    	    chart2(c.chart.data.labels[i[0].index]);
			 				    	}
			 				    }
			 				  };
	 				  const myChart = new Chart(
	 						    document.getElementById('gra1'),
	 						    config
	 						  );
				})	 
		} else if(nowSt=='자재'){
			$("#gra1").css("display","none");
			$("#gra2").css("display","none");
			chk='자재';
			
		} else{
			$("#gra1").css("display","none");
			$("#gra2").css("display","none");
			$("#senseOrderBody2").css("display","none");
			chk='모두';
		}
		})
function chart2(e){
		if(myChart2 instanceof Chart){
		myChart2.destroy();
		}
		let labels = [];
		let data = {};
					  let k = e.substr(0,6);
					  $.ajax({
						  url:'${pageContext.request.contextPath}/ajax/EqmKindChart',
							contentType: 'application/json; charset=utf-8',
							dataType: 'json',
							data : {
								'eqmCd': k
							}
						}).done(function(res){
							
							var dataset={};
							var dd=[];
							var dat = [];
							var color=[];
							$.each(res.data,function(a,b){
								dataset.label='불량수';
								labels.push(b.prdtInferCd);
								dat.push(Number(b.cnt));
								color.push('rgb('+(Math.floor(Math.random() * 250) + 1)+','+(Math.floor(Math.random() * 250) + 1)+','+(Math.floor(Math.random() * 250) + 1)+')');
							})
							dataset.backgroundColor = color;
							dataset.data=dat;
							let kk= JSON.parse(JSON.stringify(dataset));
							dd.push(kk);
							data.labels=labels;
							data.datasets=dd;
							console.log(data);
					 		  const config2 = {
					 				    type: 'doughnut',
					 				    data: data,
					 				    options: {plugins:{legend:{position: 'right'}, title:{display:true, text:'불량 종류'}},
					 				    	responsive:false,
					 				    	onClick: function(c,i) {
					 				    	    chart2(c.chart.data.labels[i[0].index]);
					 				    	}
					 				    }
					 				  };
			 				   myChart2 = new Chart(
			 						    document.getElementById('gra2'),
			 						    config2
			 						  );
						})	 
	}
	
	
	
	grid.on("dblclick",function(ev){
		if(chk=='자재' && ev["rowKey"]!=null){
			$.ajax({
				url:'${pageContext.request.contextPath}/ajax/findInspaPrdt',
				dataType: 'json',
				data : {
					'prdtLot' :  grid.getValue(ev["rowKey"],'prdtLot')
				},
				async: false,
				contentType: 'application/json; charset=utf-8',
			}).done((res)=>{
				console.log(res.data);
				console.log(res.data[0].rscCd);
				a=res.data[0].rscCd;
				b=res.data[0].rscLot;
				c=res.data[0].prdtLot;
				console.log(a);
				$("#senseOrderBody2").css("display","block");
				$("#b").html(`이 불량은 자재 코드 `+a+`중에서<br> 자재LOT `+b+`을 사용했으며 <br> 이에 사용된 제품들의 LOT은 `+c+` 입니다.`);
				
			})
		}
	})
	
	
	
	
	let dialog = $("#dialog-form").dialog({
		autoOpen : false,
		modal : true,
		width : 900,
		height : 570
	});
	
	$("#indicaBtn").on("click",function(){
		
		dialog.dialog("open");
		$("#dialog-form")
				.load(
						"${pageContext.request.contextPath}/modal/indicaEndList",
						function() {
							endList();
						})

		
		
		
		
	});
	
	
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
		  },
		  
		  );
		});
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	</script>
</body>
</html>