<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
</head>


<body>
	<h1>자재 검수 조회</h1>
	<div id="coModal" title="업체 목록"></div>
	<div id="rscModal" title="자재 목록"></div>
	<div id="inspModal" title="검수"></div>
	<div class="row" id="senseInsp">
		<div  id="senseInspBody"  class="card card-pricing card-primary card-white card-outline col-3" style="margin-left: 50px;margin-right: 30px;margin-top: 150px;padding-left: 40px;margin-bottom: 300px; height:350px">
			<div class="card-body" >
				<form id="ordrQueryFrm" name="ordrQueryFrm">
				<div  style="margin-bottom: 20px; margin-top: 50px;">
					<label>발주일&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<input type="text" id="datePicker" name="datePicker" class="dtp">
				</div>
				<div style="margin-bottom: 20px;">
					<label>	발주업체</label>
					<input type="text" id="co" name="co">
					<button type="button" id="coSearchBtn">🔍</button>
				</div>
				<div style="margin-bottom: 20px;">
					<label>	자재코드</label>
					<input type="text" id="rsc" name="rsc">
					<button type="button" id="rscSearchBtn">🔍</button>
				</div>
				</form>
				<div class="card-footer" style="margin-bottom: 30px;">
					<button type="button" id="ordrQueryBtn" style="margin-left:120px">조회</button>
				</div>
			</div>
			<div class="card card-pricing card-primary card-white card-outline">
				<div class="card-body" >
					<div style="margin-bottom: 20px;">
						<label>연도&emsp;&emsp;&nbsp;</label>
	    				<select id="year" value="${curYear }"></select>
	    			</div>
	    			<div style="margin-bottom: 20px;">
	 					<label> 발주업체:</label>
	 					<input type="text" id="coCds" name="co">
	 					<button type="button" id="coSearchBtn2">🔍</button>
 					</div>
 					<div class="card-footer" style="margin-bottom: 30px;" align="center">
		    			<button id="sendRequest" onclick="inferRequest()" style="margin-left:-10px">조회</button>
 					</div>
	    		</div>
	    	</div>
		</div>
		<div class="col-8">
			<div id="grid" style="margin-top:70px;"></div>
			<div>
		    	<hr><h3>자재 불량률</h3><hr>
		    	<div id="coModal2" title="업체 목록"></div>
		    	<div class="flex row">&ensp;
		    		<div id="barChartDiv" class="row-1"></div>
			    	<div id="pieChartDiv" class="row-1"></div>
		    	</div>
   			</div>
		</div>
	</div>
</body>

<script>
	let cmmnCodes;
	let curRowKey;
	let sum;
	let date = new Date(+new Date() + 3240 * 10000);
	let ordrDtEnd = date.toISOString().substr(0,10);
	date.setDate(date.getDate()-7);
	let ordrDtStt = date.toISOString().substr(0,10);
	let co;
	let rsc;
	let inspCls;
    let rtngdResnCd;
	let ordrDataSource = {
		api: {
				readData: { url: '${pageContext.request.contextPath}/grid/rsc/ordrData', method: 'GET'},
				modifyData: {url: '${pageContext.request.contextPath}/grid/rsc/ordrData',method: 'PUT'}
			},
			contentType : 'application/json',
			initialRequest: false,
	};
	
	$(function() {
		   
	     $('input[name="datePicker"]').daterangepicker({
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
	       ordrDtStt = start.format('YYYY-MM-DD');
	       ordrDtEnd = end.format('YYYY-MM-DD');
	     },
	     
	     );
	   });

//공통코드 가져옴
	$.ajax({
	 url: '${pageContext.request.contextPath}/ajax/cmmn/codes',
	 dataType: 'JSON',
	 async: false,
	}).done(function(data){
	 cmmnCodes = data;
	});
	
	var Grid = tui.Grid;
	Grid.setLanguage('ko');
  var grid = new Grid({
    el: document.getElementById('grid'),
    scrollX: false,
    scrollY: false,
    data: ordrDataSource,
    rowHeaders: ['checkbox'],
	bodyHeight : 300,
    sortable: true,
    columns: [{
        header: '발주일',
        name: 'ordrDt',
        sortable: true,
      },
      {
        header: '자재명',
        name: 'rscNm',
        width: 220,
        sortable: true,
      },
      {
        header: '자재코드',
        name: 'rscCd',
        sortable: true,
      },
      {
        header: '발주량',
        name: 'ordrQty',
        sortable: true,
      },
      {
        header: '받은 수량',
        name: 'rscIstQty',
        sortable: true,
      },
      {
        header: '불량량',
        name: 'rscInferQty',
        sortable: true,
      },
      {
        header: '발주번호',
        name: 'ordrCd',
        sortable: true,
      },
      {
        header: '업체',
        name: 'coNm',
        sortable: true,
      },
      {
        header: '검수여부',
        name: 'inspCls',
        formatter: 'listItemText',
        sortable: true,
        editor: {
            type: 'select',
            options: {
              listItems:cmmnCodes.codes.rscst
            }
        }
      },
		{
			name: 'rtngdResnCd'
		},
		{
			name: 'rtngdDt'
		},
    ]
  });
  	grid.disableColumn('inspCls');
	grid.hideColumn('rtngdResnCd');
	grid.hideColumn('rtngdDt');
	
	function gridCss(){
		  let dsabTexts = document.querySelectorAll('.tui-grid-cell-disabled');
		  for(let dtx of dsabTexts){
			  dtx.style.backgroundColor = '#f4f4f4';
			  dtx.classList.remove('tui-grid-cell-disabled');
		  }
	  }
	grid.on('onGridUpdated',function(){
		gridCss();
	});
	grid.on('response',function(ev){
      if(ev.xhr.responseText =="201"){
    	  grid.readData();
      }
      grid.refreshLayout();
    });
	grid.on('onGridMounted',function(){
		grid.readData(1,{
			'ordrDtStt':ordrDtStt,
			'ordrDtEnd':ordrDtEnd,
			'co':co,
			'rsc':rsc,
			'inspCls':'rs002',
			'whereParam':'insp',
		});
	});

