<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<label for="defandroid">날짜 선택</label> <input name="startT2"
					id="startT2" type="date" data-role="datebox"
					data-options='{"mode": "calbox"}'> ~ <input name="endT2"
					id="endT2" type="date" data-role="datebox"
					data-options='{"mode": "calbox"}'>
<label>제품명</label> <input type="text" id="prdNm2">
<button type="button" id="btnF">찾기</button>
<div id="inWaitGrid"></div>
<script type="text/javascript">
	//날짜설정
var d = new Date();
var nd = new Date(d.getFullYear(), d.getMonth(), d.getDate() - 7);
document.getElementById('startT2').value = nd.toISOString().slice(0, 10);
document.getElementById('endT2').value = d.toISOString().slice(0, 10);
	
	
	//modal
	function prdtInWait(lotno){
		const inWaitGrid = new tui.Grid({
			el : document.getElementById('inWaitGrid'), // 컨테이너 엘리먼트
			data : null,
			bodyHeight : 700,
			
			columns : [ {
				header : '완료일자',
				name : 'prdtDt',
				
			}, {
				header : '제품LOT',
				name : 'prdtLot',
				editor : 'text'
			}, {
				header : '제품코드',
				name : 'prdtCd'
			}, {
				header : '제품명',
				name : 'prdtNm',
			}, {
				header : '생산지시번호',
				name : 'indicaNo'
			}

			],

		});
		//그리드 값변하면 다시 뿌려주게끔
		inWaitGrid.on('onGridUpdated', function() {
			inWaitGrid.refreshLayout();
		});
		//검색버튼누를시
		$('#btnF').on('click',function(){
			
			var startT2 = $("#startT2").val();
			var endT2 = $("#endT2").val();
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
				console.log(res);
				var sres = JSON.parse(res);
				inWaitGrid.resetData(sres["data"]["contents"]);
			})
	});
	}
</script>
</body>
</html>