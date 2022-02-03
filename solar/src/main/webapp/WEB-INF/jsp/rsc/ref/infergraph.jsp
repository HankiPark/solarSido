<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>
    <h1>자재 불량률</h1><hr>
    <div id="coModal" title="업체 목록"></div>
    <div class="card card-pricing card-primary card-white">
		<div class="card-body" >
   <div><label>연도</label>
<!--     <input type="text" id="year" value="2022"> -->
    <select id="year" value="${curYear }"></select></div>
   <label> 발주업체:</label> <input type="text" id="coCds" name="co"><button type="button" id="coSearchBtn">🔍</button>
    <button id="sendRequest" onclick="inferRequest()" style="margin-left:-10px">조회</button>
    </div>
    </div>
    <div class="flex row">
	    <div id="barChartDiv" class="row-1"></div>
	    <div id="pieChartDiv" class="row-1"></div>
    </div>
</body>
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
                        width: 750,
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

    let coDialog = $("#coModal").dialog({
        modal: true,
        autoOpen: false,
        width: 600,
        height: 600
    });

    $("#coSearchBtn").on("click", function () {
        coDialog.dialog("open");
        $("#coModal").load("${pageContext.request.contextPath}/modal/comul");
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
                  chart: { title: '불량량: '+val.category, width: 500, height: 400 },
                };

                const chart = toastui.Chart.pieChart({ el, data, options });
            }
        }
    }
</script>

</html>