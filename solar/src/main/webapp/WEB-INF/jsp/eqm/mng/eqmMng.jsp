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
            padding: 5px;
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
           color: #e37c6b;
        }

        .tab_menu .list li.is_on .cont {
            display: block;
        }

        #oG {
            display: none;
        }
    </style>
</head>

<body>
	<h1>설비정보 관리</h1>
    <div class="wrap">
        <div class="tab_menu">
            <ul class="list">
                <li class="is_on"><a href="#" id="in" class="btn">조회</a></li>
                <li><a href="#" id="out" class="btn">등록</a></li>
            </ul>
        </div>
    </div>
    <div id="iG">
     <div class="row">
        <div
				class="card card-pricing card-primary card-white card-outline col-3" id="sensePrdtRefBody"
				style="margin-left: 50px; margin-right: 30px; margin-top: 120px; padding-left: 40px; margin-bottom: 300px;">
		<div class="card-body" >
                        <div style="margin-bottom: 20px; margin-top: 50px;">
                            <label>설비</label>
                            <input type="text" id="eqmParam" name="eqmParam" placeholder="설비코드 또는 설비명">
                        </div>
         <div style="margin-bottom: 20px;">               
                    <label for="defandroid">구매일</label>
                    <input name="datePicker" class="dtp" id="datePicker" type="text" data-role="datebox"
                        data-options='{"mode": "calbox"}'>
                </div>
         <div style="margin-bottom: 20px;">
                    <label>제품</label>
                    <input type="text" id="prdtCd">
                    <button type="button" id="btnPrdtCdFind" style="width: 33px">🔍</button>
                </div>
            </div>
            <div class="card-footer" style="margin-bottom: 30px;">
                <button type="button" id="findGrid" style="margin-left:120px">조회</button>
            </div>
</div>
<div class="col-8" style="margin-top:0px">
            <div class="float-right">
