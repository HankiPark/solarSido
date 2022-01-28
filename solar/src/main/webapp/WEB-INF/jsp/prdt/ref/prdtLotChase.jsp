<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
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
		top:-2px;
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
		top:-2px;
		left:-1px;
        background-color: #e37c6b;
        color:#fff;
         margin-bottom:0px;
      }

</style>
</head>

<body>
	<h1>제품 LOT 추적</h1>
	<div class="row">
	
			<div class="card card-pricing card-primary card-white col-9">
				<div class="card-body">
					<label> 조회중인 제품 LOT</label><br> <input id="prdtLot" type="text"
						readonly><br><br>
						<div class="row">
						<div class="col-1"><label> 제품 LOT</label></div><div class="col-3"> <input type="text" id="prdtLot" name="prdtLot" style="width:90%" ></div>
						<div class="col-1"><label>제품 종류</label></div><div class="col-3"> <input type="text" id="prdtCd" name="prdtCd" style="width:90%" ></div>
						<div class="col-1"><label>제품 현황</label></div><div class="col-3"> <label><input type="checkbox" name="ref" id="inref"
						value="I"><label for="inref"></label>입고</label> <label><input type="checkbox" id="outref"
						name="ref" value="O"><label for="outref"></label>출고</label></div> 
						</div><br><br>
						<label><span id="test"	style="CURSOR: hand" onclick="oen()"> ➤상세 검색 열기</span></label>
						<input type="hidden" id="det" name="det" value="N">
						
						<div id="plain" style="display: none">
							<div class="row">
								<div class="col-2"><label >출고일자</label></div> <div class="col-4"><input name="startTOut"
									class="dtp" id="startTOut" type="text" data-role="datebox" style="width:90%" 
									data-options='{"mode": "calbox"}'></div>
							<div class="col-2"><label >공정작업번호</label></div> <div class="col-4"><input type="text" id="prdtWk" style="width:90%" ></div>
							
									
							</div>
							<div class="row">
									<div class="col-2"><label>입고일자</label></div> <div class="col-4"><input name="startTIn"
									class="dtp" id="startTIn" type="text" data-role="datebox" style="width:90%" 
									data-options='{"mode": "calbox"}'></div>
								<div class="col-2"><label >생산지시번호</label></div> <div class="col-4"><input type="text" id="prdtIndica" style="width:90%" ></div>
								
							
								
								</div>
							<div class="row">
								<div class="col-2"><label>지시일자</label></div> <div class="col-4"><input name="startTIndica"
									class="dtp" id="startTIndica" type="text" data-role="datebox" style="width:90%" 
									data-options='{"mode": "calbox"}'></div>
								<div class="col-2"><label >출고전표번호</label></div> <div class="col-4"><input type="text" id="prdtOust" style="width:90%" ></div>
								
							</div>
							<div class="row">
								<div class="col-2"><label >주문서번호</label></div> <div class="col-4"><input type="text" id="prdtOrder" style="width:90%" ></div>
								<div class="col-2"><label >자재LOT</label></div> <div class="col-4"><input type="text" id="prdtRsc" style="width:90%" >	</div>
							</div>
							<div>
								
							</div>
							
						</div>
					</div>
				<button id="search" type="button">조회</button>
				<button id="reset" type="button">초기화</button>
		
		</div>
		<div id="grid" class="col-3"></div>
	</div>


	

	<div id="dialog-prdtLot" title="제품 LOT 조회"></div>
	<script type="text/javascript">
	$(function() {
		
		  $('input[name="startTOut"]').daterangepicker({
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
		  }		  
		  );
		  $('input[name="startTIn"]').daterangepicker({
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
		  }		  
		  );
		  $('input[name="startTIndica"]').daterangepicker({
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
		  }		  
		  );
		});
	
	
	
	
		//검색조건 펼치기
		function oen() {
			if (plain.style.display == 'none') {
				plain.style.display = 'block';
				test.innerText = '➤ 상세 검색 열기';
				$("#det").val("Y");
			} else {
				plain.style.display = 'none';
				test.innerText = '➤ 상세 검색 끄기';
				$("#det").val("N");
			}
		}
		
		//검색조건에 맞는 제품lot 검색
		$("#search").on("click",function(){
			var startTOut=null;
			var startTIn=null;
			var startTIndica=null;
			var endTOut=null;
			var endTIn=null;
			var endTIndica=null;
			var chk =null;
			if($("#startTOut")!=null){
				startTOut = $("#startTOut").val().substring(0,10);
				endTOut = $("#startTOut").val().substring(13,23);
			}
			if($("#startTIn")!=null){
				startTIn = $("#startTIn").val().substring(0,10);
				endTIn = $("#startTIn").val().substring(13,23);
			}
			if($("#startTIndica")!=null){
				startTIndica = $("#startTIndica").val().substring(0,10);
				endTIndica = $("#startTIndica").val().substring(13,23);
			}
			if($("input:checkbox[name=ref]:checked").length==2){
				chk = null;
			}else if($('input:checkbox[name=ref]:checked').val()=='O'){
				chk = $('input:checkbox[name=ref]:checked').val();
			}else{
				chk = $('input:checkbox[name=ref]:checked').val();	
			}
			
			
			var params = {
					'prdtLot' : $("#prdtLot").val(),
					'prdtCd' : $("#prdtCd").val(),
					'prdtFg' : chk,
					'wkNo' : $("#prdtWk").val(),
					'indicaNo' : $("#prdtIndica").val(),
					'slipNo' : $("#prdtOust").val(),
					'orderNo' : $("#prdtOrder").val(),
					'rscLot' : $("#prdtRsc").val(),
					'startTOut' : startTOut,
					'endTOut' : endTOut,
					'startTIn' : startTIn,
					'endTIn' : endTIn,
					'startTIndica' : startTIndica,
					'endTIndica' : endTIndica
			};
			
			grid.readData(1,params,true);
			
		})
		const grid = new tui.Grid(
			{
				el : document.getElementById('grid'), // 컨테이너 엘리먼트
				data : {
					api : {
						readData : {
							url : '${pageContext.request.contextPath}/grid/prdtLotChaseList.do',
							method : 'GET'
						}
					},
					initialRequest : false,
					contentType : 'application/json'
				},

				bodyHeight : 400,
				rowHeaders : [ {
					type : 'rowNum',
					width : 100,
					align : 'left',
					valign : 'bottom'
				}],
				columns : [{
					header : '제품 LOT',
					name : 'prdtLot'
				}

				],
				

			});
		
	</script>
</body>
</html>