//

  let ordrQueryBtn = document.getElementById("ordrQueryBtn");
  ordrQueryBtn.addEventListener("click", function () {
    co = document.ordrQueryFrm.co.value;
    rsc = document.ordrQueryFrm.rsc.value;
	grid.readData(1,{
		'ordrDtStt':ordrDtStt,
		'ordrDtEnd':ordrDtEnd,
		'co':co,
		'rsc':rsc,
		'inspCls':'rs002',
		'whereParam':'insp',
	});
  });

//

  let coDialog = $("#coModal").dialog({
    modal: true,
    autoOpen: false,
	width : 600,
	height : 600
  });

  $("#coSearchBtn").on("click", function () {
    coDialog.dialog("open");
    $("#coModal").load("${pageContext.request.contextPath}/modal/co");
  });

//

  let rscDialog = $("#rscModal").dialog({
    modal: true,
    autoOpen: false,
	width : 600,
	height : 600
  });

  $("#rscSearchBtn").on("click", function () {
    rscDialog.dialog("open");
    $("#rscModal").load("${pageContext.request.contextPath}/modal/rsc");
  });
	$('#senseInsp').resize(function(){
		if($('#senseInsp').width()<1780){
			$('#senseInspBody').css('paddingLeft','15px');
		}else{
			$('#senseInspBody').css('paddingLeft','40px');
		}
	})
</script>


<script>
    let categories = [];
    let series = [];
    let inferData = [];

    inferRequest();
    
    let curYear = new Date(+new Date() + 3240 * 10000).toISOString().substr(0,4);
    let year = document.getElementById('year');
    for(let i = curYear; i>=1990; i--){
	    let opt = document.createElement('option');
	    opt.innerText = i;
	    year.appendChild(opt);
    }

    function inferRequest() {

        categories = [];
        series = [{
                name: '1분기',
                data: []
            },
            {
                name: '2분기',
                data: []
            },
            {
                name: '3분기',
                data: []
            },
            {
                name: '4분기',
                data: []
            }
        ];

        let year = document.getElementById('year').value;
        let coCds = document.getElementById('coCds').value;

        fetch('${pageContext.request.contextPath}/ajax/rsc/inferGraphData', {
                method: 'POST',
                body: JSON.stringify({
                    coCds: coCds,
                    year: year
                }),
                headers: {
                    'Content-Type': 'application/json'
                }
            }).then(data => data.json())
            .then((result) => {
                inferData = result.inferRates;

                for (let i of result.inferRates) {
                    categories.push(i.coNm);
                    series[0].data.push(i.inferRateFirst);
                    series[1].data.push(i.inferRateSecond);
                    series[2].data.push(i.inferRateThird);
                    series[3].data.push(i.inferRateFourth);
                }

                const el = document.getElementById('barChartDiv');
                const data = {
                    categories,
                    series
                };
                const options = {
                    chart: {
                        title: '분기별 자재 불량률',
                        width: 1100,
                        height: 400,
                    },
                    series: {
                        selectable: true
                    }
                };

                $('#barChartDiv').empty();
                const chart = toastui.Chart.barChart({
                    el,
                    data,
                    options
                });

                chart.on('selectSeries', (ev) => {
                	console.log(ev);
                    temp(ev.bar[0].data);
                });
            });
    }

    let coDialog2 = $("#coModal2").dialog({
        modal: true,
        autoOpen: false,
        width: 600,
        height: 600
    });

    $("#coSearchBtn2").on("click", function () {
        coDialog2.dialog("open");
        $("#coModal2").load("${pageContext.request.contextPath}/modal/comul");
    });

    function temp(val) {
    	
    	
        quarter = val.label.substr(0, 1); //몇분기인지(미사용)

        for (let inf of inferData) {
            if (inf.coNm == val.category) {
                
                if(inf.inferQtyFirst == null){
                	inf.inferQtyFirst = 0; 
                }
                if(inf.inferQtySecond == null){
                	inf.inferQtySecond = 0;
                }
                if(inf.inferQtyThird == null){
                	inf.inferQtyThird = 0;
                }
                if(inf.inferQtyFourth == null){
                	inf.inferQtyFourth = 0;
                }
                
            	const el = document.getElementById('pieChartDiv');
            	$('#pieChartDiv').empty();
                const data = {
                  categories: ['불량량'],
                  series: [
                    {
                      name: '1분기',
                      data: parseInt(inf.inferQtyFirst),
                    },
                    {
                      name: '2분기',
                      data: parseInt(inf.inferQtySecond),
                    },
                    {
                      name: '3분기',
                      data: parseInt(inf.inferQtyThird),
                    },
                    {
                      name: '4분기',
                      data: parseInt(inf.inferQtyFourth),
                    },
                  ],
                };
                const options = {
                  chart: { title: '불량량: '+val.category, width: 400, height: 400 },
                };

                const chart = toastui.Chart.pieChart({ el, data, options });
            }
        }
    }
</script>

</html>