<!--                 <button type="button" id="insertBtn" class="btn btn-default btn-simple btn-sm">추가</button> -->
                <button type="button" id="updateBtn" class="btn btn-default btn-simple btn-sm" style="margin-bottom:10px">저장</button>
                <button type="button" id="deleteBtn" class="btn btn-default btn-simple btn-sm" style="margin-bottom:10px">삭제</button>
            </div>
            <div id="grid"></div>
        </div>
        
        <div id="prdtCdModal" title="제품 목록"></div>
    </div>
	</div>



    <div id="oG">


        <div class="card card-pricing card-primary card-white">
            <div class="card-body">
                <div class="container">
                    <div class="row">
                        <div class="col-2">설비코드 *</div>
                        <div class="col-4"><input type="text" id="eqmCd" name="eqmCd" style="width:90%" class="params requiredParams"></div>
                        <div class="col-2">설비구분 *</div>
                        <div class="col-4"><select name="eqmFg" id="eqmFg" style="width:90%" class="params requiredParams">
                                <option value="제조기">제조기</option>
                                <option value="레이저">레이저</option>
                                <option value="검사기">검사기</option>
                                <option value="세정기">세정기</option>
                            </select></div>
                        <div class="col-2">설비명 *</div>
                        <div class="col-4"><input type="text" id="eqmNm" name="eqmNm" style="width:90%" class="params requiredParams"></div>
                        <hr>
                    </div>

                    <div class="row">
                        <div class="col-2">모델 *</div>
                        <div class="col-4"><select name="eqmMdl" id="eqmMdl" style="width:90%" class="params requiredParams">
                                <option value="MEL-01">MEL-01</option>
                                <option value="MEL-02">MEL-02</option>
                                <option value="MEL-03">MEL-03</option>
                                <option value="MEL-04">MEL-04</option>
                            </select></div>
                        <div class="col-2">용량/규격 *</div>
                        <div class="col-4"><select name="eqmSpec" id="eqmSpec" style="width:90%" class="params requiredParams">
                                <option value="1000*1000">1000*1000</option>
                                <option value="1000*2000">1000*2000</option>
                                <option value="2000*1000">2000*1000</option>
                                <option value="3000*2000">3000*2000</option>
                            </select></div>
                        <div class="col-2">제작업체</div>
                        <div class="col-4"><input type="text" id="eqmCo" name="eqmCo" style="width:90%" class="params"></div>
                        <hr>
                    </div>
                    <div class="row">
                        <div class="col-2">구매일자 *</div>
                        <div class="col-4"><input class="dtp params requiredParams" name="purcDt" id="purcDt" type="text" data-role="datebox"
                                data-options='{"mode": "calbox"}' style="width:90%"></div>
                        <div class="col-2">구매금액 *</div>
                        <div class="col-4"><input type="text" name="purcAmt" id="purcAmt" style="width:90%" class="params requiredParams"></div>
                        <div class="col-2">라인번호 *</div>
                        <div class="col-4"><input type="text" name="liNo" id="liNo" style="width:90%" class="params requiredParams"></div>
                        <hr>
                    </div>
                    <div class="row">
                        <div class="col-2">작업자 *</div>
                        <div class="col-4"><input type="text" name="empId" id="empId" style="width:90%" class="params requiredParams"></div>
                        <div class="col-2">사용에너지</div>
                        <div class="col-4"><input type="text" name="energy" id="energy" style="width:90%" class="params"></div>
                        <div class="col-2">부하율</div>
                        <div class="col-4"><input type="text" name="lf" id="lf" style="width:90%" class="params"></div>
                        <hr>
                    </div>
                    <div class="row">
                        <div class="col-2">기준온도</div>
                        <div class="col-4"><input type="text" name="temp" id="temp" style="width:90%" class="params"></div>
                        <div class="col-2">UPH *</div>
                        <div class="col-4"><input type="text" name="uph" id="uph" style="width:90%" class="params requiredParams"></div>
                        <div class="col-2">공정코드 *</div>
                        <div class="col-4"><input type="text" name="prcsCd" id="prcsCd" style="width:90%" class="params requiredParams"></div>
                        <input type="hidden" id="eqmYn" name="eqmUn" style="width:90%" value="Y">
                    </div>
                </div>
                <div align="center">
	                <button type="button" id="btnSub" class="btn btn-default btn-simple btn-sm">추가</button>
                </div>
                <br>
            </div>
        </div>
        <h3>추가될 데이터</h3>
		<button type="button" id="removeRow" class="btn btn-default btn-simple btn-sm">삭제</button>
		<button type="button" id="btnPut" class="btn btn-default btn-simple btn-sm">저장</button>
        <div id="inputGrid"></div>



        <div id="dialog-form" title="제품명단"></div>
        <div id="dialog-sl" title="전표명단"></div>
        <div id="dialog-lot" title="입고대기명단"></div>
        <div id="dialog-outLot" title="출고대기명단"></div>
        <div id="dialog-ord" title="주문서명단"></div>
        <div id="dialog-outEndList" title="출고완료명단"></div>



        <script>
            //탭 설정
            let date = new Date();
            let dtEnd;// = date.toISOString().substr(0, 10);
            date.setDate(date.getDate() - 7);
            let dtStt;// = date.toISOString().substr(0, 10);

            const tabList = document.querySelectorAll('.tab_menu .list li');

            for (var i = 0; i < tabList.length; i++) {
                tabList[i].querySelector('.btn').addEventListener('click', function (e) {
                    e.preventDefault();
                    for (var j = 0; j < tabList.length; j++) {
                        tabList[j].classList.remove('is_on');
                    }
                    this.parentNode.classList.add('is_on');
                    if ($(this)[0].id == "in") {
                        $("#oG").css("display", "none");
                        $("#iG").css("display", "block");

                        grid.refreshLayout();

                    } else {
                        $("#iG").css("display", "none");
                        $("#oG").css("display", "block");
                        
                        inputGrid.refreshLayout();
                        
                    }
                });
            }



            $(function () {

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
                            monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월',
                                '12월'
                            ],
                            daysOfWeek: ['일', '월', '화', '수', '목', '금', '토'],
                            showMonthAfterYear: true,
                            yearSuffix: '년'
                        }
                    }, function (start, end, label) {
                        dtStt = start.format('YYYY-MM-DD');
                        dtEnd = end.format('YYYY-MM-DD');
                    },

                );
            });


            $(function () {

                $('input[name="purcDt"]').daterangepicker({
                        singleDatePicker: true,
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
                            monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월',
                                '12월'
                            ],
                            daysOfWeek: ['일', '월', '화', '수', '목', '금', '토'],
                            showMonthAfterYear: true,
                            yearSuffix: '년'
                        }
                    }, function (start, end, label) {
                    },
                    )
            }
            );


            var Grid = tui.Grid;
        	Grid.setLanguage('ko');
        	
            const dataSource = {
                api: {
                    readData: {
                    	url: '${pageContext.request.contextPath}/grid/eqmList.do',
                    	method: 'GET',
                    	initParams: {
                            'eqmParam': document.getElementById('eqmParam').value,
                            'eqmParam2': 1,
                            'dtStt': dtStt,
                            'dtEnd': dtEnd,
                    		}},
                    modifyData: {url: '${pageContext.request.contextPath}/eqm/grid/eqmPut',method: 'PUT'} 
                },
                contentType: 'application/json'
            };
            const inputDataSource = {
                    api: {
                        readData: {url: '',method: 'GET'},
    					modifyData: {url: '${pageContext.request.contextPath}/eqm/grid/eqmPut',method: 'PUT'}
                    },
  				  contentType : 'application/json',
				  initialRequest: false
                };

            const grid = new Grid({
                el: document.getElementById('grid'),
                data: dataSource,
                rowHeaders: ['checkbox'],
                minBodyHeight : 500,
                bodyHeight: 500,
                columns: [{
                        header: '설비코드',
                        name: 'eqmCd',
                        align: 'center',
                    },
                    {
                        header: '설비구분',
                        name: 'eqmFg',
                        align: 'center',
                        editor:{
                        	type: 'select',
                        	options: {
                        		listItems: [
                        			{text: '제조기',value: '제조기'},
                        			{text: '레이저',value: '레이저'},
                        			{text: '검사기',value: '검사기'},
                        			{text: '세정기',value: '세정기'},
                        			]
                        	}
                        },
                    },
                    {
                        header: '설비명',
                        name: 'eqmNm',
                        editor: 'text',
                        align: 'center',
                    },
                    {
                        header: '모델',
                        name: 'eqmMdl',
                        align: 'center',
                        editor:{
                        	type: 'select',
                        	options: {
                        		listItems: [
                        			{text: 'MEL-01',value: 'MEL-01'},
                        			{text: 'MEL-02',value: 'MEL-02'},
                        			{text: 'MEL-03',value: 'MEL-03'},
                        			{text: 'MEL-04',value: 'MEL-04'},
                        			]
                        	}
                        },
                    },
                    {
                        header: '용량/규격',
                        name: 'eqmSpec',
                        align: 'center',
                        editor:{
                        	type: 'select',
                        	options: {
                        		listItems: [
                        			{text: '1000*1000',value: '1000*1000'},
                        			{text: '1000*2000',value: '1000*2000'},
                        			{text: '2000*1000',value: '2000*1000'},
                        			{text: '3000*2000',value: '3000*2000'},
                        			]
                        	}
                        },
                    },
                    {
                        header: '제작업체',
                        name: 'eqmCo',
                        editor: 'text',
                        align: 'center',
                    },
                    {
                        header: '구매일자',
                        name: 'purcDt',
                        editor: 'text',
                        align: 'center',
                    },
                    {
                        header: '구매금액',
                        name: 'purcAmt',
                        editor: 'text',
                        align: 'center',
                    },
                    {
                        header: '라인번호',
                        name: 'liNo',
                        editor: 'text',
                        align: 'center',
                    },
                    {
                        header: '작업자',
                        name: 'empId',
                        editor: 'text',
                        align: 'center',
                        hidden: true,
                    },
                    {
                        header: '사용에너지',
                        name: 'energy',
                        editor: 'text',
                        align: 'center',
                    },
                    {
                        header: '부하율',
                        name: 'lf',
                        editor: 'text',
                        align: 'center',
                    },
                    {
                        header: '기준온도',
                        name: 'temp',
                        editor: 'text',
                        align: 'center',
                    },
                    {
                        header: 'UPH',
                        name: 'uph',
                        editor: 'text',
                        align: 'center',
                    },
                    {
                        header: '공정코드',
                        name: 'prcsCd',
                        editor: 'text',
                        align: 'center',
                        hidden: true,
                    },
        			{
        				header: '가동여부',
        				name: 'eqmYn',
        				align: 'center',
        				hidden: true,
        				formatter({value}) {
        					if(value=='Y'){
        						return '가동';
        					} else if(value=='P'){
        						return '운용중';
        					} else {
        						return '비가동';
        					}
        			    }
        			},
                ]
            });

            const inputGrid = new Grid({
                el: document.getElementById('inputGrid'),
                data: inputDataSource,
                rowHeaders: ['checkbox','rowNum'],
                columns: [{
                        header: '설비코드',
                        name: 'eqmCd',
                        align: 'center',
                    },
                    {
                        header: '설비구분',
                        name: 'eqmFg',
                        align: 'center',
                    },
                    {
                        header: '설비명',
                        name: 'eqmNm',
                        align: 'center',
                    },
                    {
                        header: '라인번호',
                        name: 'eqmMdl',
                        align: 'center',
                    },
                    {
                        header: '용량/규격',
                        name: 'eqmSpec',
                        align: 'center',
                    },
                    {
                        header: '제작업체',
                        name: 'eqmCo',
                        align: 'center',
                    },
                    {
                        header: '구매일자',
                        name: 'purcDt',
                        align: 'center',
                    },
                    {
                        header: '구매금액',
                        name: 'purcAmt',
                        align: 'center',
                    },
                    {
                        header: '라인번호',
                        name: 'liNo',
                        align: 'center',
                    },
                    {
                        header: '작업자',
                        name: 'empId',
                        align: 'center',
                    },
                    {
                        header: '사용에너지',
                        name: 'energy',
                        align: 'center',
                    },
                    {
                        header: '부하율',
                        name: 'lf',
                        align: 'center',
                    },
                    {
                        header: '기준온도',
                        name: 'temp',
                        align: 'center',
                    },
                    {
                        header: 'UPH',
                        name: 'uph',
                        align: 'center',
                    },
                    {
                        header: '공정코드',
                        name: 'prcsCd',
                        align: 'center',
                    },
                    {
                        header: '가동여부',
                        name: 'eqmYn',
                        align: 'center',
                    },
                ]
            });
            
            grid.on('onGridUpdated', function () {
                grid.refreshLayout();
            });

            let prdtCdDialog = $("#prdtCdModal").dialog({
                autoOpen: false,
                modal: true,
                width: 600,
                height: 600
            });
            $('#btnPrdtCdFind').on('click', function () {
                prdtCdDialog.dialog("open");
                $("#prdtCdModal").load("${pageContext.request.contextPath}/modal/findPrdtCd", function () {
                    prdtCdList();
                })
            });

            let findGrid = document.getElementById('findGrid');
            findGrid.addEventListener('click', function () {
                grid.readData(1, {
                    'eqmParam': document.getElementById('eqmParam').value,
                    'eqmParam2': 1,
                    'dtStt': dtStt,
                    'dtEnd': dtEnd,
                });
            });
            
            let btnSub = document.getElementById('btnSub');
            btnSub.addEventListener('click',function(){
            	
                    let params = document.getElementsByClassName('params');
                    let requiredParams = document.getElementsByClassName('requiredParams');
                    for(let param of requiredParams){
                    	if(param.value == '' || param.value == null){
                    		toastr.warning('필수항목들을 입력해주세요');
                    		param.focus();
                    		return false;
                    	}
                    }
                    
            	inputGrid.prependRow({
            		'eqmCd': params[0].value,
            		'eqmFg': params[1].value,
            		'eqmNm': params[2].value,
            		'eqmMdl': params[3].value,
            		'eqmSpec':params[4].value,
            		'eqmCo': params[5].value,
            		'purcDt': params[6].value,
            		'purcAmt': params[7].value,
            		'liNo': params[8].value,
            		'empId': params[9].value,
            		'energy': params[10].value,
            		'lf': params[11].value,
            		'temp': params[12].value,
            		'uph': params[13].value,
            		'prcsCd': params[14].value,
            		'eqmYn': 'Y'
            	});
            });
            
            let btnPut = document.getElementById('btnPut');
            btnPut.addEventListener('click',function(){
            	inputGrid.request('modifyData');
            });
            
            inputGrid.on('response',function(ev){
            	let result = JSON.parse(ev.xhr.response);
            	result = result.queryResult;
            	if(result.length!=0){
	            	if(result != 'true'){
	            		toastr.success('설비코드가 중복된 데이터를 <br>제외하고 저장되었습니다.<br>중복된 설비코드: <br>[ '+result+' ]');
	            		
// 	            		let duplCds = result.split(',');
// 	            		console.log(duplCds);
// 	            		let rowCnt = inputGrid.getRowCount()-1;
// 	            		inputGrid.uncheckAll();
// 	            		for(let i = 0; i < rowCnt; i++){
// 	            			console.log(inputGrid.getValue(i,'eqmCd'));
// 	            			if(!duplCds.includes(inputGrid.getValue(i,'eqmCd'))){
// 	            				inputGrid.check(i);
// 	            			}
// 	            		}
// 	            		inputGrid.removeCheckedRows();
            		}
	            		
            	} else {
            		toastr.success('모두 저장되었습니다.');
            	}
            });
            
            let deleteBtn = document.getElementById('deleteBtn');
            let removeRow = document.getElementById("removeRow");
            deleteBtn.addEventListener('click',function(){ deleteRows(grid); });
            removeRow.addEventListener("click",function(){ deleteRows(inputGrid); });
            
            function deleteRows(thisGrid) {
            	let checkedRowKeys = thisGrid.getCheckedRowKeys();
            	for(let rowkey of checkedRowKeys){
            		thisGrid.removeRow(rowkey);
            		}
            }
            
            grid.on('click',function(ev){
            	$('#insertBtn').daterangepicker({
                    singleDatePicker: true,
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
                        monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월',
                            '12월'
                        ],
                        daysOfWeek: ['일', '월', '화', '수', '목', '금', '토'],
                        showMonthAfterYear: true,
                        yearSuffix: '년'
                    }
                }, function (start, end, label) {
                },

            );
            });
            
            
            let updateBtn = document.getElementById('updateBtn');
            updateBtn.addEventListener('click',function(){
            	grid.request('modifyData');
            });
        </script>
</body>

</html>