<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


</head>
<body>

<label for="defandroid">날짜 선택</label> <input name="startT2" class="dtp"
					id="startT2" type="text" data-role="datebox"
					data-options='{"mode": "calbox"}'> 
<label>제품명</label> <input type="text" id="prdNm2">
<button type="button" id="btnF">조회</button>
<button type="button" id="btnFAll" style="width:80px;height:33px;border-radius:5px;padding:6px 1px 6px 3px;box-shadow:2px 2px 2px #74a3b0">전량입고</button>
<div id="inWaitGrid"></div>
<script type="text/javascript">
	//날짜설정
/* var d = new Date();
var nd = new Date(d.getFullYear(), d.getMonth(), d.getDate() - 7);
document.getElementById('startT2').value = nd.toISOString().slice(0, 10);
document.getElementById('endT2').value = d.toISOString().slice(0, 10); */
$(function() {
	
	  $('input[name="startT2"]').daterangepicker({
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
	
	//modal
	function prdtInWait(key){
	
	
	
	
		const inWaitGrid = new tui.Grid({
			el : document.getElementById('inWaitGrid'), // 컨테이너 엘리먼트
			data : null,
			bodyHeight : 700,
			data : {
				api : {
					readData : {
						url : '${pageContext.request.contextPath}/grid/prdtInput.do',
						method : 'GET'
					},
					modifyData : {
						url : '${pageContext.request.contextPath}/grid/prdtInputUpdate.do',
						method : 'POST',
						cache : false
					}
				},
				initialRequest : false,
				contentType : 'application/json'
			},
			columns : [ {
				header : '완료일자',
				name : 'prdtDt',
				align : 'center'
				
			}, {
				header : '제품LOT',
				name : 'prdtLot',
				align : 'center'
				
			}, {
				header : '제품코드',
				name : 'prdtCd',
				align : 'center'
			}, {
				header : '제품명',
				name : 'prdtNm',
				align : 'center'
			}, {
				header : '규격',
				name : 'prdtSpec',
				hidden: true,
				align : 'center'
			}, {
				header : '생산지시번호',
				name : 'indicaNo',
				align : 'center'
			}

			],

		});
		//그리드 값변하면 다시 뿌려주게끔
		inWaitGrid.on('onGridUpdated', function() {
			inWaitGrid.refreshLayout();
		});
		//검색버튼누를시
		$('#btnF').on('click',function(){
			
			var startT2 = $("#startT2").val().substring(0,10);
			var endT2 = $("#startT2").val().substring(13,23);
			var prdNm2 = $("#prdNm2").val();
			var params ={'startT':startT2,
					'endT':endT2,
					'prdNm':prdNm2,
					'prdSt':'C'
					}
			
			$.ajax({
				url:'${pageContext.request.contextPath}/grid/prdtInput.do',
				data: params,
				contentType: 'application/json; charset=utf-8',
				
				
			}).done(function(res){
				var sres = JSON.parse(res);
				inWaitGrid.resetData(sres["data"]["contents"]);
			})
	});
		
		inWaitGrid
		.on(
				'dblclick',
				function(ev) {
					if(ev["rowKey"]!=null){
					inGrid.setValue(key,'prdtLot',inWaitGrid.getValue(ev["rowKey"],"prdtLot"));
					inGrid.setValue(key,'prdtCd',inWaitGrid.getValue(ev["rowKey"],"prdtCd"));
					inGrid.setValue(key,'prdtNm',inWaitGrid.getValue(ev["rowKey"],"prdtNm"));
					inGrid.setValue(key,'prdtSpec',inWaitGrid.getValue(ev["rowKey"],"prdtSpec"));
					inGrid.setValue(key,'indicaNo',inWaitGrid.getValue(ev["rowKey"],"indicaNo"));
					dialog2.dialog("close");
					}
				});
		
		
		$('#btnFAll').on('click',function(){
			inWaitGrid.request('modifyData',{'modifiedOnly':false});
			inGrid.clear();
			dialog2.dialog("close");
		})
		
		
		
	}
</script>
</body>
</html>