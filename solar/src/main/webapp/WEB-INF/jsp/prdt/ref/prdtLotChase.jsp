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
	
			<div class="card card-pricing card-primary card-white col-8">
				<div class="card-body">
					<label> 조회중인 제품 LOT</label><br> <input id="prdtEndLot" type="text"
						readonly style="background-color:#fed4c2"><br><br>
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
						<div>
								<button id="search" type="button">조회</button>
								<button id="reset" type="button">초기화</button>
						</div>
					</div>
					
		</div>
		<div id="grid" class="col-3" style="display:none"></div>
	</div>

<div id="grid2" style="display:none"></div>
	

	<script type="text/javascript">
	
	$(function() {
		
		  $('input[name="startTOut"]').daterangepicker({
			  showDropdowns: true,
		    opens: 'right',
	
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
		  $('input[name="startTOut"]').val(null);
		  $('input[name="startTIndica"]').val(null);
		  $('input[name="startTIn"]').val(null);
		});
	
	
	
	
		//검색조건 펼치기
		function oen() {
			if (plain.style.display == 'none') {
				plain.style.display = 'block';
				test.innerText = '➤ 상세 검색 닫기';
				$("#det").val("Y");
			} else {
				plain.style.display = 'none';
				test.innerText = '➤ 상세 검색 열기';
				$("#det").val("N");
			}
		}
		//초기화 버튼
		$("#reset").on("click",function(){
			$('input').val('');
			$("#det").val("N");
			plain.style.display = 'none';
			test.innerText = '➤ 상세 검색 열기';
			$("#grid").css("display","none");
			$("#grid2").css("display","none");
			
		})
		//검색조건에 맞는 제품lot 검색
		$("#search").on("click",function(){
			
			var chk ='';
			
			if($("input:checkbox[name=ref]:checked").length==2){
				chk = '';
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
					'det' : $("#det").val()
			};
			if($("#startTOut").val()!=''){
				var startTOut = $("#startTOut").val().substring(0,10);
				var endTOut = $("#startTOut").val().substring(13,23);
				params.startTOut = startTOut;
				params.endTOut = endTOut;
				
			}
			if($("#startTIn").val()!=''){
				var startTIn = $("#startTIn").val().substring(0,10);
				var endTIn = $("#startTIn").val().substring(13,23);
				params.startTIn = startTIn;
				params.endTIn = endTIn;
			}
			if($("#startTIndica").val()!=''){
				var startTIndica = $("#startTIndica").val().substring(0,10);
				var endTIndica = $("#startTIndica").val().substring(13,23);
				params.startTIndica = startTIndica;
				params.endTIndica = endTIndica;
			}		
			$("#grid").css("display","block");

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
				minRowHeight : 40,
				rowHeight : 40,
				pageOptions : {
					useClient : true,
					perPage : 9
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
		grid.on('onGridUpdated', function() {
			$('td').css('backgroundColor','');
			grid.refreshLayout();
		});
	
		
		$(document).on('click','.tui-page-btn',function(){
			$('td').css('backgroundColor','');
		})
		
		grid.on('click',function(ev){
			if(grid.getValue(ev.rowKey,'prdtLot')!=null){
			$('td').css('backgroundColor','');

			$('td[data-row-key$="'+ev.rowKey+'"][data-column-name$="prdtLot"]').css('backgroundColor','#e37c6b');
			$('#prdtEndLot').val( grid.getValue(ev.rowKey,'prdtLot'));
			$("#grid2").css("display","block");
			grid2.readData(1,{'prdtLot' : grid.getValue(ev.rowKey,'prdtLot')},true);
			}
		})
		
		
		const grid2 = new tui.Grid(
			{
				el : document.getElementById('grid2'), // 컨테이너 엘리먼트
				data : {
					api : {
						readData : {
							url : '${pageContext.request.contextPath}/grid/prdtLotChase.do',
							method : 'GET'
						}
					},
					initialRequest : false,
					contentType : 'application/json'
				},

				rowHeaders : [ {
					type : 'rowNum',
					width : 100,
					align : 'left',
					valign : 'bottom'
				}],
				columns : [{
					header : '생산지시번호',
					name : 'indicaNo'
				},{
					header : '전표번호',
					name : 'slipNo'
				},{
					header : '주문서번호',
					name : 'orderNo'
				},{
					header : '소모자재 LOT',
					name : 'rscLot'
				}

				],
				

			});
		
		grid2.on('onGridUpdated', function() {
			$('td[data-column-name$="rscLot"]').css('backgroundColor','#ECC9AB');
			
			grid2.refreshLayout();
		});
		
	</script>
</body>
</html>